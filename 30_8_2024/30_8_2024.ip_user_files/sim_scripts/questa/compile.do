vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xpm
vlib questa_lib/msim/blk_mem_gen_v8_4_8
vlib questa_lib/msim/xil_defaultlib

vmap xpm questa_lib/msim/xpm
vmap blk_mem_gen_v8_4_8 questa_lib/msim/blk_mem_gen_v8_4_8
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xpm  -incr -mfcu  -sv "+incdir+../../../30_8_2024.gen/sources_1/ip/clock_wiz_25" \
"C:/Xilinx/Vivado/2024.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/Vivado/2024.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm  -93  \
"C:/Xilinx/Vivado/2024.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work blk_mem_gen_v8_4_8  -incr -mfcu  "+incdir+../../../30_8_2024.gen/sources_1/ip/clock_wiz_25" \
"../../ipstatic/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../30_8_2024.gen/sources_1/ip/clock_wiz_25" \
"../../../30_8_2024.gen/sources_1/ip/blk_mem_gen_0/sim/blk_mem_gen_0.v" \
"../../../30_8_2024.gen/sources_1/ip/clock_wiz_25/clock_wiz_25_clk_wiz.v" \
"../../../30_8_2024.gen/sources_1/ip/clock_wiz_25/clock_wiz_25.v" \
"../../../30_8_2024.srcs/sources_1/imports/reff/I2C_Controller2.v" \
"../../../30_8_2024.srcs/sources_1/imports/reff/I2C_OV7670_RGB565_Config2.v" \
"../../../30_8_2024.srcs/sources_1/imports/reff/OV7670_init.v" \
"../../../30_8_2024.srcs/sources_1/imports/reff/ov7670_capture.v" \
"../../../30_8_2024.srcs/sources_1/imports/reff/vga.v" \
"../../../30_8_2024.srcs/sources_1/imports/reff/OV7670_top.v" \

vlog -work xil_defaultlib \
"glbl.v"

