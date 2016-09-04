`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:19:08 09/04/2016
// Design Name:   vga
// Module Name:   C:/Users/Abraham/Documents/Xiling Projects/VGAcontroller/vga_test.v
// Project Name:  VGAcontroller
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: vga
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module vga_test;

	// Inputs
	reg clk;
	reg reset;
	reg [2:0] sw;

	// Outputs
	wire hsync;
	wire vsync;
	wire [2:0] rgb;

	// Instantiate the Unit Under Test (UUT)
	vga uut (
		.clk(clk), 
		.reset(reset), 
		.sw(sw), 
		.hsync(hsync), 
		.vsync(vsync), 
		.rgb(rgb)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		sw = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

