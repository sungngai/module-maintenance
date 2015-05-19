
/* 
copyright CY

Filename    : 
Compiler    : Quartus II 9.1
simulator	  : ModelSim 6.5b
Description : 
Release     : 
*/

module pllnrst(
		//input
		clk,
		rst_n,
		//output 
		sysrst_n
		);
		
input clk;
input rst_n;
output sysrst_n;

//第一级“异步复位，同步释放”
reg rst_n_ff1;
reg rst_n_ff2;
always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		rst_n_ff1<=1'b0;
		rst_n_ff2<=1'b0;
		end
	else begin
		rst_n_ff1<=1'b1;
		rst_n_ff2<=rst_n_ff1;
		end
end

//第一级信号输入PLL
wire clkc0_50m;
wire locked;
pll	pll_inst (
	//input
	.areset (!rst_n_ff2),
	.inclk0 (clk),
	//output 
	.c0 (clkc0_50m),
	.locked (locked)
	);
	
//组成新的复位信号
wire rst_tmp;
assign rst_tmp=rst_n & locked;

//输出加一级“异步复位，同步释放”
reg rst_tmp_ff1;
reg rst_tmp_ff2;
always @ (posedge clkc0_50m or negedge rst_tmp) begin
	if(!rst_tmp) begin
		rst_tmp_ff1<=1'b0;
		rst_tmp_ff2<=1'b0;
		end
	else begin
		rst_tmp_ff1<=rst_tmp;
		rst_tmp_ff2<=rst_tmp_ff1;
		end
end
assign sysrst_n=rst_tmp_ff2;

endmodule


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
	
	
	