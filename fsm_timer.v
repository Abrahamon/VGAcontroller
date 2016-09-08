`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:41:06 09/06/2016 
// Design Name: 
// Module Name:    color_controller 
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
module fsm_timer(
	 input wire B_U, B_D, B_L, B_R,B_C,
	 output wire [5:0] o_seg,o_min
    );

	 
	 
endmodule

/*module fsm_timer(
	 input wire i_clk,i_reset,i_B_U, i_B_D, i_B_L, i_B_R,i_B_C,
	 output wire [5:0]o_seg,
    output wire [5:0]o_min
	 );

localparam [2:0] STATE_Initial = 3'd0,
	STATE_1 = 3'd1,
	STATE_2 = 3'd2,
	STATE_3 = 3'd3,
	STATE_4 = 3'd4,
	STATE_5 = 3'd5,
	STATE_6 = 3'd6,
	STATE_7 = 3'd7;
reg [2:0] current_state, next_state;

always@(*) begin
	next_state=current_state;
	case(current_state)
		STATE_Initial: begin
		end
		
		STATE_1: begin
		end
		
		default: begin
		end
	endcase

end

always@(posedge i_clk) begin
	if (i_reset) current_state <= STATE_Initial ;
	else current_state <= next_state ;
end

endmodule*/
