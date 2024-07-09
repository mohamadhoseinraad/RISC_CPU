module tb_CPU;
    reg clk, rst;
    reg read, write;
    reg[7:0] memOut;
    reg[7:0] memIn;
    reg[3:0] address;
    

    //cpu registers
    wire[7:0] bus, dr, ac, ir, alu;
    wire[3:0] ar, pc;
    wire co;
    wire ldAR, ldPC, ldDR, ldAC, ldIR;
    wire rstAR, rstPC, rstDR, rstAC, rstIR, rstSC;
    wire incAR, incPC, incDR, incAC, incIR;
    //for example D7T6
    wire[7:0] t;
    wire[7:0] d;
    wire[2:0] busSel;
    wire[2:0] aluOp;
    wire[2:0] sc;
    wire addOp,subOp,compareOp,shiftOp,loadOp,storeOp,cmpOp,sqrtRootOp;
    wire busAR, busPC, busDR, busAC, busIR, busMem;
    wire i;
    

    //memIn is the memeory unit input that gets from bus
    // assign memIn = bus;
    // assign address = ar;
    // assign i = ir[7];

    // SC
    assign rstSC = (d[0]&t[5]) | (d[1]&t[5]) | (d[2]&t[5]) | (d[3]&t[6]) | (d[4]&t[5]) | (d[5]&t[4]) | (d[6]&t[6]) | (d[7]&t[6]) | rst;
    // alu
    assign addOp = d[0]&t[5];
    assign subOp = d[1]&t[5];
    assign compareOp = d[2]&t[5];
    assign shiftOp = d[3]&t[5];
    assign loadOp = d[4]&t[5];
    assign storeOp = d[5]&t[5];
    assign cmpOp = d[6]&t[5];
    assign sqrtRootOp = d[7]&t[5];
    
    //AR
    // T0:AR<-PC , T2:IR(0:3) , T3: moshakhas kardan direct/indirect if i=1 AR<-M[AR]
    assign ldAR = t[0] | t[2] | (i&t[3]);
    assign rstAR = 1'b0;
    assign incAR = 1'b0;
    // DR
    assign ldDR = d[0]&t[4] |d[1]&t[4] |d[2]&t[4] |d[3]&t[4] |d[4]&t[4] |d[6]&t[4] |d[7]&t[4];
    assign rstDR = 1'b0;
    assign incDR = 1'b0;
    // AC
    assign ldAC =d[0]&t[5] |d[1]&t[5] |d[2]&t[5] |d[3]&t[5] |d[4]&t[5] |d[6]&t[5] |d[7]&t[5];
    assign rstAC = 1'b0;
    assign incAC = 1'b0;
    // PC
    assign ldPC = 1'b0;
    assign rstPC = rst;
    //we go to pc++
    assign incPC = t[1];
    // IR
    assign ldIR = t[1];
    assign rstIR = 1'b0;
    assign incIR = 1'b0;
    // BUS
    //input of encoder bus 2 
    assign busAC =  (d[3]&t[6]) | (d[5]&t[4]) | (d[6]&t[6]) | (d[7]&t[6]);
    assign busAR = 1'b0;
    //DR is directly connected to AC
    assign busDR = 1'b0; 
    assign busIR = t[2];
    assign busPC = t[0];
    assign busMem = t[1] | (i&t[3]) |(d[0]&t[4])|(d[1]&t[4])|(d[2]&t[4])| (d[3]&t[4])|(d[4]&t[4])|(d[6]&t[4])|(d[7]&t[4]);
    // // Memory

    // assign read = t[1] | (i&t[3]) |(d[0]&t[4])|(d[1]&t[4])|(d[2]&t[4])| (d[3]&t[4])|(d[4]&t[4])|(d[6]&t[4])|(d[7]&t[4]);
    // assign write =  (d[3]&t[6])|(d[5]&t[4])|(d[6]&t[6])|(d[7]&t[6]);

    Encoder8to3 e1({1'b0, 1'b0, busMem, busIR, busAC, busDR, busPC, busAR}, busSel);
    //module BUS(input[7:0] i0, i1, i2, i3, i4, i5, i6, i7, input[2:0] s, output reg[7:0] out);
    //bus is the memory input that we put on the BUS
    BUS COM({4'b0, ar},{4'b0, pc}, dr, ac, ir, memOut, 8'bx, 8'bx, busSel, bus);

    //har bar ye bit yeke 
    Encoder8to3 e2({sqrtRootOp, cmpOp, storeOp, loadOp, shiftOp, compareOp, subOp, addOp}, aluOp);
    ALU LU(clk, dr, ac, aluOp, alu, co);

    Decoder3to8 d1(ir[6:4], d);

    Counter SC(clk, rstSC, 1'b1, sc);
    Decoder3to8 d2(sc, t);
    
    Register4 PC(clk, bus[3:0], ldPC, rstPC, incPC, pc);
    Register8 DR(clk, bus, ldDR, rstDR, incDR, dr);
    Register8 AC(clk, alu, ldAC, rstAC, incAC, ac);
    Register8 IR(clk, bus, ldIR, rstIR, incIR, ir);
    Register4 AR(clk, bus[3:0], ldAR, rstAR, incAR, ar);


    MY_MEMORY memUnit(clk,write,read,address,memIn,memOut);

    always @(posedge clk) begin
        memIn <= bus;
        address <= ar;
        read <= t[1] | (i&t[3]) |(d[0]&t[4])|(d[1]&t[4])|(d[2]&t[4])| (d[3]&t[4])|(d[4]&t[4])|(d[6]&t[4])|(d[7]&t[4]);
        write <=  (d[3]&t[6])|(d[5]&t[4])|(d[6]&t[6])|(d[7]&t[6]);
    end
    assign i = ir[7];

    initial begin
        clk = 0;
        rst = 1;
        #10 rst = 0;
        // Add more stimulus as needed
        forever #5 clk = ~clk;
    end


endmodule
