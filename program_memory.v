module program_memory(input clk, rst, input [7:0] address, output reg [7:0] data_out);
  
  parameter MEM_SIZE = 28;// Using a 16 locations for 4 bit processor
  reg [7:0] memory [0:MEM_SIZE-1];
// 4 machine cycle is needed for each operation
initial
begin                           //Clock Cycles
memory[0]  = 8'b1111_0001;//LDI //4 Loads Value=0001 immediately to Accumulator
memory[1]  = 8'b1101_0001;//STA //4 Stores Accumulator value - RAM Location=4x0001(R1)
memory[2]  = 8'b1111_1000;//LDI //4 Loads Value=1000 immediately to Accumulator
memory[3]  = 8'b0001_0001;//ADD //4 ONLY or 2 check it Addition of Value stores in Accumulator(1000) and Memory Address Location=4x0001
memory[4]  = 8'b1101_0010;//STA Stores Accumulator value - RAM Location=4x0010(R2)

memory[5]  = 8'b1111_1111;//LDI Load Value = 1111 to Accumulator
memory[6]  = 8'b1101_0011;//STA Stores the value to RAM Location=4x0011;(R3)
memory[7]  = 8'b1111_0111;//LDI Load Value = 0111 to Accumulator
memory[8]  = 8'b0010_0011;//SUB Subtraction of value in ram=0011(1111) and 0111 = 8(decimal 16-7) 1000
memory[9]  = 8'b1101_0100;//STA Stores Accumulator value tp - RAM location=4x0100(R4)

memory[10] = 8'b1111_1010;//LDI Load Value = 1010 to Accumulator
memory[11] = 8'b1101_0101;//STA Stores the value to RAM Location=4x0101;(R5)
memory[12] = 8'b1111_0011;//LDI Load Value = 0011 to Accumulator
memory[13] = 8'b0011_0101;//AND Bitwise AND operation value in ram(R5)=1010 and value 0011 //OUPUT = 0010(Deciaml 2)
memory[14] = 8'b1101_0110;//STA Stores the value to RAM Location=4x0110;(R6)

memory[15] = 8'b1111_1111;//LDI Load Value = 1111 to Accumulator
memory[16] = 8'b1101_0111;//STA Stores the value to RAM Location=4x0111;(R7)
memory[17] = 8'b1111_0011;//LDI Load Value = 0011 to Accumulator
memory[18] = 8'b0110_0111;//CMP Compare operation and update flag in ram(R5)=1010 and value 0011 //OUPUT = 0010(Deciaml 2)
memory[19] = 8'b1101_1000 ;//STA Stores the value to RAM Location=4x1000;(R8)
memory[20] = 8'b1110_1000;
memory[21] = 8'b1011_1011;//Takes input ports value and stores in RAM Location=4x1011(R9)

memory[22] = 8'b1111_0000;//LDI Load Value = 0001 to Accumulator
memory[23] = 8'b1101_1111;//STA Stores the value to RAM Location=4x1111;(R16)
memory[24] = 8'b1111_0101;//LDI Load Value = 1001 to Accumulator
memory[25] = 8'b1001_1111;//JMP Jumps to specific program address Location=0001+0101(memory[21])

end

  // Read the memory value based on the address
  always @(posedge clk) begin
    data_out <= memory[address];
  end

endmodule
