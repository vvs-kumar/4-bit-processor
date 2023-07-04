module accumulator(input clk,input [3:0] in, input acc_en, input reset, output reg [3:0] acc_out);

always @(posedge clk)
    begin
        if (reset) // reset the accumulator to 0
            acc_out <= 4'b0000;
        else if (acc_en) 
			begin
            		acc_out <= in; // add the input to the current accumulator value
			end
	end

endmodule
