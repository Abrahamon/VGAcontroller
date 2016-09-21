`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:09:17 09/07/2016 
// Design Name: 
// Module Name:    sietesegmentos 
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
module sietesegmentos(
    input [9:0] pixel_x,
    input [9:0] pixel_y,
    input [9:0] posicion, // indica cual de los 4 digitos hay que pintar
	 input [3:0] digito, // digito a verificar para pintarlo
    output resultado // indica si hay que pintar o no el pixel correspondiente
    );
reg resultado_reg;
always @ (*)
begin
	
	case (digito)
		4'b1000:// significa que es el numero 1
			if ((pixel_y>=10'b0001100100 & pixel_y<10'b0001110011 &pixel_x>posicion & pixel_x<(posicion+10'b0001001011)// segmento A
				| (pixel_x>(posicion+10'b0000111100) & pixel_x<(posicion+10'b0001001011) & // segmento B y C
				pixel_y>10'b0001100100 & pixel_y<=10'b100101100))| 
				pixel_y>=10'b0100011100 & pixel_y<10'b0100101101 &pixel_x>posicion & pixel_x<(posicion+10'b0001001011) // segmento D
				|(pixel_x>(posicion) & pixel_x<(posicion+10'b0000001110) &  //segmento E.F
				pixel_y>10'b0001100100 & pixel_y<10'b100101100)|
				pixel_y>=10'b0011000001 & pixel_y<10'b0011010000 &pixel_x>posicion & pixel_x<(posicion+10'b0001001011))// segmento G
					resultado_reg=1'b1;
			else 
					resultado_reg=1'b0;
		4'b0000:
			if ((pixel_y>=10'b0001100100 & pixel_y<10'b0001110011 &pixel_x>posicion & pixel_x<(posicion+10'b0001001011)// segmento A
				| (pixel_x>(posicion+10'b0000111100) & pixel_x<(posicion+10'b0001001011) & // segmento B y C
				pixel_y>10'b0001100100 & pixel_y<=10'b100101100))| 
				pixel_y>=10'b0100011100 & pixel_y<10'b0100101101 &pixel_x>posicion & pixel_x<(posicion+10'b0001001011) // segmento D
				|(pixel_x>(posicion) & pixel_x<(posicion+10'b0000001110) &  //segmento E.F
				pixel_y>10'b0001100100 & pixel_y<10'b100101100))// segmento G
					resultado_reg=1'b1;
			else 
					resultado_reg=1'b0;		
		4'b0001:
			if ((pixel_x>(posicion+10'b0000111100) & pixel_x<(posicion+10'b0001001011) & // segmento B y C
				pixel_y>10'b0001100100 & pixel_y<=10'b100101100))// segmento G
					resultado_reg=1'b1;
			else 
					resultado_reg=1'b0;

		4'b0010:
			if (pixel_y>=10'b0001100100 & pixel_y<10'b0001110011 &pixel_x>posicion & pixel_x<(posicion+10'b0001001011) //segmento A
			| (pixel_x>(posicion+10'b0000111100) & pixel_x<(posicion+10'b0001001011) & 
				pixel_y>10'b0001100100 & pixel_y<=10'b0011001000)|// segmento B
				(pixel_y>=10'b0011000001 & pixel_y<10'b0011010000 &pixel_x>posicion & pixel_x<(posicion+10'b0001001011))|// segmento G
				(pixel_x>(posicion) & pixel_x<(posicion+10'b0000001110) &  //segmento E
				pixel_y>10'b0011001000 & pixel_y<10'b100101100)|
				(pixel_y>=10'b0100011100 & pixel_y<10'b0100101101 &pixel_x>posicion & pixel_x<(posicion+10'b0001001011)))
					resultado_reg=1'b1;
			else 
					resultado_reg=1'b0;		
		4'b0011:
			if (pixel_y>=10'b0001100100 & pixel_y<10'b0001110011 &pixel_x>posicion & pixel_x<(posicion+10'b0001001011)|// segmento G
			(pixel_x>(posicion+10'b0000111100) & pixel_x<(posicion+10'b0001001011) & // segmento B y C
				pixel_y>10'b0001100100 & pixel_y<=10'b100101100)|
				(pixel_y>=10'b0100011100 & pixel_y<10'b0100101101 &pixel_x>posicion & pixel_x<(posicion+10'b0001001011))|
				(pixel_y>=10'b0011000001 & pixel_y<10'b0011010000 &pixel_x>posicion & pixel_x<(posicion+10'b0001001011)))
					resultado_reg=1'b1;
			else 
					resultado_reg=1'b0;
		4'b0100:
			if ((pixel_x>(posicion+10'b0000111100) & pixel_x<(posicion+10'b0001001011) & // segmento B y C
				pixel_y>10'b0001100100 & pixel_y<=10'b100101100)|
				(pixel_y>=10'b0011000001 & pixel_y<10'b0011010000 &pixel_x>posicion & pixel_x<(posicion+10'b0001001011))|
				(pixel_x>(posicion) & pixel_x<(posicion+10'b0000001110) &  //segmento E.F
				pixel_y>10'b0001100100 & pixel_y<10'b0011001000))// segmento F
					resultado_reg=1'b1;
			else 
					resultado_reg=1'b0;

		4'b0101:
			if ((pixel_y>=10'b0001100100 & pixel_y<10'b0001110011 &pixel_x>posicion & pixel_x<(posicion+10'b0001001011)|
			(pixel_x>(posicion) & pixel_x<(posicion+10'b0000001110) &  //segmento E
				pixel_y>10'b0001100100 & pixel_y<10'b0011001000)|
				pixel_y>=10'b0011000001 & pixel_y<10'b0011010000 &pixel_x>posicion & pixel_x<(posicion+10'b0001001011) |
				pixel_x>(posicion+10'b0000111100) & pixel_x<(posicion+10'b0001001011) & // segmento B y C
				pixel_y>10'b0011001000 & pixel_y<=10'b100101100)|
				pixel_y>=10'b0100011100 & pixel_y<10'b0100101101 &pixel_x>posicion & pixel_x<(posicion+10'b0001001011))
					resultado_reg=1'b1;
			else 
					resultado_reg=1'b0;
		
		4'b0110:
			if ((pixel_y>=10'b0001100100 & pixel_y<10'b0001110011 &pixel_x>posicion & pixel_x<(posicion+10'b0001001011)|
			(pixel_x>(posicion) & pixel_x<(posicion+10'b0000001110) &  //segmento E
				pixel_y>10'b0001100100 & pixel_y<10'b0100101100)|
				pixel_y>=10'b0011000001 & pixel_y<10'b0011010000 &pixel_x>posicion & pixel_x<(posicion+10'b0001001011) |
				pixel_x>(posicion+10'b0000111100) & pixel_x<(posicion+10'b0001001011) & // segmento B y C
				pixel_y>10'b0011001000 & pixel_y<=10'b100101100)|
				pixel_y>=10'b0100011100 & pixel_y<10'b0100101101 &pixel_x>posicion & pixel_x<(posicion+10'b0001001011))
					resultado_reg=1'b1;
			else 
					resultado_reg=1'b0;
		4'b0111:
			if ((pixel_x>(posicion+10'b0000111100) & pixel_x<(posicion+10'b0001001011) & // segmento B y C
				pixel_y>10'b0001100100 & pixel_y<=10'b100101100)|
				(pixel_y>=10'b0001100100 & pixel_y<10'b0001110011 &pixel_x>posicion & pixel_x<(posicion+10'b0001001011)))// segmento G
					resultado_reg=1'b1;
			else 
					resultado_reg=1'b0;	
		4'b1001:// significa que es el numero 1
			if ((pixel_y>=10'b0001100100 & pixel_y<10'b0001110011 &pixel_x>posicion & pixel_x<(posicion+10'b0001001011)// segmento A
				| (pixel_x>(posicion+10'b0000111100) & pixel_x<(posicion+10'b0001001011) & // segmento B y C
				pixel_y>10'b0001100100 & pixel_y<=10'b100101100))| 
				(pixel_x>(posicion) & pixel_x<(posicion+10'b0000001110) &  //segmento E.F
				pixel_y>10'b0001100100 & pixel_y<10'b0011001000)|
				pixel_y>=10'b0011000001 & pixel_y<10'b0011010000 &pixel_x>posicion & pixel_x<(posicion+10'b0001001011))// segmento G
					resultado_reg=1'b1;
			else 
					resultado_reg=1'b0;
		4'b1010: // dos puntos 
			if ((pixel_x>posicion & pixel_x<(posicion+10'b0000001000))&((pixel_y>10'b0010111110 &pixel_y<10'b0011001010)|
			(pixel_y>10'b0011010010 &pixel_y<10'b0011011110)))  // segmento B y C
				
					resultado_reg=1'b1;
			else 
					resultado_reg=1'b0;
	endcase 
end 
assign resultado=resultado_reg;
endmodule