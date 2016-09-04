`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:35:08 09/01/2016 
// Design Name: 
// Module Name:    VGA_Top 
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
module VGA_Top(
    input B_Up,B_Down_B_Left,B_Right,B_Center,clk,
    output vgaBlue,vgaGreen,vgaRed,Hsync,Vsync
	 );

clock_divider clk_Divider(
    .Clock_in(clk), 
    .Clock_out(clk25MHz)
    );



endmodule
