// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
//
// This program only needs to handle arguments that satisfy
// R0 >= 0, R1 >= 0, and R0*R1 < 32768.


//  First attempt: Slow method
//      Add R0 R1 times
//
//  Next attempt: Faster
//      Go Bit by Bit in R1 and do R0 += R0 n times, where n = the nth bit from the right
//     *Problem: Need to know when


// If mem[1] == 0, skip to end
@R1
D=M
@R2
M=0
@INF
D;JEQ

(LOOP)
    // D = mem[0]
    @R0
    D=M

    // mem[2] += D
    @R2
    M=M+D

    // mem[1]--
    @R1
    M=M-1

    // Loop if @1 > 0
    D=M
    @LOOP
    D;JGT

// Terminate in infinite loop
(INF)
@INF
0;JMP