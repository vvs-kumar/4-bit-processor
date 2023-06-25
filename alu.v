module arithmatic_logic_unit (input clk,input reset, input [3:0]opcode, a, b,output reg [3:0] result, output reg [4:0]flag);

//Declaring input as reg, output as wire for instantiation.
    reg [3:0] op_a_in;
    reg [3:0] op_b_in;
    reg [3:0] acc_in;
    reg acc_en;
    reg borrow_in;
    reg carry_in;
    wire [3:0] acc_out;
    wire [3:0] add_out;
    wire [3:0] sub_out;
    wire borrow_out;
    wire carry_out;
   
    
    reg lesser_flag;
    reg equal_flag;
    reg greater_flag;
    reg carry_flag;
    reg borrow_flag;
    
    //Accumulator
    
    adder ADDER_4bit(.operand_a(op_a_in[3:0]), .operand_b(op_b_in[3:0]),.carry_in(carry_in), .sum(add_out[3:0]), .carry(carry_out));
    subtractor SUBTRACTOR_4bit(.operand_a(op_a_in[3:0]),.operand_b(op_b_in[3:0]),.borrow_in(borrow_in),.difference(sub_out[3:0]), .borrow(borrow_out));
    
    parameter ADD = 4'b0001; //Add two operands and store it in accumulator
    parameter SUB = 4'b0010; //Sub two values and store it in accumulator.
    parameter AND = 4'b0011; //Performs AND operation between 2 operands.
    parameter OR = 4'b0100; //Performs AND operation between 2 operands.
    parameter XOR = 4'b0101; //Performs AND operation between 2 operands.
    parameter CMP = 4'b0110; //Performs AND operation between 2 operands. 
    
always@*
    flag<=lesser_flag+greater_flag+equal_flag+carry_flag+borrow_flag;

    // Instructions
// ADD,SUB,AND,OR,XOR,CMP
always@(posedge clk or posedge reset)
if(reset)
    begin
        carry_flag<=0;
        borrow_flag<=0;
        lesser_flag<=0;
        greater_flag<=0;
        equal_flag<=0;
        flag<=5'b00000;
    end
else
   	begin
		case(opcode)
			4'b0001://Addition of Immediate operand and value stored in accumulator.
				begin
				    carry_in<=carry_flag;
					op_a_in <= a;			// Set the first operand of the adder to the immediate value (a)
					op_b_in <= b;  // Set the second operand of the adder to the value in the accumulator
					result = add_out;
					acc_in <= add_out;   // Set the accumulator input to the output of the adder
					flag[1]<=carry_out;

				end
			4'b0010://Subtraction of Immediate operand and value stored in accumulator.
				begin
				    borrow_in<=borrow_flag;
					op_a_in <= a;            // Set the first operand of the subtractor to the immediate value (a)
					op_b_in <= b;  // Set the second operand of the subtractor to the value in the accumulator
					result = sub_out;       // Store the accumulator output in the "result" variable
					acc_in <= sub_out;    // Set the accumulator input to the output of the subtractor
					flag[0]<=borrow_out;
				end
			4'b0011:
			     result<=a&b;
			4'b0100:
			     result<=a|b;
			4'b0101:
			     result<=a^b;
			4'b0110:
			     begin
			        if (a == b)
			             begin
                            flag[4:2]<=3'b001;
                            //flag<=lesser_flag+greater_flag+equal_flag+carry_flag+borrow_flag;
                         end
                    else if (a > b)
                         begin
                            flag[4:2]<=3'b010;
                            //flag<=lesser_flag+greater_flag+equal_flag+carry_flag+borrow_flag;
                         end
                    if(a < b)
                        begin
                            flag[4:2]<=3'b100;
                            //flag<=lesser_flag+greater_flag+equal_flag+carry_flag+borrow_flag;
                         end
			     end
			     
			default:
				begin
					result<=4'b0000;
				end
		endcase
	end
endmodule
