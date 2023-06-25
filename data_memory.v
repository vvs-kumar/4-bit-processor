module data_memory(input clk,rst,write_en,input [3:0]data_in, input[3:0]address, output reg [3:0]data_out);

reg [3:0] memory [0:15];


always@(posedge clk or posedge write_en)
begin
               if (write_en)
                    begin   
                        memory[address]<=data_in;
                        
                    end
                else    
                    begin
                        data_out<=memory[address];
                    end
            end
endmodule
