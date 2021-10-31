// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// @0 -> current screen index
// @1 -> value to set screen to

(START)
    @KBD
    D=M // Set data reg to keyboard input

    @R1
    M=-1 // Set screen register to -1

    @KEYPRESSED
    D;JGT // If a key is pressed, skip turning it to 0

    // Otherwise turn it to 0
    @R1
    M=0 // Set screen register to 0

    (KEYPRESSED)
    @SCREEN
    D=A
    @R0
    M=D // Set Reg 0 to start address of screen

    (LOOP)
        @R1
        D=M // Get 0 or -1 from reg 1
        @R0
        A=M // Get current address
        M=D // Set screen register to 0 or -1

        @R0
        M=M+1 // Increment screen address

        @KBD
        D=A
        @R0
        D=M-D
        @LOOP
        D;JLT // Jump back to beginning of loop if not time to break out

(END)
    @START
    0;JMP