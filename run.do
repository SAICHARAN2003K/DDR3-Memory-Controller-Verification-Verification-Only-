vlib work
vlog ddr3_if.sv
vlog ddr3_tb.sv
vsim -voptargs=+acc ddr3_tb
add wave -r *
run -all
