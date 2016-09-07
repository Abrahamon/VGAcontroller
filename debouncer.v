`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:28:41 09/06/2016 
// Design Name: 
// Module Name:    debouncer 
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
module debouncer(noisy,clk_1KHz,debounced);

input wire clk_1KHz, noisy;
output reg debounced;

reg [7:0] regi;

//reg: wait for stable
always @ (posedge clk_1KHz) 
begin
regi[7:0] <= {regi[6:0],noisy}; //shift register
if(regi[7:0] == 8'b00000000)
  debounced <= 1'b0;
else if(regi[7:0] == 8'b11111111)
  debounced <= 1'b1;
else debounced <= debounced;

end 
endmodule