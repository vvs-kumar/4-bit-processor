module control_unit(input clk,input reset,output reg[3:0]result,input D4,D5,D6,D7, output reg D0,D1,D2,D3);

reg [3:0]address;
reg [3:0]value;
reg [3:0]opcode;
reg [3:0]counter;

reg [3:0]delay_counter;
reg [3:0]DELAY_VALUE;



reg [4:0]flag_reg;
  //flag<=lesser_flag+greater_flag+equal_flag+carry_flag+borrow_flag;
  //flag=[0+1+2+3+4]
  //lesser=0
  //Greater=1
  //Equal=2
  //Carry=3
  //*/

reg [7:0]program_counter;
reg [3:0]pc1,pc2;


wire [7:0]rom_out;
    //Program memory
    program_memory rom(.clk(clk),.rst(reset),.address(program_counter),.data_out(rom_out));
    

reg [7:0]curr_instruction;
wire [3:0]opcode_out;
wire [3:0]operand;
    //Instrcution Decoder
    instruction_decoder decoder(.opcode_in(curr_instruction),.clk(clk),.rst(reset),.opcode(opcode_out),.operand(operand));
 
reg ram_w_en;
reg [3:0]ram_in;
reg [3:0]ram_add;
wire [3:0]ram_out;
    //Data Memory (Random Access Memory)
    data_memory ram(.clk(clk),.rst(reset),.write_en(ram_w_en),.data_in(ram_in),.address(ram_add),.data_out(ram_out));
  
reg [3:0]operand_a;  
reg [3:0]operand_b;
wire [3:0]alu_out;
wire [4:0]flag;
    //Arithmatic Logical Unit
    arithmatic_logic_unit alu(.clk(clk),.reset(reset),.opcode(opcode), .a(operand_a), .b(operand_b),.result(alu_out),.flag(flag));
    
reg [3:0]acc_in;
reg acc_en;
wire [3:0]acc_out;    
    //Accumulator
    accumulator ACCUMULATOR_4bit(.clk(clk),.in(acc_in), .acc_en(acc_en), .reset(reset), .acc_out(acc_out));
    
reg [1:0]out_pin;
reg [3:0]out_signal;
  
/*always@(posedge clk2)
    program_counter<=program_counter+4'b001;
*/
always@(posedge clk)
if(reset)
    begin
        opcode<=4'b0000;
        address<=4'b0000;
        value<=4'b0000;
        result<=4'b0000;
        delay_counter <= 4'b0000;
        program_counter<=4'b0000;
        curr_instruction<=8'b0000_0000;
        ram_w_en<=0;
        acc_en<=0;
        operand_a<=4'b0000;
        operand_b<=4'b0000;
        pc1<=4'b0000;
        pc2<=4'b0000;
        flag_reg<=5'b00000;
       end
