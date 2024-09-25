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
    wire toggle;
    wire new_frame;
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
    .clk_in_100(sys_clk)      // input clk_in1
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
    
     blk_mem_gen_0 M1 (
      .clka(wr),    // input wire clka
      .ena(1'b1),      // input wire ena
      .wea(toggle),      // input wire [0 : 0] wea
      .addra(capture_addr),  // input wire [16 : 0] addra
//      .dina({capture_data[15:12], capture_data[10:7], capture_data[4:1]}),   // input wire [11 : 0] dina
      .dina(edge_out),   // input wire [11 : 0] dina
      .clkb(clk_25),    // input wire clkb
      .enb(1'b1),      // input wire enb
      .addrb(frame_addr),  // input wire [16 : 0] addrb
      .doutb(frame_pixel)  // output wire [11 : 0] doutb
    );
    
    
//    blk_mem_gen_0 M1 (
//      .clka(m1_clka),    // input wire clka
//      .ena(m1_ena),      // input wire ena
//      .wea(m1_wea),      // input wire [0 : 0] wea
//      .addra(m1_addra),  // input wire [16 : 0] addra
////      .dina({capture_data[15:12], capture_data[10:7], capture_data[4:1]}),   // input wire [11 : 0] dina
//      .dina(m1_dina),   // input wire [11 : 0] dina
//      .clkb(m1_clkb),    // input wire clkb
//      .enb(m1_enb),      // input wire enb
//      .addrb(m1_addrb),  // input wire [16 : 0] addrb
//      .doutb(m1_doutb)  // output wire [11 : 0] doutb
//    );
    
//    blk_mem_gen_0 M2 (
//      .clka(m2_clka),    // input wire clka
//      .ena(m2_ena),      // input wire ena
//      .wea(m2_wea),      // input wire [0 : 0] wea
//      .addra(m2_addra),  // input wire [16 : 0] addra
////      .dina({capture_data[15:12], capture_data[10:7], capture_data[4:1]}),   // input wire [11 : 0] dina
//      .dina(m2_dina),   // input wire [11 : 0] dina
//      .clkb(m2_clkb),    // input wire clkb
//      .enb(m2_enb),      // input wire enb
//      .addrb(m2_addrb),  // input wire [16 : 0] addrb
//      .doutb(m2_doutb)  // output wire [11 : 0] doutb
//    );
    
//    reg state;
    
//    always @(negedge toggle) begin
//        state <= !state;
//    end
    
//    wire [19:0] temp_m1_addra, temp_m1_dina, temp_m1_addrb, temp_m1_doutb, temp_m2_addra, temp_m2_dina, temp_m2_addrb, temp_m2_doutb;
    
//    assign m1_clka = (state) ? wr : clk_25;
//    assign m1_ena = (state) ? 1 : 0;
//    assign m1_wea = (state) ? toggle : 0;
//    assign m1_addra = (state) ? capture_addr : temp_m1_addra;
//    assign m1_dina = (state) ? edge_out : temp_m1_dina;
    
//    assign m1_clkb = (state) ? clk_25 : clk_25;
//    assign m1_enb = (state) ? 0 : 1;
//    assign m1_addrb = (state) ? temp_m1_addrb : frame_addr;
//    assign m1_doutb = (state) ? temp_m1_doutb : frame_pixel;
   
   
    
//    assign m2_clka = (state) ? clk_25 : wr;
//    assign m2_ena = (state) ? 0 : 1;
//    assign m2_wea = (state) ? 0 : toggle;
//    assign m2_addra = (state) ? temp_m2_addra : capture_addr;
//    assign m2_dina = (state) ? temp_m2_dina : edge_out;
    
//    assign m2_clkb = (state) ? clk_25 : clk_25;
//    assign m2_enb = (state) ? 1 : 1;
//    assign m2_addrb = (state) ? frame_addr : temp_m2_addrb;
//    assign m2_doutb = (state) ? frame_pixel : temp_m2_doutb;
    
//    ila_0 inst1(
//        .clk(pclk),
//        .probe0(href),
//        .probe1(capture_data)
//    );
        
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
        .addr(capture_addr_null),
        .dout(capture_data),
        .wr(wr),
        .new_frame(new_frame)
        );
        
        
    /////////////////////////Canny Edge Detection///////////////////////////////////////
    
//    parameter R_w = 299, G_w = 587, B_w = 114;
    wire [11:0] grey_val;
//    assign grey_val = (capture_data[15:12]*R_w / 1000) + (capture_data[10:7]*G_w / 1000) + (capture_data[4:1]*B_w / 1000);
    
    assign grey_val = {{6{1'b0}},capture_data[10:5]};
    canny_edge edge_det(
        .clk(wr),
        .rst(!rst),
//        .enBL(1'b1),
//        .new_frame_start(),
//        .PixelData({capture_data[15:12]*R_w/1000, capture_data[10:7]*G_w/1000, capture_data[4:1]*B_w/1000}),
        .PixelData(grey_val[7:0]),
        .out_data_el(edge_out),
        .add_out(capture_addr),
        .en(toggle),
        .new_frame(new_frame)
    );
        
endmodule











