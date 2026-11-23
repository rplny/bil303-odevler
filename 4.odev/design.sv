module bit_toplayici (
    input  logic x,
    input  logic y,
    input  logic cin,
    output logic toplam,
    output logic cout
);
    assign toplam = x ^ y ^ cin;
    assign cout   = (x & y) | (cin & (x ^ y));
endmodule

module ripple5 (
    input  logic [4:0] x,
    input  logic [4:0] y,
    input  logic       cin,
    output logic [4:0] toplam,
    output logic       cout
);
    logic [5:0] tasima;
    assign tasima[0] = cin;

    genvar i;
    generate
        for (i = 0; i < 5; i = i + 1) begin : kademe
            bit_toplayici hucre (
                .x(x[i]),
                .y(y[i]),
                .cin(tasima[i]),
                .toplam(toplam[i]),
                .cout(tasima[i + 1])
            );
        end
    endgenerate

    assign cout = tasima[5];
endmodule

module ripple10 (
    input  logic [9:0] x,
    input  logic [9:0] y,
    input  logic       cin,
    output logic [9:0] toplam,
    output logic       cout
);
    logic [10:0] tasima;
    assign tasima[0] = cin;

    genvar i;
    generate
        for (i = 0; i < 10; i = i + 1) begin : kademe
            bit_toplayici hucre (
                .x(x[i]),
                .y(y[i]),
                .cin(tasima[i]),
                .toplam(toplam[i]),
                .cout(tasima[i + 1])
            );
        end
    endgenerate

    assign cout = tasima[10];
endmodule

module and_kapisi (
    input  logic x,
    input  logic y,
    output logic z
);
    assign z = x & y;
endmodule

module and5 (
    input  logic [4:0] a,
    input  logic [4:0] b,
    output logic [4:0] y
);
    genvar i;
    generate
        for (i = 0; i < 5; i = i + 1) begin : bit
            and_kapisi kapi (
                .x(a[i]),
                .y(b[i]),
                .z(y[i])
            );
        end
    endgenerate
endmodule

module carpici5 (
    input  logic [4:0] a,
    input  logic [4:0] b,
    output logic [4:0] carpim,
    output logic       tasma
);
    logic [4:0] maske [4:0];
    logic [9:0] p0, p1, p2, p3, p4;
    logic [9:0] s1, s2, s3, s4;
    logic       c1, c2, c3, c4;

    genvar i, j;
    generate
        for (i = 0; i < 5; i = i + 1) begin : carpan_biti
            for (j = 0; j < 5; j = j + 1) begin : carpilacak_bit
                and_kapisi kapi (
                    .x(a[j]),
                    .y(b[i]),
                    .z(maske[i][j])
                );
            end
        end
    endgenerate

    assign p0 = {5'b00000, maske[0]};
    assign p1 = {4'b0000, maske[1], 1'b0};
    assign p2 = {3'b000, maske[2], 2'b00};
    assign p3 = {2'b00, maske[3], 3'b000};
    assign p4 = {1'b0, maske[4], 4'b0000};

    ripple10 ekle1 (.x(p0), .y(p1), .cin(1'b0), .toplam(s1), .cout(c1));
    ripple10 ekle2 (.x(s1), .y(p2), .cin(1'b0), .toplam(s2), .cout(c2));
    ripple10 ekle3 (.x(s2), .y(p3), .cin(1'b0), .toplam(s3), .cout(c3));
    ripple10 ekle4 (.x(s3), .y(p4), .cin(1'b0), .toplam(s4), .cout(c4));

    assign carpim = s4[4:0];
    assign tasma  = (|s4[9:5]) | c1 | c2 | c3 | c4;
endmodule

module alu5 (
    input  logic [4:0] a,
    input  logic [4:0] b,
    input  logic [1:0] secim,
    output logic [4:0] cikis,
    output logic       elde
);
    logic [4:0] toplama_sonuc;
    logic [4:0] cikarma_sonuc;
    logic [4:0] and_sonuc;
    logic [4:0] carpma_sonuc;
    logic [4:0] b_ters;
    logic       toplama_elde;
    logic       cikarma_elde;
    logic       carpma_tasma;

    ripple5 toplayici (
        .x(a),
        .y(b),
        .cin(1'b0),
        .toplam(toplama_sonuc),
        .cout(toplama_elde)
    );

    assign b_ters = ~b;

    ripple5 cikarici (
        .x(a),
        .y(b_ters),
        .cin(1'b1),
        .toplam(cikarma_sonuc),
        .cout(cikarma_elde)
    );

    and5 ve_kapilari (
        .a(a),
        .b(b),
        .y(and_sonuc)
    );

    carpici5 carpma (
        .a(a),
        .b(b),
        .carpim(carpma_sonuc),
        .tasma(carpma_tasma)
    );

    always_comb begin
        unique case (secim)
            2'b00: begin
                cikis = toplama_sonuc;
                elde  = toplama_elde;
            end
            2'b01: begin
                cikis = cikarma_sonuc;
                elde  = cikarma_elde;
            end
            2'b10: begin
                cikis = and_sonuc;
                elde  = 1'b0;
            end
            2'b11: begin
                cikis = carpma_sonuc;
                elde  = carpma_tasma;
            end
            default: begin
                cikis = 5'b00000;
                elde  = 1'b0;
            end
        endcase
    end
endmodule
