`timescale 1ns / 1ps

module LCA_32(
    input [31:0] A,
    input [31:0] B,
    input C0,
    output [31:0] F,
    output C2       );

    wire [2:0] C;
    reg [1:0] P, G;
    reg [7:0] P_t, G_t;
    wire [31:0] p,g;

    assign p = A | B;
    assign g = A & B;
    task cal_PG_4;
        input [3:0] p,g;
        output reg P,G;
        begin
            P = p[3] & p[2] & p[1] & p[0];
            G = g[3] | p[3] & g[2] | p[3] & p[2] & g[1] | p[3] & p[2] & p[1] & g[0];
        end
    endtask
    always @* begin
        cal_PG_4(p[3:0],g[3:0],P_t[0],G_t[0]);
        cal_PG_4(p[7:4],g[7:4],P_t[1],G_t[1]);
        cal_PG_4(p[11:8],g[11:8],P_t[2],G_t[2]);
        cal_PG_4(p[15:12],g[15:12],P_t[3],G_t[3]);
        cal_PG_4(p[19:16],g[19:16],P_t[4],G_t[4]);
        cal_PG_4(p[23:20],g[23:20],P_t[5],G_t[5]);
        cal_PG_4(p[27:24],g[27:24],P_t[6],G_t[6]);
        cal_PG_4(p[31:28],g[31:28],P_t[7],G_t[7]);
        cal_PG_4(P_t[3:0],G_t[3:0],P[0],G[0]);
        cal_PG_4(P_t[7:4],G_t[7:4],P[1],G[1]);
    end
    assign C[0] = C0;
    assign C[1] = G[0] | P[0] & C[0];
    assign C[2] = G[1] | P[1] & G[0] | P[1] & P[0] & C[0];

    LCA_16 uu1(A[15:0], B[15:0], C[0], F[15:0], );
    LCA_16 uu2(A[31:16], B[31:16], C[1], F[31:16], );
    assign C2 = C[2];

endmodule

module LCA_16(    
    input [15:0] A,
    input [15:0] B,
    input C0,
    output [15:0] F,
    output C4       );

    wire [4:0] C;
    reg [3:0] P, G;
    wire [15:0] p, g;

    assign p = A | B;
    assign g = A & B;
    task cal_PG;
        input [3:0] p,g;
        output reg P,G;
        begin
            P = p[3] & p[2] & p[1] & p[0];
            G = g[3] | p[3] & g[2] | p[3] & p[2] & g[1] | p[3] & p[2] & p[1] & g[0];
        end
    endtask
    always @* begin
        cal_PG(p[3:0],g[3:0],P[0],G[0]);
        cal_PG(p[7:4],g[7:4],P[1],G[1]);
        cal_PG(p[11:8],g[11:8],P[2],G[2]);
        cal_PG(p[15:12],g[15:12],P[3],G[3]);        
    end    
    assign C[0] = C0;
    assign C[1] = G[0] | P[0] & C[0];
    assign C[2] = G[1] | P[1] & G[0] | P[1] & P[0] & C[0];
    assign C[3] = G[2] | P[2] & G[1] | P[2] & P[1] & G[0] | P[2] & P[1] & P[0] & C[0];
    assign C[4] = G[3] | P[3] & G[2] | P[3] & P[2] & G[1] | P[3] & P[2] & P[1] & G[0] | P[3] & P[2] & P[1] & P[0] & C[0];

    LCA_Adder uu1(A[3:0], B[3:0], C[0], F[3:0], );
    LCA_Adder uu2(A[7:4], B[7:4], C[1], F[7:4], );
    LCA_Adder uu3(A[11:8], B[11:8], C[2], F[11:8], );
    LCA_Adder uu4(A[15:12], B[15:12], C[3], F[15:12], );
    assign C4 = C[4];

endmodule

module LCA_Adder(
    input [3:0] A,
    input [3:0] B,
    input C0,
    output [3:0] F,
    output C4       );

    wire [4:0] C;
    wire [3:0] P, G;

    assign P = A | B;
    assign G = A & B;

    assign C[0] = C0;
    assign C[1] = G[0] | P[0] & C[0];
    assign C[2] = G[1] | P[1] & G[0] | P[1] & P[0] & C[0];
    assign C[3] = G[2] | P[2] & G[1] | P[2] & P[1] & G[0] | P[2] & P[1] & P[0] & C[0];
    assign C[4] = G[3] | P[3] & G[2] | P[3] & P[2] & G[1] | P[3] & P[2] & P[1] & G[0] | P[3] & P[2] & P[1] & P[0] & C[0];

    full_adder uu1(A[0], B[0], C[0], F[0], );
    full_adder uu2(A[1], B[1], C[1], F[1], );
    full_adder uu3(A[2], B[2], C[2], F[2], );
    full_adder uu4(A[3], B[3], C[3], F[3], );
    assign C4 = C[4];
endmodule

module full_adder(A, B, Cin, Sum, Cout);
    input A, B, Cin;
    output Sum, Cout;
    wire S1, T1, T2, T3;
    xor uu1(S1, A, B);
    xor uu2(Sum, S1, Cin);
    
    and uu3(T1, A, B);
    and uu4(T2, A, Cin);
    and uu5(T3, B, Cin);
    
    or  uu6(Cout, T1, T2, T3);
endmodule
