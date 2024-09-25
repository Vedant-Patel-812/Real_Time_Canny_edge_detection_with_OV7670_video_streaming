`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.08.2024 20:09:41
// Design Name: 
// Module Name: th1
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

module thresh_cont(
    input clk,
    input rst,
    input en,
    input [19:0] in_data,
    output reg [19:0] thresh_val
);

always @(posedge clk) begin
    if(rst) begin
        thresh_val <= 20'd00;
    end
    else begin
        if((thresh_val<in_data) && en) thresh_val <= in_data;
    end
end 

endmodule
