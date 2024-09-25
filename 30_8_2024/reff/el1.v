`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.07.2024 19:59:25
// Design Name: 
// Module Name: el1
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


module edge_linking(
    input clk,
    input rst,
    input [2:0] R0,
    input [2:0] R1,
    input [2:0] R2,
    output reg [7:0] out_data
//    output beat
);

    reg [2:0] s3[2:0];
    reg [2:0] s2[2:0];
    reg [2:0] s1[2:0];
    
    always @(posedge clk) begin
        
        if(rst) begin
            s1[0] <= 20'd0;
            s1[1] <= 20'd0;
            s1[2] <= 20'd0;
            
            s2[0] <= 20'd0;
            s2[1] <= 20'd0;
            s2[2] <= 20'd0;
            
            s3[0] <= 20'd0;
            s3[1] <= 20'd0;
            s3[2] <= 20'd0;
        end
        
        else begin
            s3[0] <= R0;
            s3[1] <= R1;
            s3[2] <= R2;

            s2[0] <= s3[0];
            s2[1] <= s3[1];
            s2[2] <= s3[2];

            s1[0] <= s2[0];
            s1[1] <= s2[1];
            s1[2] <= s2[2];
        end
    end

    always @(*) begin
        if((s3[0][2] || s3[1][2] || s3[2][2] || s2[0][2] || s2[2][2] || s1[0][2] || s1[1][2] || s1[2][2]) && (s2[1][1])) out_data <= 255;
        else if(s2[1][2]) out_data <= 255;
        else out_data <= 0;
    end

endmodule