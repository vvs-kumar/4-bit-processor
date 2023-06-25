module data_bus(input clk,rst,input wire enable,
                input wire [3:0] dataIn,a_in,b_in,input wire signal,
                output wire [3:0] dataOut,a_out,b_out, output wire signal_out);

reg [3:0] dataIn;

assign dataOut = enable ? dataIn : 4'bZ;
assign signal_out  = enable ? signal : 4'bZ;
assign a_out =  enable ? a_in : 4'bZ;
assign b_out  = enable ? b_in : 4'bZ;

endmodule
