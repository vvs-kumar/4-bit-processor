module adder_1bit(input a,b,cin, output sum, cout);
//I am using behaviour model of xor and and circuitary of 1 bit for lesser gate usage.
wire sum_1;
wire carry_1, carry_2;
    assign sum_1=a^b;
    assign sum=sum_1^cin;
    
    assign carry_1=sum_1&cin;
    assign carry_2=a&b;
    assign cout=carry_1|carry_2;
endmodule
