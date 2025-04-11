//testbench skeleton
`include "ddr3_if.sv"

module ddr3_tb;
  logic clk = 0;
  always #5 clk = ~clk;

  ddr3_if intf(clk);
  // Assume DUT is instantiated as: ddr3_ctrl dut(.clk(clk), .if(intf));

  initial begin
    intf.rst = 1; #20; intf.rst = 0;
    // Simulate command sequences
    repeat (10) begin
      @(posedge clk);
      intf.cmd_valid = 1;
      intf.cmd = $urandom_range(0, 5);  // ACT, RD, WR, PRECH, REF, NOP
      intf.addr = $urandom();
      intf.data = $urandom();
    end
    $finish;
  end

  // Assertion: NOP should not be followed by ACT directly
  property no_nop_to_act;
    @(posedge clk) disable iff (intf.rst)
    (intf.cmd == 3'b101 && intf.cmd_valid) |=> !(intf.cmd == 3'b000);
  endproperty
  assert property (no_nop_to_act);

  // Coverage
  covergroup ddr3_cmds;
    coverpoint intf.cmd;
  endgroup
  ddr3_cmds d3 = new();
endmodule
