-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
-- Date        : Fri Aug 30 16:27:46 2024
-- Host        : You-Know-Nothing running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub {c:/Users/patel/Desktop/--/sem7/internship/ankur
--               sir/30_8_2024/30_8_2024.gen/sources_1/ip/clock_wiz_25/clock_wiz_25_stub.vhdl}
-- Design      : clock_wiz_25
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock_wiz_25 is
  Port ( 
    clk_out_25 : out STD_LOGIC;
    clk_in_100 : in STD_LOGIC
  );

end clock_wiz_25;

architecture stub of clock_wiz_25 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_out_25,clk_in_100";
begin
end;
