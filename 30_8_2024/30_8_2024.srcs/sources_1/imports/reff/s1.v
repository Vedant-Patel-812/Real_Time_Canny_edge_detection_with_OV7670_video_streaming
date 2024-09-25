`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.07.2024 19:58:01
// Design Name: 
// Module Name: s1
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


module sobel_top(
    input clk,
    input rst,
    input [7:0] in0,
    input [7:0] in1,
    input [7:0] in2,
    input [7:0] in3,
    input [7:0] in4,
    output [19:0] out_data,
    output [1:0] out_angle
);
    wire [19:0] R0,R1,R2,R3,R4;
    wire signed [19:0] Gx, Gy;
//    wire beat_Gx,beat_Gy;
//    reg [19:0] temp;

    assign R0 = {{12{1'b0}},in0};
    assign R1 = {{12{1'b0}},in1};
    assign R2 = {{12{1'b0}},in2};
    assign R3 = {{12{1'b0}},in3};
    assign R4 = {{12{1'b0}},in4};

    sobel_Gx x1(clk,rst,R0,R1,R2,R3,R4,Gx);
    sobel_Gy y1(clk,rst,R0,R1,R2,R3,R4,Gy);
    angle_calc a1(Gx,Gy,out_angle);

    assign out_data = ((Gx[19]) ? (~(Gx)+1) : Gx) + ((Gy[19]) ? (~(Gy)+1) : Gy);
//    assign beat = beat_Gx & beat_Gy;

//    always @(posedge beat_Gy) begin
//        temp <= out_data;
//    end
endmodule

module sobel_Gx(
    input clk,
    input rst,
    input signed [19:0] R0,
    input signed [19:0] R1,
    input signed [19:0] R2,
    input signed [19:0] R3,
    input signed [19:0] R4,
    output reg signed [19:0] out_data
//    output reg beat
);

    reg signed [19:0] t1,t2,t3,t4,t5,t6,t7;
    reg signed [19:0] s1,s2,s3,s4,s5;
//    integer count;
    
    always @(posedge clk) begin
        if(rst) begin
            t1 <= 0;
            t2 <= 0;
            t3 <= 0;
            t4 <= 0;
            t5 <= 0;
            t6 <= 0;
            t7 <= 0;
            s1 <= 0;
            s2 <= 0;
            s3 <= 0;
            s4 <= 0;
            s5 <= 0;
//            beat <= 0;
//            count <= 0;
        end

        else begin
//            count <= count + 1;

            t1 <= ~((R4<<<1)+R3)+1;
            t2 <= (R0<<<1) + R1;

            s5 <= t1 + t2;
            s4 <= s5;
            s3 <= s4<<<1;
            s2 <= s3>>>1;
            s1 <= s2;

            t3 <= s1;
            t6 <= t3;

            t4 <= s2 + s3;
            t5 <= s4 + s5;

            t7 <= t4 + t5;
        
            out_data <= t6 + t7;
        end
    end

//    always @(posedge clk) begin
//        if(count==8) beat <= 1;
//    end 
endmodule

module sobel_Gy(
    input clk,
    input rst,
    input signed [19:0] R0,
    input signed [19:0] R1,
    input signed [19:0] R2,
    input signed [19:0] R3,
    input signed [19:0] R4,
    output reg signed [19:0] out_data
//    output reg beat
);

    reg signed [19:0] t1,t2,t3,t4,t5,t6,t7,tt;
    reg signed [19:0] s1,s2,s3,s4,s5;
//    integer count;
    
    always @(posedge clk) begin
        if(rst) begin
            t1 <= 0;
            t2 <= 0;
            t3 <= 0;
            t4 <= 0;
            t5 <= 0;
            t6 <= 0;
            t7 <= 0;
            tt <= 0;
            s1 <= 0;
            s2 <= 0;
            s3 <= 0;
            s4 <= 0;
            s5 <= 0;
//            beat <= 0;
//            count <= 0;
        end

        else begin
//            count <= count + 1;

            t1 <= R3 + R4;
            t2 <= R2<<<1;
            // tt <= t2;
            t3 <= R0 + R1;
            t4 <= t1;
            t5 <= t2 + t3;

            s5 <= (t4 + t5)<<<1;
            s4 <= s5>>>1;
            s3 <= s4;
            s2 <= ~(s3) + 1;
            s1 <= s2<<<1;

            t6 <= s4 + s5;
            t7 <= s1 + s2;
       
            out_data <= (t6 + t7);
        end
    end

//    always @(posedge clk) begin
//        if(count==8) beat <= 1;
//    end 
endmodule

module angle_calc(
    input signed [19:0] x,
    input signed [19:0] y,
    output reg [1:0] angle
);

    wire signed [19:0] ang26,ang63,ang116,ang153;
    reg signed [19:0] new_x,new_y;

    always @(*) begin
        if(y<0) begin
            new_x <= (~x) + 1;
            new_y <= (~y) + 1;
        end
        else begin
            new_x <= x;
            new_y <= y;
        end
    end

    assign ang26 = ( (~(new_x>>1) + 1) + new_y );
    assign ang63 = ( (~(new_x<<1) + 1) + new_y );
    assign ang116 = ~( (new_x<<1) + new_y ) + 1;
    assign ang153 = ~( (new_x>>1) + new_y ) + 1;

    always @(*) begin
        if(ang26<0) angle <= 2'd0;
        else if(ang63<0) angle <= 2'd1;
        else if(ang116<0) angle <= 2'd2;
        else if(ang153<0) angle <= 2'd3;
        else angle <= 2'd0;
    end
endmodule