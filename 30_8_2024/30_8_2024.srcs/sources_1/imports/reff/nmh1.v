`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.07.2024 19:58:46
// Design Name: 
// Module Name: nmh1
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

module non_max_hyst(
    input clk,
    input rst,
    input [19:0] R0,
    input [19:0] R1,
    input [19:0] R2,
    input [1:0] in_angle,
    input [19:0] TH,
    output reg [2:0] out_data
);

    reg [19:0] s3[3:0];
    reg [19:0] s2[3:0];
    reg [19:0] s1[3:0];

    reg [19:0] a,b;

    wire [1:0] temp;
    wire [19:0] out_non_max;

    reg [19:0] T_high, T_low;
//    parameter HM = 0.125, LM = 0.065;
    parameter HM = 125, LM = 65;

    always @(posedge clk) begin

            T_high <= TH * HM / 1000;
            T_low <= TH * LM / 1000; 

            s3[0] <= R0;
            s3[1] <= R1;
            s3[2] <= R2;
            s3[3] <= in_angle;

            s2[0] <= s3[0];
            s2[1] <= s3[1];
            s2[2] <= s3[2];
            s2[3] <= s3[3];

            s1[0] <= s2[0];
            s1[1] <= s2[1];
            s1[2] <= s2[2];
            s1[3] <= s2[3];
    end

    always @(*) begin

        case (s2[3])
            0 : begin
              a <= s2[0];
              b <= s2[2];
            end
            1 : begin
              a <= s1[2];
              b <= s3[0];
            end
            2 : begin
              a <= s1[1];
              b <= s3[1];
            end
            3 : begin
              a <= s1[0];
              b <= s3[2];
            end
            default: begin
              a <= 0;
              b <= 0;
            end
        endcase

    end

    assign out_non_max = ((s2[1]>a)&&(s2[1]>b) ? s2[1] : 0);
    assign temp = {(out_non_max>T_low),(out_non_max>T_high)};

    always @(*) begin
        case (temp)
            0 : out_data <= 3'b001;
            2 : out_data <= 3'b010;
            3 : out_data <= 3'b100;
            default: out_data <= 3'b000;
        endcase
    end

endmodule