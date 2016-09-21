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
input wire B_U_noisy, B_D_noisy, B_L_noisy, B_R_noisy, B_C_noisy, //Botones up,down,left,right
input wire B_Reset, //resetea todo!
output wire hsync, vsync,
output wire [7:0] o_rgb
);

wire pantallaclk;
BUFGP BUFGP1(pantallaclk, in_clk);

wire arun;
wire [1:0] achoose;
wire [3:0] adata,amins0,amins1,asegs0,asegs1;
wire [7:0] number_colors;

video_control vga_video(
    .clk(pantallaclk), 
    .hsync(hsync),
    .vsync(vsync),
    .rgb(o_rgb),
	 .numeros({asegs0,asegs1,amins0,amins1})
    );

//wire clk1KHz,clk1Hz,clk25MHz;
//Reloj de 25MHz
clock_divider divisor (
    .clk(pantallaclk), 
    .clr(B_Reset), 
//    .o_clk25MHz(clk25MHz), 
    .o_clk1KHz(clk1KHz), 
    .o_clk1Hz(clk1Hz)
    );
	 
	 
	 
//Debouncers, sus entradas y cables
wire BU, BD, BL, BR,BC;
debouncer d1(
    .noisy(B_U_noisy), 
    .clk_1KHz(clk1KHz), 
    .debounced(BU)
    );
debouncer d2(
    .noisy(B_D_noisy), 
    .clk_1KHz(clk1KHz), 
    .debounced(BD)
    );
debouncer d3(
    .noisy(B_R_noisy), 
    .clk_1KHz(clk1KHz), 
    .debounced(BR)
    );
debouncer d4(
    .noisy(B_L_noisy), 
    .clk_1KHz(clk1KHz), 
    .debounced(BL)
    );
debouncer d5(
    .noisy(B_C_noisy), 
    .clk_1KHz(clk1KHz), 
    .debounced(BC)
    );

 

fsm_timer maquina_estados (
    .clk(pantallaclk), 
    .reset(B_Reset), 
    .i_B_U(BU), 
    .i_B_D(BD), 
    .i_B_L(BL), 
    .i_B_R(BR), 
    .i_B_C(BC),  
    .i_mins0(amins0), 
    .i_mins1(amins1), 
    .i_segs0(asegs0), 
    .i_segs1(asegs1), 
    .o_color(number_colors), 
    .o_run(arun), 
    .o_choose(achoose)
    );
	 
	 
timer contador_segundos (
	 .i_clk_segs(clk1Hz),
    .i_run(arun), 
    .i_choose(achoose), 
	 .BU(BU), 
    .BD(BD),
    .o_mins0(amins0), 
	 .o_mins1(amins1),
    .o_segs0(asegs0),
	 .o_segs1(asegs1)
    );
	
endmodule










/*module vga(
input wire in_clk,
input wire B_U_noisy, B_D_noisy, B_L_noisy, B_R_noisy,B_C_noisy, //Botones up,down,left,right
input wire B_Reset, //resetea todo!
output wire hsync , vsync ,
output wire [7:0] rgb
);
wire clk25MHz,clk1,clk1Hz;
//Reloj de 25MHz
clock_divider reloj(
    .clk(in_clk), 
    .clr(B_Reset), 
    .o_clk25MHz(clk25MHz), 
    .o_clk1KHz(clk1), 
    .o_clk1Hz(clk1Hz)
    );
	 
	 
//Debouncers, sus entradas y cables
wire B_U, B_D, B_L, B_R,B_C;
debouncer instance_name (
    .noisy(B_U_noisy), 
    .clk_1KHz(clk1), 
    .debounced(B_U)
    );
	 
//signal declaration
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
wire [5:0] mins,segs;
fsm_timer maquina_de_estados (
    .i_clk(clk), 
    .i_reset(B_Reset), 
    .i_B_U(B_U), 
    .i_B_D(B_D), 
    .i_B_L(B_L), 
    .i_B_R(B_R), 
    .i_B_C(B_C), 
    .o_seg(segs), 
    .o_min(mins)
    );
//Modulo controlador para determinar los colores VGA
color_manager controlador_color (
    .i_seg(segs), 
    .i_min(mins), 
    .o_rgb(rgb)
    );
	 
endmodule
*/