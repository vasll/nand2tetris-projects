// Draws a rectangle of width 16 and height of RAM[0] (N) pixels

@SCREEN     // Load screen's base address
D=A
@screen_address
M=D

@0          // Load RAM[0] into "height"
D=M
@height
M=D

@i          // Init i counter
M=0

// "Drawer" loop
(LOOP)
    @i          // Load i into D register
    D=M
    @height     // height = height - i
    D=D-M  
    @END        // if (i > height) goto END
    D;JGT
    
    // Flip all the bits to 1 at the current screen address
    @screen_address 
    A=M
    M=-1

    @i          // i = i + 1
    M=M+1
    @32         // Load value '32' into D register
    D=A
    @screen_address
    M=D+M   // screen_address = screen_address + 32 (goes to next row)

    @LOOP       // GOTO LOOP label
    0;JMP

(END)
    @END        // Infinite loop to terminate program
    0;JMP




