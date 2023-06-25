`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.05.2023 23:10:45
// Design Name: 
// Module Name: input_ports
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module input_ports(input D4,D5,D6,D7,output reg signal, output reg [1:0]pin_in);
always@*
begin
    case(D4)
        1'b1:
            begin
                pin_in<=2'b00;
                signal<=1;
            end
        1'b0:
            begin
                pin_in<=2'b00;
                signal<=0;
            end
    endcase
    case(D5)
        1'b1:
            begin
                pin_in<=2'b01;
                signal<=1;
            end
        1'b0:
            begin
                pin_in<=2'b01;
                signal<=0;
            end
    endcase
    case(D6)
        1'b1:
            begin
                pin_in<=2'b10;
                signal<=1;
            end
        1'b0:
            begin
                pin_in<=2'b10;
                signal<=0;
            end
    endcase
    case(D7)
        1'b1:
            begin
                pin_in<=2'b11;
                signal<=1;
            end
        1'b0:
            begin
                pin_in<=2'b11;
                signal<=0;
            end
    endcase
        
end
endmodule
