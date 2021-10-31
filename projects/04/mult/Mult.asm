// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
//
// This program only needs to handle arguments that satisfy
// R0 >= 0, R1 >= 0, and R0*R1 < 32768.


//  This Method: Faster for lower max values
//      Add R0 R1 times
//      This method has a min O(0) and max of O(32768)
//      If the lower number becomes R1 and the higher R0,
//      The max would be O(182), which is faster than the other method on average.
//                        (sqrt(int_max))
//
//  Other Method: Faster for higher max values
//      Go Bit by Bit in R1 and do R0 += R0 n times, where n = the nth bit from the right
//      Do this by 
//      This method has a min O(128) and max of O(256)
//                             (16^2)          2*(16^2)


// If mem[1] == 0, skip to end
@R1
D=M
@R2 // Initialize mem[2] to 0
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

    // Loop if mem[1] > 0
    D=M
    @LOOP
    D;JGT

// Terminate in infinite loop
(INF)
@INF
0;JMP








// Other Method Attempt

// test Register -> R3
// i Register -> R4
// temp Register -> R5
// j Register -> R6
// test will have 1 bit with 1 and 0s for all other bits
// i will go up linearly

// @R3 // Initialize test = 1
// M=1
// @R4 // Initialize i = 0
// M=0

// (LOOP)
//     @R3
//     D=M // D = test

//     // If R1 & test != 0, add R0^i
//     @R1
//     D=D&M
//     @SKIPADD
//     D;JEQ // Skip add

//     // temp = R0
//     @R0
//     D=M
//     @R5
//     M=D
    
//     // j = i
//     @R4
//     D=M
//     @R6
//     M=D

//     // Skip add loop if i <= 1
//     @R4
//     D=M
//     @DOADD
//     D-1;JLE

//     // Add Loop
//     (ADDLOOP)
//         // temp ^= 2
//         @5
//         D=M
//         D=D+D
//         M=D

//         // j--
//         @6
//         M=M-1
//         D=M

//         // Loop until 
//         @ADDLOOP
//         D;JNE

//     // Add to total (R2)
//     (DOADD)
//     @5
//     D=M
//     @2
//     M=D

//     // test++ (check whether M+M works)
//     (SKIPADD)
//     @R3
//     D=M
//     D=D+D
//     M=D

//     // i++
//     @R4
//     M=M+1

//     // i == 16 -> time to exit
//     D=M
//     @16
//     D-A;JNE

// (INF)
// @INF
// 0;JMP