`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:22:27 08/29/2016 
// Design Name: 
// Module Name:    RetardoBoton 
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
module clock_divider(
    input clk,// señal normal del reloj de la placa 
	 input clr,// por si hay un reset
    output o_clk25MHz ,o_clk1KHz,o_clk1Hz// salida a menos de 23 Hz
    );

reg [25:0] q=26'd0;// variable que sirve de contador para dividir la frcuencia y aumentar el periodo

//contador de 24-bit
always @(posedge clk ) // proceso que realiza la cuenta 
    if(clr) q <= 0;        //Si se activa clr el proximo valor de q sera 0
    else    q <= q + 1;    //de lo contrario el siguiente valor de q sera q+1
    
assign o_clk25MHz  = q[0];    //100MHz/2^(23+1)=25MHz
assign o_clk1KHz=q[17];  
assign o_clk1Hz=q[25];

endmodule