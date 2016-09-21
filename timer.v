`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:07:42 09/09/2016 
// Design Name: 
// Module Name:    timer 
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
module timer(
	//input wire i_clk,
	input wire i_clk_segs,
	input wire i_run,
	input wire [1:0] i_choose,
	input wire BU,
	input wire BD,
	output wire [3:0] o_mins0,
	output wire [3:0] o_mins1,
	output wire [3:0] o_segs0,
	output wire [3:0] o_segs1
    );

//las sentencias comentadas en este documento eran para que este modulo se encargara de contar segundos, ahora tiene una entrada en segundos
//reg [25:0] q=26'd0;// variable que sirve de contador para dividir la frcuencia y aumentar el periodo
//wire segs;


reg [3:0] reg_mins1 = 4'd0;
reg [3:0] reg_mins0 = 4'd0;
reg [3:0] reg_segs1 = 4'd9;
reg [3:0] reg_segs0 = 4'd0;

reg flagU =1'd0;
reg flagD =1'd0;
reg flag_need_add=1'd0;
reg flag_need_sub=1'd0;

always@(*)begin 
	if(i_run==1'd0) begin
		if(BU) begin
			flagU<=1'b1; 
		end else if (flag_need_add==1'd0) begin 
			flagU<=1'd0;
		end
	end
end

always@(*)begin 
	if(i_run==1'd0) begin
		if(BD) begin
			flagD<=1'b1; 
		end else if (flag_need_sub==1'd0) begin 
			flagD<=1'd0;
		end
	end
end

always@(posedge i_clk_segs) begin
//always@(posedge i_clk_segs or posedge BU or posedge BD) begin
	//if(i_clk_segs) begin
		if(i_run) begin 
			if(reg_segs0==4'd0) begin
				if(reg_segs1==4'd0)begin
					if(reg_mins0==4'd0) begin
						if(reg_mins1==4'b0)begin
							//pass
						end else begin
							reg_mins1<=reg_mins1-4'b1;
							reg_mins0<=4'd9;
							reg_segs1<=4'd5;
							reg_segs0<=4'd9;
						end
					end else begin
						reg_segs0<=4'd5;
						reg_segs1<=4'd9;
						reg_mins0<=reg_mins0-4'd1;
					end
				end else begin 
					reg_segs0<=4'd9;
					reg_segs1<=reg_segs1-4'd1;
				end
			end else begin
				reg_segs0<=reg_segs0-4'd1;
			end
		end else if (i_run==1'd0 && flagU==1'd1) begin
			flag_need_add<=0;
			if(i_choose==2'b00) begin
				reg_segs0<=reg_segs0+4'd1;
			end else if (i_choose==2'b01) begin
				reg_segs1<=reg_segs1+4'd1;
			end else if (i_choose==2'b10) begin
				reg_mins0<=reg_mins0+4'd1;
			end else begin
				reg_mins1<=reg_mins1+4'd1;
			end
		end else if (i_run==1'd0 && flagD==1'd1) begin
			flag_need_sub<=0;
			if(i_choose==2'b00)begin
				reg_segs0<=reg_segs0-4'd1;
			end else if (i_choose==2'b01) begin
				reg_segs1<=reg_segs0-4'd1;
			end else if (i_choose==2'b10) begin
				reg_mins0<=reg_mins0-4'd1;
			end else begin //(i_choose==2'b11)
				reg_mins1<=reg_mins1-4'd1;
			end
		end
		
/*		end else if (BU && i_run==1'd0) begin 
			reg_segs0<=reg_segs0;
			reg_segs1<=reg_segs1;
			reg_mins0<=reg_mins0;
			reg_mins1<=reg_mins1;
			if (i_choose == 2'b00) begin
				reg_segs0 <= reg_segs0 + 1'b1;
			end else if (i_choose==2'b01) begin
				reg_segs1 <= reg_segs1 + 1'b1;
			end else if (i_choose==2'b10) begin
				reg_mins0 <= reg_mins0 + 1'b1;
			end else begin //(i_choose==2'b11)
				reg_mins1 <= reg_mins1 + 1'b1;
			end
		end*/
/*		end else if (BD && i_run==1'd0) begin 
			if (i_choose == 2'b00) begin
				reg_segs0 <= reg_segs0 - 1'b1;
			end else if (i_choose==2'b01) begin
				reg_segs1 <= reg_segs1 - 1'b1;
			end else if (i_choose==2'b10) begin
				reg_mins0 <= reg_mins0 - 1'b1;
			end else begin //(i_choose==2'b11)
				reg_mins1 <= reg_mins1 - 1'b1;
			end
		end 
*/
end

assign o_segs0 = reg_segs0;
assign o_segs1 = reg_segs1;
assign o_mins0 = reg_mins0;
assign o_mins1 = reg_mins1;


endmodule
