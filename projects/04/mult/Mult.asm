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


// // If mem[1] == 0, skip to end
// @R1
// D=M
// @R2 // Initialize mem[2] to 0
// M=0
// @INF
// D;JEQ

// (LOOP)
//     // D = mem[0]
//     @R0
//     D=M

//     // mem[2] += D
//     @R2
//     M=M+D

//     // mem[1]--
//     @R1
//     M=M-1

//     // Loop if mem[1] > 0
//     D=M
//     @LOOP
//     D;JGT

// // Terminate in infinite loop
// (INF)
// @INF
// 0;JMP








// Other Method Attempt

// test Register -> test
// i Register -> i
// temp Register -> temp
// j Register -> j
// test will have 1 bit with 1 and 0s for all other bits
// i will go up linearly

@test // Initialize test = 1
M=1
@i // Initialize i = 0
M=0
@R2
M=0

(LOOP)
    // i == 16 -> time to exit
    @i
    D=M
    @16
    D=D-A
    @INF
    D;JEQ

    // Skip add if test is true
    @test
    D=M
    @R1
    D=D&M // D = 0 if not in R1
    @SKIPADD // Skip if D == 0
    D;JEQ

    // temp = R0
    @R0
    D=M
    @temp
    M=D
    
    // j = i
    @i
    D=M
    @j
    M=D

    // Add Loop
    (ADDLOOP)
        // Exit if j == 0
        @j
        D=M
        @DOADD
        D;JEQ

        // temp ^= 2
        @temp
        D=M
        D=D+M
        M=D

        // j--
        @j
        M=M-1
        D=M

        // Go back to beginning
        @ADDLOOP
        0;JMP

    // Add to total (R2)
    (DOADD)
    @temp
    D=M
    @R2
    M=M+D

    // test++
    (SKIPADD)
    @test
    D=M
    D=D+M
    M=D

    // i++
    @i
    M=M+1

    @LOOP
    0;JMP

(INF)
@INF
0;JMP