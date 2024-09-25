`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.08.2024 17:48:42
// Design Name: 
// Module Name: OV7670_top
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



module OV7670_top(
    input sys_clk,
//    input clk_25,
    input sys_rst_n_pin,

    output				sioc,	//I2C CLOCK
    inout               siod,    //I2C DATA

    input pclk,
    input vsync,
    input href,
    input [7:0] data_pin,
    
    output [3:0] led_pin,
    output xclk,
    output pwdn,
    output reset_pin,
    
    output h_sync,v_sync,  
    output [3:0] R,G,B
    );
    
    wire clk_25;
    
    reg [15:0] reset = 0;
    reg rst = 0;
    
    assign led_pin[1] = pclk;
    assign led_pin[2] = vsync;
    assign led_pin[3] = href;
    assign xclk = clk_25;
    assign pwdn = 0;
    assign reset_pin = 1;
    
    // Reset after booted
    always@(posedge sys_clk) begin
        if(sys_rst_n_pin) begin
            reset <= 0;
            rst <= 0;
        end
        else begin
        if(reset < 16'hFFFF) begin
            reset <= reset + 1'b1;
            rst <= 0;
            end
        else begin
            reset <= reset;
            rst <= 1;
            end
         
        end
    end
    
    ///////////////clkgen///////////////////////////////\
clock_wiz_25 plzz(
    .clk_out_25(clk_25),     // output clk_out_25
    .clk_in1(sys_clk)      // input clk_in1
);
        
    // OV7670 Configuration
    ov7670_init u_ov7670_init
    (
        .iCLK(sys_clk),		//100MHz
        .iRST_N(rst),        //Global Reset
        
        //I2C Side
        .I2C_SCLK(sioc),    //I2C CLOCK
        .I2C_SDAT(siod),    //I2C DATA
        
        .Config_Done(led_pin[0])//Config Done
    );
    
    /////////////////////////////VGA Test/////////////////////////////////////////////////
    wire wr;
    wire [16:0] capture_addr;
    wire [15:0] capture_data;
    wire [16:0] frame_addr;
    wire [11:0] frame_pixel;
    wire [11:0] edge_out;
    
    blk_mem_gen_0 your_instance_name (
      .clka(clk_25),    // input wire clka
      .ena(1'b1),      // input wire ena
      .wea(wr),      // input wire [0 : 0] wea
      .addra(capture_addr),  // input wire [16 : 0] addra
      .dina({capture_data[15:12], capture_data[10:7], capture_data[4:1]}),   // input wire [11 : 0] dina
//      .dina(edge_out),    // input wire [11 : 0] dina
//      .dina(grey_val),    // input wire [11 : 0] dina
      .clkb(clk_25),    // input wire clkb
      .enb(1'b1),      // input wire enb
      .addrb(frame_addr),  // input wire [16 : 0] addrb
      .doutb(frame_pixel)  // output wire [11 : 0] doutb
    );
        
    vga u_vga (
        .clk25(clk_25),
        .vga_red(R),
        .vga_green(G),
        .vga_blue(B),
        .vga_hsync(h_sync),
        .vga_vsync(v_sync),
        .frame_addr(frame_addr),
        .frame_pixel(frame_pixel)
        );

    /////////////////////////Capturing//////////////////////////////////////////////////
    
   ov7670_capture u_ov7670_capture(
        .pclk(pclk),
        .vsync(vsync),
        .href(href),
        .d(data_pin),
        .addr(capture_addr),
        .dout(capture_data),
        .wr(wr)
        );
        
        
    /////////////////////////Canny Edge Detection///////////////////////////////////////
    
//    parameter R_w = 299, G_w = 587, B_w = 114;
//    wire [11:0] grey_val;
//    assign grey_val = (capture_data[15:12]*R_w / 1000) + (capture_data[10:7]*G_w / 1000) + (capture_data[4:1]*B_w / 1000);
    
//    canny_edge edge_det(
//        .clk(wr),
//        .rst(rst),
////        .enBL(1'b1),
////        .new_frame_start(),
////        .PixelData({capture_data[15:12]*R_w/1000, capture_data[10:7]*G_w/1000, capture_data[4:1]*B_w/1000}),
//        .PixelData(grey_val),
//        .out_data_el(edge_out),
//        .address_out(capture_addr)
//    );
        
endmodule
