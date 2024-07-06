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
    wire clrSC;

    //busSel options
    wire busIR, busDR, busPC, busAR, busAC;
    //aluOpCode options
    wire opADD, opASHL, opXNOR, opDIV2, opLOAD, opSTORE, opCOMP2S,opROUND;

    //Address mode
    wire i;

    assign memoryIn = bus;
    assign address = ar;
    assign i = ir[7];


    //SC assign clrSC is 0 if clr is 1 or end of commands                                           //OP ROunddddd !!!!!

    assign clrSC = clr | (d[0]&t[5]) | (d[1]&t[5]) |  (d[2]&t[5]) | (d[3]&t[5]) |  (d[4]&t[5]) | (d[5]&t[4]) | (d[6]&t[5]);

    //when op for alu is active                                                                    //OP ROundddd !!!

    assign opADD = d[0]&t[5];
    assign opASHL = d[1]&t[5];
    assign opXNOR = d[2]&t[5];
    assign opDIV2 = d[3]&t[5];
    assign opLOAD = d[4]&t[5]; 
    assign opSTORE = d[5]&t[4];
    assign opCOMP2S = d[6]&t[5];


    //IR pins :
    assign loadIR = t[1];
    assign incIR = 0;
    assign clrIR = 0;

    //DR pins :
    assign loadDR = (d[0]&t[4]) | (d[1]&t[4]) |  (d[2]&t[4]) | (d[3]&t[4]) |  (d[4]&t[4]) | (d[6]&t[4]);
    assign incDR = 0;
    assign clrDR = 0;

    //PC pins :
    assign loadPC = 0;
    assign incPC = t[1];
    assign clrPC = clr;

    //AR pins :
    assign loadAR = t[0] | t[2] | (i&t[3]);
    assign incAR = 0;
    assign clrAR = 0;

    //AC pins :
    assign loadAC = (d[0]&t[5]) | (d[1]&t[5]) |  (d[2]&t[5]) | (d[3]&t[5]) |  (d[4]&t[5]) | (d[6]&t[5]);
    assign incAC = 0;
    assign clrAC = 0;

    


endmodule