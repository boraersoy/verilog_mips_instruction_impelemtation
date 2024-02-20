module shifter(shout, shin);
output [25:0] shout;
input [23:0] shin;
assign shout = shin << 2;
endmodule

