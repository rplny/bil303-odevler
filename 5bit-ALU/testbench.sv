`timescale 1ns/1ps

module tb_alu5;
    logic [4:0] a, b;
    logic [1:0] secim;
    logic [4:0] cikis;
    logic       elde;

    alu5 uut (
        .a(a),
        .b(b),
        .secim(secim),
        .cikis(cikis),
        .elde(elde)
    );

    task automatic kontrol(
        input logic [4:0] a_deger,
        input logic [4:0] b_deger,
        input logic [1:0] sec,
        input logic [4:0] beklenen_cikis,
        input logic       beklenen_elde
    );
        a = a_deger;
        b = b_deger;
        secim = sec;
        #10;
        if (cikis !== beklenen_cikis || elde !== beklenen_elde)
            $display("HATA  secim=%b a=%b b=%b cikis=%b elde=%b | beklenen cikis=%b elde=%b",
                     secim, a, b, cikis, elde, beklenen_cikis, beklenen_elde);
        else
            $display("OK    secim=%b a=%b b=%b cikis=%b elde=%b",
                     secim, a, b, cikis, elde);
    endtask

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_alu5);

        kontrol(5'b00101, 5'b00011, 2'b00, 5'b01000, 1'b0);
        kontrol(5'b01100, 5'b00100, 2'b01, 5'b01000, 1'b1);
        kontrol(5'b10101, 5'b11001, 2'b10, 5'b01100, 1'b0);
        kontrol(5'b11100, 5'b10110, 2'b11, 5'b01011, 1'b0);
        kontrol(5'b11111, 5'b00001, 2'b00, 5'b00000, 1'b1);
        kontrol(5'b00100, 5'b00101, 2'b01, 5'b11111, 1'b0);
        kontrol(5'b01010, 5'b00101, 2'b10, 5'b01111, 1'b0);
        kontrol(5'b11111, 5'b11111, 2'b11, 5'b00000, 1'b0);

        $display("Test bitti");
        $finish;
    end
endmodule
