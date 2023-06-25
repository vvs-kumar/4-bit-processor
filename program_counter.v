module program_counter(input clk,rst,output reg[2:0]program_counter_out);

reg [2:0]temp;
always@(*)
    begin
        if(rst)
            begin
                program_counter_out<=3'b000;
                temp<=3'b000;
            end
        else if(temp<3'b111)
                begin
                    program_counter_out<=temp;
                    temp<=temp+1;
                end
    end
endmodule
