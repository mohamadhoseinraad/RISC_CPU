module CPU (clk, clr, read, write, address, memoryIn, memoryOut);
    input clk,clr;
    input [7:0] memoryOut;
    output [3:0] address;
    output [7:0] memoryIn;
    output read,write;


    wire [7:0] bus;         //Bus in registers
    wire [7:0] dr,ac,ir;    // out of these registers
    wire [3:0] ar, pc; 
    wire cout;

    wire loadIR, incIR, clrIR;
    wire loadDR, incDR, clrDR;
    wire loadPC, incPC, clrPC;
    wire loadAR, incAR, clrAR;
    wire loadAC, incAC, clrAC;

    wire [7:0] t,d;

    wire [2:0] busSEL , aluOpcode, sc;

    //busSel options
    wire busIR, busDR, busPC, busAR, busAC;
    //aluOpCode options
    wire opADD, opASHL, opXNOR, opDIV2, opLOAD, opSTORE, opCOMP2S;

    //Address mode
    wire i;

    assign memoryIn = bus;
    assign address = ar;
    assign i = ir[7];






endmodule