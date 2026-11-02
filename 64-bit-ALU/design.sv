module bit_toplayici (
    input  logic x,
    input  logic y,
    input  logic cin,
    output logic toplam,
    output logic cout
);
    assign toplam = x ^ y ^ cin;
    assign cout   = (x & y) | (x & cin) | (y & cin);
endmodule

module ripple4 (
    input  logic [3:0] x,
    input  logic [3:0] y,
    input  logic       cin,
    output logic [3:0] toplam,
    output logic       cout
);
    logic [4:0] tasima;
    assign tasima[0] = cin;

    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin : kademe
            bit_toplayici hucre (
                .x(x[i]),
                .y(y[i]),
                .cin(tasima[i]),
                .toplam(toplam[i]),
                .cout(tasima[i + 1])
            );
        end
    endgenerate

    assign cout = tasima[4];
endmodule

module alu4 (
    input  logic [3:0] a,
    input  logic [3:0] b,
    input  logic [1:0] secim,
    output logic [3:0] cikis,
    output logic       elde
);
    logic [3:0] toplama_sonuc, cikarma_sonuc, and_sonuc, or_sonuc, b_ters;
    logic       toplama_elde, cikarma_elde;

    ripple4 toplayici (
        .x(a), .y(b), .cin(1'b0),
        .toplam(toplama_sonuc), .cout(toplama_elde)
    );

    assign b_ters = ~b;

    ripple4 cikarici (
        .x(a), .y(b_ters), .cin(1'b1),
        .toplam(cikarma_sonuc), .cout(cikarma_elde)
    );

    assign and_sonuc = a & b;
    assign or_sonuc  = a | b;

    always_comb begin
        unique case (secim)
            2'b00: begin cikis = toplama_sonuc; elde = toplama_elde; end
            2'b01: begin cikis = cikarma_sonuc; elde = cikarma_elde; end
            2'b10: begin cikis = and_sonuc;     elde = 1'b0;         end
            2'b11: begin cikis = or_sonuc;      elde = 1'b0;         end
            default: begin cikis = 4'b0000;     elde = 1'b0;         end
        endcase
    end
endmodule
