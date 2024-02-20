module control(in,f, regdest, alusrc, memtoreg, regwrite, 
	       memread, memwrite, branch, aluop1, aluop2, jal, jump,jr);

input [7:0] in;
input [3:0] f;
output regdest, alusrc, memtoreg, regwrite, memread, memwrite, branch, aluop1, aluop2, jal, jump,jr;

wire rformat,lw,sw,beq,jall,j,jump_reg;

//assign rformat =~| in;

assign rformat = (~in[7])&(~in[6])&(~in[5])& (in[4])&(in[3])&(~in[2])&(~in[1])&(~in[0]); // 24 = 00011000
assign jump_reg = (~|in) & f[3]&(~f[2])&(~f[1])&(~f[0]);

assign j = (~in[7])&(~in[6])&(~in[5])& (in[4])&(in[3])&(~in[2])&in[1]&(in[0]); // 00011011 = 27
assign jall = (~in[5])& (~in[4])&(~in[3])&(~in[2])&in[1]&in[0]; // 00011001 = 2
assign lw = (~in[7])&(~in[6])&(~in[5])&(in[4])&(in[3])&(~in[2])&(~in[1])&(in[0]); // 00011001 = 25
assign sw = (~in[7])&(~in[6])&(~in[5])&(in[4])&in[3]&(~in[2])&in[1]&(~in[0]); //00011010 = 26

assign beq = (~in[7])&(~in[6])&(~in[5])&(in[4])&(in[3])&in[2]&(~in[1])&(~in[0]); // 00011100 = 28
assign bne = (~in[7])&(~in[6])&(~in[5])&(in[4])&(in[3])&in[2]&(~in[1])&(in[0]); // 00011101 = 29
assign addi = (~in[7])&(~in[6])&(~in[5])&(in[4])&(in[3])&in[2]&(in[1])&(~in[0]); // 00011110 = 30

assign regdest = rformat;

assign alusrc = lw|sw|addi;
assign memtoreg = lw;
assign regwrite = rformat|lw|jall|addi;
assign memread = lw;
assign memwrite = sw;
assign branch = beq|bne;
assign aluop1 = rformat;
assign aluop2 = beq|bne;
assign jal = jall;
assign jump = j;//|jal;
assign jr = jump_reg;


endmodule

