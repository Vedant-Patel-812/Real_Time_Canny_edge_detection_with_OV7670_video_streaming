`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.08.2024 17:51:54
// Design Name: 
// Module Name: ov7670_capture
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



module ov7670_capture(
    input pclk,
    input vsync,
    input href,
    input[7:0] d,
    output[16:0] addr,
    output reg[15:0] dout,
    output reg wr,
    output reg new_frame
    );
    reg [15:0] d_latch;
    reg [16:0] address; 
    reg [1:0] wr_hold;  
    reg pd=0;
    initial dout = 16'b0000000000000000;
    initial d_latch = 16'b0;
    initial address = 19'b0;
    initial wr_hold = 2'b0;  
    assign addr = address?address-1:17'b0;

    always@(posedge pclk)
    begin
    
    if(address == 17'd1) begin
        new_frame <= 1'b1;
    end
    else begin
        new_frame <= 1'b0;
    end
    
    if( vsync ==1) 
        begin
        address <=17'b0;
        wr_hold <=  2'b0;
        end
    else 
        begin
        if(address<76800)//320*240
		      address<=address;
        else
            address <= 76800;   
        wr_hold <= {wr_hold[0] , (href &&( ! wr_hold[0])) };
        d_latch <= {d_latch[7:0] , d};
        wr <= 0;
        
        if (wr_hold[1] ==1 )
            begin
            pd=~pd;
           // if(pd)
            address<=address+1;
            dout[15:0]  <= {d_latch[15:11] , d_latch[10:5] , d_latch[4:0] };    
            wr <= 1; 
            end

        end
    end

endmodule

