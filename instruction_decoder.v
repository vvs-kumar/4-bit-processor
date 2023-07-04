module instruction_decoder(input [7:0]opcode_in,input clk, rst, output reg [3:0]opcode,operand);


always@(*)
    begin
        if (rst)
            begin
                opcode <=4'b0000; 
            end
        else
            begin
                opcode = opcode_in[7:4];
                operand = opcode_in[3:0]; 
            end 
    end
endmodule
