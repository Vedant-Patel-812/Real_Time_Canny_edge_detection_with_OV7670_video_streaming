// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
// Date        : Fri Aug 30 16:29:23 2024
// Host        : You-Know-Nothing running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {c:/Users/patel/Desktop/--/sem7/internship/ankur
//               sir/30_8_2024/30_8_2024.gen/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0_stub.v}
// Design      : blk_mem_gen_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_8,Vivado 2024.1" *)
module blk_mem_gen_0(clka, ena, wea, addra, dina, clkb, enb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="ena,wea[0:0],addra[16:0],dina[11:0],enb,addrb[16:0],doutb[11:0]" */
/* synthesis syn_force_seq_prim="clka" */
/* synthesis syn_force_seq_prim="clkb" */;
  input clka /* synthesis syn_isclock = 1 */;
  input ena;
  input [0:0]wea;
  input [16:0]addra;
  input [11:0]dina;
  input clkb /* synthesis syn_isclock = 1 */;
  input enb;
  input [16:0]addrb;
  output [11:0]doutb;
endmodule
