//interface
interface ddr3_if(input logic clk);
  logic rst;
  logic cmd_valid;
  logic [2:0] cmd;
  logic [31:0] addr, data;
endinterface
