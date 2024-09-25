`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.07.2024 19:52:07
// Design Name: 
// Module Name: g1
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


module gauss(
    input clk,
    input rst,
    input [7:0] in0,
    input [7:0] in1,
    input [7:0] in2,
    output reg [7:0] out_data
);
    wire [9:0] R0,R1,R2;
    reg [11:0] t1;
    reg [11:0] t2;

    reg [11:0] s1,s2,s3;

    reg [11:0] t3;
    reg [11:0] t4;

    assign R0 = {{2{1'b0}},in0};
    assign R1 = {{2{1'b0}},in1};
    assign R2 = {{2{1'b0}},in2};

    always @(posedge clk) begin
        if(rst) begin
            t1 <= 0;
            t2 <= 0;
            t3 <= 0;
            t4 <= 0;
            s1 <= 0;
            s2 <= 0;
            s3 <= 0;
            out_data <= 0;
        end

        else begin

            t2 <= R0 + (R1<<1);
            t1 <= R2;
            s3 <= t1 + t2;
            s2 <= (s3<<1);
            s1 <= (s2>>1);
            t4 <= s2 + s3;
            t3 <= s1;
            out_data <= (t3 + t4)>>4;
            // out_data <= (t3 + t4);
        end
    end

endmodule