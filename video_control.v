`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:04:55 09/06/2016 
// Design Name: 
// Module Name:    video_control 
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
module video_control(
    input clk, 
	 input [15:0] numeros,
    output hsync, vsync,
    output [7:0] rgb
   );

   
//signal declaration
wire [9:0] pixel_x;
wire [9:0] pixel_y;
wire video_on;
wire digito1,digito2,digito3,digito4,division;
//wire pixel_tick;
reg [7:0] rgb_reg;
wire [2:0] rgb_next ;
reg bandera1=1'b1;
// estas variables son para saber cual digito imprimir 
localparam posicion1 = 10'd15; // 
localparam posicion2 = 10'd110 ; // 
localparam posicion3 = 10'd230 ; // 
localparam posicion4 = 10'd320 ; // 
localparam dospuntos = 10'd210;


//body
//instantiate vga sync circuit
vga_sync instance_name (
    .clk(clk), 
    .hsync(hsync), 
    .vsync(vsync), 
    .video_on(video_on), 
//    .p_tick(pixel_tick), 
    .pixel_x(pixel_x), 
    .pixel_y(pixel_y)
    );

//instantiate graphic
//grafic_gener grafic_gener_unit(video_on,pixel_x,pixel_y,xm,ym,rgb_next);
sietesegmentos deco1 (
    .pixel_x(pixel_x), 
    .pixel_y(pixel_y), 
    .posicion(posicion1), 
    .digito(numeros[3:0]), 
    .resultado(digito1)
    );

sietesegmentos deco2 (
    .pixel_x(pixel_x), 
    .pixel_y(pixel_y), 
    .posicion(posicion2), 
    .digito(numeros[7:4]), 
    .resultado(digito2)
    );

sietesegmentos deco3 (
    .pixel_x(pixel_x), 
    .pixel_y(pixel_y), 
    .posicion(posicion3), 
    .digito(numeros[11:8]), 
    .resultado(digito3)
    );

sietesegmentos deco4 (
    .pixel_x(pixel_x), 
    .pixel_y(pixel_y), 
    .posicion(posicion4), 
    .digito(numeros[15:12]), 
    .resultado(digito4)
    );

sietesegmentos deco5 (
    .pixel_x(pixel_x), 
    .pixel_y(pixel_y), 
    .posicion(dospuntos), 
    .digito(4'b1010), 
    .resultado(division)
    );

// rgb buffer
//& pixel_y>10'b0001100100 & pixel_y<10'b0100101100
// video_on & pixel_x <10'b?0011100000? & pixel_y < 10'b1011000000?
always @(posedge clk)
	begin 
	if (video_on && pixel_x <10'b0011100000? && pixel_y < 10'b1011000000)
		begin
			//bandera1=digito1;
			if (  digito1 | digito2 | digito3 | digito4 |division)
				begin
					rgb_reg=8'b11000000;//numeros
				end
			else 
				rgb_reg=8'b00000000;//fondo
		end 
		
	else
		rgb_reg=8'b00000000;//bordes
	end 

//output

assign rgb = rgb_reg;

endmodule