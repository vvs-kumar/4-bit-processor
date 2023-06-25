//Subtractor

module subtractor(input [3:0] operand_a,operand_b,input borrow_in,output [3:0] difference,output borrow);

wire b1,b2,b3;


sub_1bit s1(.a(operand_a[0]),.b(operand_b[0]),.b_in(borrow_in),.diff(difference[0]),.borrow(b1));
sub_1bit s2(.a(operand_a[1]),.b(operand_b[1]),.b_in(b1),.diff(difference[1]),.borrow(b2));
sub_1bit s3(.a(operand_a[2]),.b(operand_b[2]),.b_in(b2),.diff(difference[2]),.borrow(b3));
sub_1bit s4(.a(operand_a[3]),.b(operand_b[3]),.b_in(b3),.diff(difference[3]),.borrow(borrow));
endmodule
