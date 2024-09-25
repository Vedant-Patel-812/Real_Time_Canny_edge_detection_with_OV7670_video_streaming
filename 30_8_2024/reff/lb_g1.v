`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.07.2024 19:53:57
// Design Name: 
// Module Name: lb_s1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module line_buffer_514(
    input clk,
    input rst,
    input ld,
    input [7:0] PixelData,
    output reg [7:0] out_data1,
    output reg [7:0] out_data2,
    output reg [7:0] out_data3
);

//parameter size = 640;
parameter size = 514;

reg [7:0] Shift1 [size-1:0];
reg [7:0] Shift2 [size-1:0];
//reg [7:0] a1,a2,a3,a4,a5,a6,a7;

integer i;

always @(posedge clk) begin

    if(rst) begin
        out_data1 <= 8'b00000000;
        out_data2 <= 8'b00000000;
        out_data3 <= 8'b00000000;
        
        for (i=0; i<size; i=i+1) begin
            Shift1[i] <= 8'd0;
            Shift2[i] <= 8'd0;
        end
    end
    
    else begin
        if(ld) begin
            Shift1[0] <= PixelData;
            Shift2[0] <= Shift1[size-1];
//            a1 <= PixelData;
//            a2 <= a1;
//            a3 <= a2;
//            a4 <= a3;
//            a5 <= a4;
//            a6 <= a5;
            for (i = 1; i < size; i=i+1) begin
                Shift1[i] <= Shift1[i - 1];
                Shift2[i] <= Shift2[i - 1];
            end
        end
        out_data3 <= PixelData;
        out_data2 <= Shift1[size-1];
        out_data1 <= Shift2[size-1];
    end
end

endmodule