module CPU (clk, clr, read, write, address, memoryIn, memoryOut);
    input clk,clr;
    input [7:0] memoryOut;
    output [3:0] address;
    output [7:0] memoryIn;
    output read,write;


    wire [7:0] bus , alu;         //Bus in registers
    wire [7:0] dr,ac,ir;    // out of these registers
    wire [3:0] ar, pc; 
    wire cout;

    wire loadIR, incIR, clrIR;
    wire loadDR, incDR, clrDR;
    wire loadPC, incPC, clrPC;
    wire loadAR, incAR, clrAR;
    wire loadAC, incAC, clrAC;

    wire [7:0] t,d;

    wire [2:0] busSEL , aluOPCODE, sc;
    wire clrSC;

    //busSel options
    wire busIR, busDR, busPC, busAR, busAC, busMem;
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

    //read and write pins
    assign read = (d[0]&t[4]) | (d[1]&t[4]) |  (d[2]&t[4]) | (d[3]&t[4]) |  (d[4]&t[4]) | (d[6]&t[4]) | (t[3]&i) | t[1];
    assign write = (d[5]&t[4]);


    //When Register will be in Bus
    assign busIR = t[2];
    assign busDR = 0;
    assign busPC = t[0];
    assign busAR = 0;
    assign busAC = d[5]&t[4];
    assign aluOPCODE = ir[6:4];
    //whenever memory unit enters the bus, read pin will be set to 1

    MY_ENC83 encoder_busSEL({read,1'b0,busIR,busAC,busDR,busPC,busAR,1'b0}, busSEL);
    
    
    //MY_ENC83 encoder_aluOPCODE({opROUND,opCOMP2S,opSTORE,opLOAD,opDIV2,opXNOR,opASHL,opADD}, aluOPCODE);
    
    
    MY_BUS busRoad(8'b0, {4'b0,ar},{4'b0,pc},dr,ac,ir,8'b0,memoryOut , busSEL, bus);

    ALU aluUnit(clk,ac,dr,aluOPCODE,alu, cout);

    MY_SCOUNTER SCounter(clk,1'b1,clrSC,sc);

    MY_DEC38 decoder_instruction(ir[6:4],d);
    MY_DEC38 decoder_sc(sc,t);

    MY_REGA PC(clk,incPC,loadPC,clrPC,bus[3:0],pc);
    MY_REGA AR(clk,incAR,loadAR,clrAR,bus[3:0],ar);

    MY_REGD DR(clk,incDR,loadDR,clrDR,bus[7:0],dr);
    MY_REGD AC(clk,incAC,loadAC,clrAC,alu,ac);
    MY_REGD IR(clk,incIR,loadIR,clrIR,bus[7:0],ir);
    

endmodule