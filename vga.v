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


wire clk25MHz,clk1KHz,clk60Hz;
//Reloj de 25MHz
clock_divider reloj (
    .clk(in_clk), 
    .clr(B_Reset), 
    .o_clk25MHz(clk25MHz), 
    .o_clk1KHz(clk1KHz),
	 .o_clk1Hz(clk1Hz)
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
wire [5:0] mins,segs;
fsm_timer maquina_de_estados (
	 .B_U(B_U), 
	 .B_D(B_D), 
	 .B_L(B_L), 
	 .B_R(B_R),
	 .B_C(B_C),
    .o_seg(segs),
	 .o_min(mins)
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