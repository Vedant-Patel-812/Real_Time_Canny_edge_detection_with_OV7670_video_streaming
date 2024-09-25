// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
// Date        : Fri Aug 30 16:27:46 2024
// Host        : You-Know-Nothing running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {c:/Users/patel/Desktop/--/sem7/internship/ankur
//               sir/30_8_2024/30_8_2024.gen/sources_1/ip/clock_wiz_25/clock_wiz_25_stub.v}
// Design      : clock_wiz_25
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clock_wiz_25(clk_out_25, clk_in_100)
/* synthesis syn_black_box black_box_pad_pin="clk_in_100" */
/* synthesis syn_force_seq_prim="clk_out_25" */;
  output clk_out_25 /* synthesis syn_isclock = 1 */;
  input clk_in_100;
endmodule
