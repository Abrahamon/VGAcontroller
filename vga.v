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
input wire in_clk,
input wire B_U_noisy, B_D_noisy, B_L_noisy, B_R_noisy,B_C_noisy, //Botones up,down,left,right
input wire B_Reset, //resetea todo!
output wire hsync , vsync ,
output wire [7:0] rgb
);


wire clk25MHz,clk1KHz;
//Reloj de 25MHz
clock_divider reloj (
    .clk(in_clk), 
    .clr(B_Reset), 
    .o_clk25MHz(clk25MHz), 
    .o_clk1KHz(clk1KHz)
    );

	 
//Debouncers, sus entradas y cables
wire B_U, B_D, B_L, B_R,B_C;
debouncer d1(
    .noisy(B_U_noisy), 
    .clk_1KHz(clk1KHz), 
    .debounced(B_U)
    );
debouncer d2(
    .noisy(B_D_noisy), 
    .clk_1KHz(clk1KHz), 
    .debounced(B_D)
    );
debouncer d3(
    .noisy(B_R_noisy), 
    .clk_1KHz(clk1KHz), 
    .debounced(B_R)
    );
debouncer d4(
    .noisy(B_L_noisy), 
    .clk_1KHz(clk1KHz), 
    .debounced(B_L)
    );
debouncer d5(
    .noisy(B_C_noisy), 
    .clk_1KHz(clk1KHz), 
    .debounced(B_C)
    );
	 
	 
//signal declaration
reg [2:0] rgb_reg;
wire video_on;
wire pos_x,pos_y;	 
vga_sync sincronizador (
    .clk(clk25MHz), 
    .reset(B_Reset), 
    .hsync(hsync), 
    .vsync(vsync), 
    .video_on(video_on), 
    .p_tick(p_tick), 
    .pixel_x(pos_x), 
    .pixel_y(pos_y)
    );
	 
	 
//Color manipulation
color_controller instance_name (
    .pixel_pos_x(pos_x), 
    .pixel_pos_y(pos_y), 
	 .B_U(B_U), 
	 .B_D(B_D), 
	 .B_L(B_L), 
	 .B_R(B_R),
	 .B_C(B_C),
    .rgb(rgb)
    );
	 



endmodule