else
    begin
    //program_memory rom(.clk(clk),.rst(reset),.address(program_counter_in),.data_out(rom_out));
            curr_instruction<=rom_out;
            if(counter<3)
                begin
                    counter<=counter+1;
                    delay_counter<=delay_counter+1;
                end
            else 
                begin
                        counter<=4'b0000;
                        program_counter<=program_counter+8'b0001;
                        delay_counter<=0;
                        ram_w_en<=0;
                        acc_en<=0;
                end
            case(opcode_out)
                    4'b0000:// HALT OPERATION
                        begin
                            delay_counter<=0;
                            counter<=0;
                        end
                    4'b0001://Adder opcode
                        begin
			    ram_w_en<=0;//Disable ram Write from any previous enable
			    acc_en<=1;//Enables the accumulator
                            acc_in<=alu_out;//Stores the value from alu to accumulator
                            opcode<=opcode_out;// Opcode decoded from instruction decoder.
                            address<=operand;// Address associated with Opcode here "4 BIT ADDITION"
                            ram_add<=address;// The address used to fetch data from data memory
                            operand_a<=ram_out;// The data is stored in operand_b.
                            operand_b<=acc_out;//Takes the accumulator value and pass to operand_a.
                            result<=alu_out;//Stores the operation result to the result register.
                        end
                    4'b0010://Subtraction opcode 
                        begin
                            ram_w_en<=0;//Disable ram Write from any previous enable
			    acc_en<=1;//Enables the accumulator
                            acc_in<=alu_out;//Stores the value from alu to accumulator
                            opcode<=opcode_out;// Opcode decoded from instruction decoder.
                            address<=operand;// Address associated with Opcode here "4 BIT SUBTRACTION"
                            ram_add<=address;// The address used to fetch data from data memory
                            operand_a<=ram_out;// The data is stored in operand_b.
                            operand_b<=acc_out;//Takes the accumulator value and pass to operand_a.
                            result<=alu_out;//Stores the operation result to the result register.
                        end
                    4'b0011://Bitwise AND
                        begin
                            ram_w_en<=0;//Disable ram Write from any previous enable
			    acc_en<=1;//Enables the accumulator
                            acc_in<=alu_out;//Stores the value from alu to accumulator
                            opcode<=opcode_out;// Opcode decoded from instruction decoder.
                            address<=operand;// Address associated with Opcode here "BITWISE AND"
                            ram_add<=address;// The address used to fetch data from data memory
                            operand_a<=ram_out;// The data is stored in operand_b.
                            operand_b<=acc_out;//Takes the accumulator value and pass to operand_a.
                            result<=alu_out;//Stores the operation result to the result register.
                        end
                    4'b0100://Bitwise OR
                        begin
                            ram_w_en<=0;//Disable ram Write from any previous enable
			    acc_en<=1;//Enables the accumulator
                            acc_in<=alu_out;//Stores the value from alu to accumulator
                            opcode<=opcode_out;// Opcode decoded from instruction decoder.
                            address<=operand;// Address associated with Opcode here "BITWISE OR"
                            ram_add<=address;// The address used to fetch data from data memory
                            operand_a<=ram_out;// The data is stored in operand_b.
                            operand_b<=acc_out;//Takes the accumulator value and pass to operand_a.
                            result<=alu_out;//Stores the operation result to the result register.
                        end
                    4'b0101://Bitwise XOR
                        begin
                            ram_w_en<=0;//Disable ram Write from any previous enable
			    acc_en<=1;//Enables the accumulator
                            acc_in<=alu_out;//Stores the value from alu to accumulator
                            opcode<=opcode_out;// Opcode decoded from instruction decoder.
                            address<=operand;// Address associated with Opcode here "BITWISE XOR"
                            ram_add<=address;// The address used to fetch data from data memory
                            operand_a<=ram_out;// The data is stored in operand_b.
                            operand_b<=acc_out;//Takes the accumulator value and pass to operand_a.
                            result<=alu_out;//Stores the operation result to the result register.
                        end
                    4'b0110://Bitwise CMP
                        begin
                            ram_w_en<=0;//Disable ram Write from any previous enable
                            acc_en<=1;
                            opcode<=opcode_out;// Opcode decoded from instruction decoder.
                            address<=operand;// Address associated with Opcode here "COMPARATOR"
                            ram_add<=address;// The address used to fetch data from data memory
                            operand_a<=ram_out;// The data is stored in operand_b.
                            operand_b<=acc_out;//Takes the accumulator value and pass to operand_a.
                            flag_reg<=flag;
                        end
                    4'b0111:// Jump to specific Program address
                        begin
                            ram_w_en<=0;
                            acc_en<=1;
                            address<=operand;
                            pc1<=ram_out;
                            pc2<=acc_out;
                            delay_counter<=delay_counter+1;
                            if(delay_counter>1  & counter==3);
                                begin
                                    program_counter[7:4]<=pc1;
                                    program_counter[3:0]<=pc2;
                                    delay_counter<=delay_counter+1;
                                    result<=0;
                                    flag_reg<=0;
                                    counter<=4'b0000;
                                    ram_w_en<=0;
                                    acc_en<=0;
                                 end
                            
                        end
                    4'b1000://Jump to another program address if zero
                        begin
                            ram_w_en<=0;
                            acc_en<=1;
                            address<=operand;
                            pc1<=ram_out;
                            delay_counter<=delay_counter+1;
                            if(acc_out==0  & counter==3)
                                begin
                                    program_counter[7:4]<=4'b0000;
                                    program_counter[3:0]<=pc1;
                                    delay_counter<=delay_counter+1;
                                    result<=0;
                                    flag_reg<=0;
                                    counter<=4'b0000;
                                    ram_w_en<=0;
                                    acc_en<=0;
                                end
                        end
                    4'b1001://Jump to another program address if Not zero
                        begin
                            ram_w_en<=0;
                            acc_en<=1;
                            address<=operand;
                            pc1<=ram_out;
                            delay_counter<=delay_counter+1;
                            if(acc_out!=0 & counter==3)
                                begin
                                    program_counter[7:4]<=4'b0000;
                                    program_counter[3:0]<=pc1;
                                    delay_counter<=delay_counter+1;
                                    result<=0;
                                    flag_reg<=0;
                                    counter<=4'b0000;
                                    ram_w_en<=0;
                                    acc_en<=0;
                                end
                        end
                    /*4'b1010://CALL syntax for subroutine
                        begin
                        end*/
                    4'b1011://Take value from input ports
                        begin
                            acc_en<=0;
                            ram_w_en<=0;
                            address<=operand;
                            ram_add<=address;
                            ram_in[3]<=D4;
                            ram_in[2]<=D5;
                            ram_in[1]<=D6;
                            ram_in[0]<=D7;
                        end
                    4'b1100://Loads the accumulator Value from data memory
                        begin
                            ram_w_en<=0;
                            acc_en<=1;//Enables the accumulator
                            address<=operand;
                            ram_add<=address;
                            acc_in=ram_out;
                        end
                    4'b1101://Stores Accumulator value to data memory
                        begin
                            acc_en<=1;
                            address<=operand;
                            ram_add<=address;
                            ram_w_en<=1;
                            ram_in<=acc_out;
                        end
                    4'b1110://Set up output ports 4'b1111 all ports high
                        begin
                            acc_en<=0;
                            ram_w_en<=0;
                            address<=operand;
                            ram_add<=address;
                            D0<=ram_out[3];
                            D1<=ram_out[2];
                            D2<=ram_out[1];
                            D3<=ram_out[0];
                            
                        end
                    4'b1111://LDI Load Immediate value to accumulator
                        begin
                            ram_w_en<=0;
                            acc_en<=1;
                            acc_in<=operand;
                           
                        end
		    default:
                        begin
                            delay_counter <= 0;
                            ram_w_en<=0;
                            acc_en<=0;//Disables the accumulator
                        end
           endcase
    end
   
endmodule
