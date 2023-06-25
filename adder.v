module adder(input [3:0] operand_a, operand_b,input carry_in,output [3:0] sum,output carry);

wire c1,c2,c3; 
adder_1bit adder1( operand_a[0],operand_b[0],carry_in,sum[0], c1);
adder_1bit adder2( operand_a[1],operand_b[1],c1,sum[1], c2);
adder_1bit adder3( operand_a[2],operand_b[2],c2,sum[2], c3);
adder_1bit adder4( operand_a[3],operand_b[3],c3,sum[3], carry);

endmodule
