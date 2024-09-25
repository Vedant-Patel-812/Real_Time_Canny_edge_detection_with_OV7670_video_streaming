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

module line_buffer_506(
    input clk,
    input rst,
    input ld,
    input [2:0] PixelData,
    output reg [2:0] out_data1,
    output reg [2:0] out_data2,
    output reg [2:0] out_data3
);

parameter size = 320;
//parameter size = 640;

reg [2:0] Shift1 [size-1:0];
reg [2:0] Shift2 [size-1:0];

integer i;

always @(posedge clk) begin
    if(rst) begin
        out_data1 <= 3'b000;
        out_data2 <= 3'b000;
        out_data3 <= 3'b000;
        
        for (i = 0; i < size; i = i + 1) begin
            Shift1[i] <= 3'd0;
        end
        for (i = 0; i < size; i = i + 1) begin
            Shift2[i] <= 3'd0;
        end
    end
    
    else begin
        if(ld) begin
            Shift1[0] <= PixelData;
            for (i = 1; i < size; i = i + 1) begin
                Shift1[i] <= Shift1[i - 1];
            end

            Shift2[0] <= Shift1[size-1];
            for (i = 1; i < size; i = i + 1) begin
                Shift2[i] <= Shift2[i - 1];
            end
        end
        
        out_data3 <= PixelData;
        out_data2 <= Shift1[size-1];
        out_data1 <= Shift2[size-1];
    end
end

endmodule