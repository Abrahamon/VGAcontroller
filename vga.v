`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:14:04 09/04/2016 
// Design Name: 
// Module Name:    vga 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module vga(
input wire clk, reset,
input wire [2:0] sw,
output wire hsync , vsync ,
output wire [2:0] rgb
);

// signal declaration
reg [2:0] rgb_reg;
wire video_on;
// instantiate vga sync circuit
vga_sync instance_name (
    .clk(clk), 
    .reset(reset), 
    .hsync(hsync), 
    .vsync(vsync), 
    .video_on(video_on), 
    .p_tick(), 
    .pixel_x(), 
    .pixel_y()
    );
// rgb b u f f e r
always @(posedge clk , posedge reset)
	if (reset)
		rgb_reg <= 0;
	else
		rgb_reg <= sw;
// output
assign rgb=(video_on)?rgb_reg:3'b0;

endmodule