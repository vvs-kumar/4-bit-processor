`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.05.2023 22:55:53
// Design Name: Microprocessor V1 VVS
// Module Name: output_ports
// Project Name: Micro V1
// Target Devices: Hobby
// Tool Versions: V1
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module output_ports (input [1:0] pin, input [3:0] signal, output reg D0, D1, D2, D3);

always @* begin
    case (pin)
        2'b00: D0 <= signal[0];  // Assign the value of signal[0] to D0 when pin is '00'
        2'b01: D1 <= signal[1];  // Assign the value of signal[1] to D1 when pin is '01'
        2'b10: D2 <= signal[2];  // Assign the value of signal[2] to D2 when pin is '10'
        2'b11: D3 <= signal[3];  // Assign the value of signal[3] to D3 when pin is '11'
    endcase
end

endmodule
