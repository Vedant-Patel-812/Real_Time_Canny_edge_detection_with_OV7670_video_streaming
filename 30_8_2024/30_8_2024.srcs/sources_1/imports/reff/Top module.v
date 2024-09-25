`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Samsong
// Engineer: Kachra Seth
// 
// Create Date: 13.07.2024 19:43:28
// Design Name: 
// Module Name: Top module
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


module canny_edge(
    input clk,
    input rst,
//    input enBL,
//    input new_frame_start,
    input [7:0] PixelData,
    output [11:0] out_data_el,
    output reg [16:0] add_out,
    output reg en,
    input new_frame
);

reg [19:0] cnt;
//reg [7:0] en_pixel_data;

//reg [19:0] sobel_memory_gxy[0:264195];
//reg [19:0] sobel_memory_ang[0:264195];

//integer sobel_mem_counter_r;
//integer sobel_mem_counter_w;

reg en_sb,en_th;
reg [19:0] cnt_thresh;
reg [19:0] cnt_en;

initial begin
    cnt <= 20'd0;
//    en <= 1'b0;
    en <= 1'b0;
    en_sb <= 1'b0;
    en_th <= 1'b0;
    add_out <= 17'd0;
    cnt_thresh <= 0;
    cnt_en <= 0;
//    sobel_mem_counter_w <= 0;
//    sobel_mem_counter_r <= 0;
end

wire [7:0] out_data1_lb514, out_data2_lb514, out_data3_lb514;
line_buffer_514 lb_gauss(clk, rst, 1'b1, PixelData, out_data1_lb514, out_data2_lb514, out_data3_lb514);


wire [7:0] out_data_gauss;
//wire beat_gauss;
gauss gauss_1(clk, rst, out_data1_lb514, out_data2_lb514, out_data3_lb514, out_data_gauss);


wire [7:0] out_data1_lb512, out_data2_lb512, out_data3_lb512, out_data4_lb512, out_data5_lb512;
line_buffer_512 lb_sobel(clk, rst, 1'b1, out_data_gauss, out_data1_lb512, out_data2_lb512, out_data3_lb512, out_data4_lb512, out_data5_lb512);


wire [19:0] out_data_gxy;
wire [1:0] out_data_ang;
//wire beat_sobel;
sobel_top sobel_1(clk, rst, out_data1_lb512, out_data2_lb512, out_data3_lb512, out_data4_lb512, out_data5_lb512, out_data_gxy, out_data_ang);


wire [19:0] out_thresh_val;
//integer out_buff_thresh;
//integer out_buff_ang;
reg [19:0] last_thresh;
thresh_cont thresh_1(clk, rst, en_th, out_data_gxy, out_thresh_val);


wire [19:0] out_data1_lb508, out_data2_lb508, out_data3_lb508; 
wire [1:0] out_data_ang_lb508;
line_buffer_508 lb_nmh(clk, rst, 1'b1, out_data_gxy, out_data_ang, out_data1_lb508, out_data2_lb508, out_data3_lb508, out_data_ang_lb508);

wire [2:0] out_data_nmh;
//wire beat_nmh;
non_max_hyst nmh_1(clk, rst, out_data1_lb508, out_data2_lb508, out_data3_lb508, out_data_ang_lb508, last_thresh, out_data_nmh);

wire [2:0] out_data1_lb506, out_data2_lb506, out_data3_lb506;
line_buffer_506 lb_el(clk, rst, 1'b1, out_data_nmh, out_data1_lb506, out_data2_lb506, out_data3_lb506);

//wire beat_el;
edge_linking el_1(clk, rst, out_data1_lb506, out_data2_lb506, out_data3_lb506, out_data_el);

//reg [19:0] prev_frame_thresh_val;

always @(posedge clk) begin

    if(new_frame) begin
        //all reset
        cnt <= 20'd0;
        cnt_thresh <= 20'd0;
        cnt_en <= 20'd0;
        en <= 0;
        add_out <= 0;
        en_th <= 0;
        last_thresh <= out_thresh_val;
    end
    
    else begin
        //rest everything
        
        cnt <= cnt + 1;
    
        if(cnt == 20'd3224) en <= 1'b1;
        if(cnt == 20'd1937) en_th <= 1'b1; 
        
        if(en_th) begin
            cnt_thresh <= cnt_thresh + 1;
            if(cnt_thresh == 20'd76800) begin
                cnt_thresh <= 20'd0;
                en_th <= 1'b0;
            end
        end
        
        if(en) begin
            cnt_en <= cnt_en + 1;
            add_out <= add_out + 1;
            if(cnt_en == 20'd76800) begin
                cnt_en <= 20'd0;
                add_out <= 17'd0;
                en <= 0;
                cnt <= 0;
            end
        end
    end 
    
    
    
end

endmodule
