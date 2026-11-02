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

module alu5 (
    input  logic [4:0] a,
    input  logic [4:0] b,
    input  logic [1:0] secim,
    output logic [4:0] cikis,
    output logic       elde
);
    logic [4:0] toplama_sonuc;
    logic [4:0] cikarma_sonuc;
    logic [4:0] xor_sonuc;
    logic [4:0] nand_sonuc;
    logic [4:0] b_ters;
    logic       toplama_elde;
    logic       cikarma_elde;

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

    assign xor_sonuc  = a ^ b;
    assign nand_sonuc = ~(a & b);

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
                cikis = xor_sonuc;
                elde  = 1'b0;
            end
            2'b11: begin
                cikis = nand_sonuc;
                elde  = 1'b0;
            end
            default: begin
                cikis = 5'b00000;
                elde  = 1'b0;
            end
        endcase
    end
endmodule
