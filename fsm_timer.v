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
	 input wire clk, reset, i_B_U, i_B_D, i_B_L, i_B_R, i_B_C,
	 input wire [3:0] i_mins0,
	 input wire [3:0] i_mins1,
	 input wire [3:0] i_segs0,
	 input wire [3:0] i_segs1,
	 output wire [7:0] o_color,
	 output wire o_run,
	 output wire [1:0] o_choose
);


localparam [3:0] STATE_Initial = 4'd0, //Set Pos 0
	STATE_1 = 4'd1,							//Set Pos 1
	STATE_2 = 4'd2,							//Set Pos 2
	STATE_3 = 4'd3,							//Set Pos 3
	STATE_4 = 4'd4,							//Contar
	STATE_5 = 4'd5,							//Pausa
	STATE_6 = 4'd6,							//Fin
	STATE_7 = 4'd7,
	STATE_8 = 4'd8;
reg [3:0] current_state = STATE_Initial;
reg [3:0] next_state = STATE_Initial;

reg reg_o_run = 1'd0;
reg [1:0] reg_o_choose = 2'd0;
reg [7:0] reg_o_color=8'd0;

always@(*) begin
	next_state = current_state;
	case(current_state)
		STATE_Initial: begin
			if(i_B_C) begin 
				next_state = STATE_4;
			end else if (i_B_L) begin
				next_state=STATE_1;
			end else if (i_B_R) begin
				next_state = STATE_Initial;
			end else begin
				next_state = STATE_Initial;
			end
		end
		STATE_1: begin
			if(i_B_C) begin 
				next_state = STATE_4;
			end else if (i_B_L) begin
				next_state=STATE_2;
			end else if (i_B_R) begin
				next_state = STATE_Initial;
			end else begin
				next_state = STATE_1;
			end
		end
		STATE_2: begin
			if(i_B_C) begin 
				next_state = STATE_4;
			end else if (i_B_L) begin
				next_state=STATE_3;
			end else if (i_B_R) begin
				next_state = STATE_1;
			end else begin
				next_state = STATE_2;
			end
		end
		STATE_3: begin
			if(i_B_C) begin 
				next_state = STATE_4;
			end else if (i_B_L) begin
				next_state=STATE_3;
			end else if (i_B_R) begin
				next_state = STATE_2;
			end else begin
				next_state = STATE_3;
			end
		end
		STATE_4: begin
			if(i_mins1==4'b0 && i_mins0==4'b0 && i_segs1==4'b0 && i_segs0==4'b0 ) begin //termino de contar
				next_state=STATE_6;
			end else 
		//	if (i_B_C) begin //pausa
		//		next_state=STATE_5;
		//	end else begin//siga contando
				next_state=STATE_4;
		//	end
		end
		STATE_5:begin
			if(i_B_C) begin//reanudar
				next_state=STATE_4;
			end else begin //seguir en pausa
				next_state=STATE_5;
			end
		end
		STATE_6:begin
			if(i_B_C) begin//reanudar
				next_state=STATE_Initial;
			end else begin //seguir en pausa
				next_state=STATE_6;
			end
		end
		
		
	endcase
end

always@(*) begin
	case(current_state)
		STATE_Initial: begin
			reg_o_run = 1'd0;
			reg_o_choose=2'd0;
			reg_o_color=8'b11000000;
		end
		STATE_1: begin
			reg_o_run = 1'd0;
			reg_o_choose=2'd1;
			reg_o_color=8'b11000000;
		end
		STATE_2: begin
			reg_o_run = 1'd0;
			reg_o_choose=2'd2;
			reg_o_color=8'b11000000;
		end
		STATE_3: begin
			reg_o_run = 1'd0;
			reg_o_choose=2'd3;
			reg_o_color=8'b11000000;
		end
		STATE_4: begin
			reg_o_run = 1'd1;
			reg_o_choose=2'd0;
			reg_o_color=8'b00111000;
		end
		STATE_5: begin
			reg_o_run = 1'd0;
			reg_o_choose=2'd0;
			reg_o_color=8'b00000111;
		end
		STATE_6: begin
			reg_o_run = 1'd0;
			reg_o_choose=2'd0;
			reg_o_color=8'b01010101;
		end
		
	endcase
end 


always@(posedge clk) begin
	if (reset) begin 
		current_state <= STATE_Initial;
	end else begin 
		current_state <= next_state;
	end
end


assign o_run=reg_o_run;
assign o_choose=reg_o_choose;
assign o_color=reg_o_color;
	 
endmodule
