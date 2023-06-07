// Mult.asm
// Multiplies R0 and R1 and stores the result in R2.
// R0 >= 0 && R1 >= 0 && R0*R1 < 32768

@0          // Load RAM[0] into "number1"
D=M
@number1
M=D

@1          // Load RAM[1] into "number2"
D=M
@number2
M=D

@2          // Load RAM[2] address in "result_pointer"
D=A
@result_pointer
M=D

@i          // Initialize "i" counter
M=0

// TODO eventually check if @number1 == 0 || @number2 == 0

// for (i=0; i!=@number1; i++)...
(LOOP)      
    // if (@i == @number1) is true jump to END else i+=1
    @number1    // Store value of @number1 into D register
    D=M
    @i          
    D=D-M       // D = @number1 - @i

    @END        // Jump to END if (@number1 - @i == 0)
    D;JEQ
    @i          // Else increment i by 1
    M=M+1

    @number2    // Store value of @number2 into D register
    D=M
    @result_pointer // Get address of @result_pointer
    A=M
    M=M+D

    @LOOP       // Go back to start of LOOP
    0;JMP

(END)       // END label - Ends the program
    @END        // Infinite loop
    0;JMP