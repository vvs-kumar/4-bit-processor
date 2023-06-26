# 4-bit-processor
This is a 4-bit processor with 16 Instruction sets inspired by intel 4004

Specifications:
	4-Bit processor
	2040(2Kb)-bit program memory
	64 bits data memory
	Operating frequency 100-1000 kHz
	5 Bit flag register (Great, Less, Equal, Carry, Borrow)
 ```
Pin Numbers: 	
             +---\/---+
        RST 1|        |14 VCC
         D0 2|        |13 D8
         D1 3|        |12 D7
         D2 4|        |11 D6
         D3 5|        |10 D7
        CLK 6|        |9  NC
        GND 7|        |8  Result
             +--------+
```
Instruction sets. 
	NOP - 0000
	ADD - 0001
	SUB - 0010
	AND - 0011
	OR - 0100	
  XOR - 0101
	CMP - 0110
	JMP - 0111
	JZ - 1000
	JNZ - 1001
	HALT - 1010
	RIN - 1011
	LDA - 1100
	STA - 1101
	WOP - 1110
	LDI - 1111


Instruction Set Description :
	NOP – No Operation occurs in that program cycle.
	ADD – Addition of 2 (4 bit) number with carry, the carry is updated in flag register, one value should be loaded in Ram and other from Accumulator.
	SUB – Subtraction of 2 (4 bit) number with carry, the borrow is updated in flag register, one value should be loaded in Ram and other from Accumulator.
	AND – Bitwise AND operation between 2 (4 bit) numbers, one value should be loaded in Ram and other from Accumulator.
	OR – Bitwise OR operation between 2 (4 bit) numbers, one value should be loaded in Ram and other from Accumulator.
	XOR – Bitwise XOR operation between 2 (4 bit) numbers, one value should be loaded in Ram and other from Accumulator.
	CMP – Bitwise CMP operation between 2 (4 bit) numbers (Greater, Lesser, Equal flags are updated in flag register).
	JMP – Jumps to specific program address out of 8-bit location, first 4 bits are retrieved from RAM location 4’b1111 and other value should be stored in Accumulator and 8 bit value is used for jumping to a program address
	JZ – Jumps to specific program address if accumulator value is “0” but limited to first 16 location of Program memory(Will update this problem soon), address needs to be stored in reserved jump address in RAM location 4’b1111.
	JNZ – Jumps to specific program address if accumulator value is not “0” but limited to first 16 location of Program memory(Will update this problem soon), address needs to be stored in reserved jump address in RAM location 4’b1111. 
	HALT – Halt the program execution and make the processor to an idle state.
	RIN – Reads the input pins D4, D5, D6, D7 pins and stores in RAM as bit value(On – 1, OFF - 0) to specified address.
	LDA – Load Accumulator, Loads the Accumulator with a value from RAM address location.	STA – Stores Accumulator value to specific RAM address, specified along with Instruction.
	WOP – Write the values from specified RAM location to 4 different outputs, 1 as ON and 0 as OFF.
	LDI – Loads an immediate value to the accumulator , value specified along with the instructions.

			



Each operation updates the result register and output can be obtained periodically, Input clock is powered by internal clock, need to update with external clock. Operations involving flag register updates the value in control unit, RAM location 1111(16) is reserved for Program Jump operation.
Program memory has 256 locations, controlled by 8-bit values, the values are stored in LUT.
	

