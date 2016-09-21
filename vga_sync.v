`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:31:29 09/06/2016 
// Design Name: 
// Module Name:    vga_sync 
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
module vga_sync(
  input wire clk,
    output wire hsync, vsync, video_on, //p_tick,
    output wire [9:0] pixel_x, pixel_y
   );

   // constant declaration
   // VGA 640-by-480 sync parameters
   localparam HD = 640; // horizontal display area
   localparam HF = 48 ; // h. front (left) border
   localparam HB = 16 ; // h. back (right) border
   localparam HR = 96 ; // h. retrace
   localparam VD = 480; // vertical display area
   localparam VF = 10;  // v. front (top) border
   localparam VB = 33;  // v. back (bottom) border
   localparam VR = 2;   // v. retrace

////////Esto se documento para generar un mod-4 que se encarga de realizar la division de frecuencia

   // mod-2 counter
  // reg mod2_reg;
  // wire mod2_next;
  
  
   // sync counters
   reg [9:0] h_count_reg, h_count_next;
   reg [9:0] v_count_reg, v_count_next;
   // output buffer
   reg v_sync_reg, h_sync_reg;
   wire v_sync_next, h_sync_next;
   // status signal
   wire h_end, v_end;// pixel_tick;

   // body
   // registers
   always @(posedge clk)
         begin
           // mod2_reg <= mod2_next;
            v_count_reg <= v_count_next;
            h_count_reg <= h_count_next;
            v_sync_reg <= v_sync_next;
            h_sync_reg <= h_sync_next;
         end

   // mod-2 circuit to generate 25 MHz enable tick
  // assign mod2_next = ~mod2_reg;
  // assign pixel_tick = mod2_reg;
  
  //Esto de aqui se encarga de realizar el divisor de frecuencia
  reg[1:0] count;
  always@(posedge clk) count <= count + 2'd1;
  wire en4 = (count[1:0] == 2'b11);

   // status signals
   // end of horizontal counter (799)
   assign h_end = (h_count_reg==(HD+HF+HB+HR-1));
   // end of vertical counter (524)
   assign v_end = (v_count_reg==(VD+VF+VB+VR-1));

   // next-state logic of mod-800 horizontal sync counter
   always @*
      if (en4)  // 25 MHz pulse
         if (h_end)
            h_count_next = 10'd0;
         else
            h_count_next = h_count_reg + 10'd1;
      else
         h_count_next = h_count_reg;

   // next-state logic of mod-525 vertical sync counter
   always @*
      if (en4 & h_end)
         if (v_end)
            v_count_next = 10'd0;
         else
            v_count_next = v_count_reg + 10'd1;
      else
         v_count_next = v_count_reg;

   // horizontal and vertical sync, buffered to avoid glitch
   // h_sync_next asserted between 656 and 751
   assign h_sync_next = (h_count_reg>=(HD+HB) &&
                         h_count_reg<=(HD+HB+HR-1));
   // vh_sync_next asserted between 490 and 491
   assign v_sync_next = (v_count_reg>=(VD+VB) &&
                         v_count_reg<=(VD+VB+VR-1));

   // video on/off
   assign video_on = (h_count_reg<HD) && (v_count_reg<VD);

   // output
   assign hsync = h_sync_reg;
   assign vsync = v_sync_reg;
   assign pixel_x = h_count_reg;
   assign pixel_y = v_count_reg;
   //assign p_tick = en4;

endmodule

