// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.
// 16bit*32=512px (Screen width.  512 Columns)
// 16bit*16=256px (Screen height. 256 Rows)
// 512px*256px = 131072px (Screen total pixels)

@16384              // Go to screen address
D=A
@screen_pointer     // Store screen base address     
M=D

@24576              // Go to keyboard address
D=A                 // Store address in D register
@keyboard_pointer   // Store address of keyboard
M=D

@8192               // Total screen addresses: 24576 - 16384 = 8192
D=A
@screen_address_cnt // Keep the count of how many 16bit screen addresses are there
M=D


// keyboard listener loop
(LOOP)
    @keyboard_pointer   // Set current address to keyboard address
    A=M
    D=M                 // Store key value into D register

    @CLEAR              // If key (D register) == 0 jump to CLEAR
    D;JEQ

    @FILL               // If key (D register) != 0 jump to FILL
    D;JNE

    @LOOP               // Go back to start of loop
    0;JMP


// Colors the display black and goes back to LOOP
(FILL)
    @screen_address_cnt
    D=M
    @row_reg_counter    // Set row_reg_counter to 32
    M=D

    (FILL_SCREEN)
        @screen_pointer     // Go to screen_pointer
        A=M                 
        M=-1                // Set all 16 bits of current register to 1

        @screen_pointer     // Set pointer to next 16bit register
        M=M+1

        @row_reg_counter    // Decrement row_reg_counter by 1
        M=M-1
        D=M

        @FILL_SCREEN           // If (row_reg_counter > 0) GOTO FILL_SCREEN
        D;JGT

    // Reset screen pointer to 16348
    @16384
    D=A
    @screen_pointer
    M=D

    @LOOP               // Jump back to LOOP
    0;JMP


// Clear the display and goes back to LOOP
(CLEAR)
    @screen_address_cnt
    D=M
    @row_reg_counter    // Set row_reg_counter to 32
    M=D

    (CLEAR_SCREEN)
        @screen_pointer     // Go to screen_pointer
        A=M                 
        M=0                // Set all 16 bits of current register to 1

        @screen_pointer     // Set pointer to next 16bit register
        M=M+1

        @row_reg_counter    // Decrement row_reg_counter by 1
        M=M-1
        D=M

        @CLEAR_SCREEN           // If (row_reg_counter > 0) GOTO CLEAR_SCREEN
        D;JGT

    // Reset screen pointer to 16348
    @16384
    D=A
    @screen_pointer
    M=D

    @LOOP               // Jump back to LOOP
    0;JMP


// Ends the program
(END)
    @END
    0;JMP