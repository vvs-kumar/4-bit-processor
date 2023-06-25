module sub_1bit(input a,b,b_in,output diff, output borrow);
assign diff = a^b^b_in;
assign borrow = ~a & (b^b_in) | b & b_in;
endmodule
