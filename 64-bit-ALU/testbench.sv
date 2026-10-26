`timescale 1ns/1ps

module tb_alu4;
    logic [3:0] a, b;
    logic [1:0] secim;
    logic [3:0] cikis;

    alu4 devre (
        .a(a),
        .b(b),
        .secim(secim),
        .cikis(cikis)
    );

    task automatic sonucu_yaz(input logic [3:0] beklenen);
        #10;
        if (cikis !== beklenen)
            $display("HATA  secim=%b  a=%b  b=%b  cikis=%b  beklenen=%b",
                     secim, a, b, cikis, beklenen);
        else
            $display("OK    secim=%b  a=%b  b=%b  cikis=%b",
                     secim, a, b, cikis);
    endtask

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_alu4);

        a = 4'b0100;
        b = 4'b0101;
        secim = 2'b00;
        sonucu_yaz(4'b1001);

        a = 4'b0111;
        b = 4'b0010;
        secim = 2'b01;
        sonucu_yaz(4'b0101);

        a = 4'b1100;
        b = 4'b1010;
        secim = 2'b10;
        sonucu_yaz(4'b1000);

        a = 4'b1100;
        b = 4'b1010;
        secim = 2'b11;
        sonucu_yaz(4'b1110);

        a = 4'b1111;
        b = 4'b0001;
        secim = 2'b00;
        sonucu_yaz(4'b0000);

        a = 4'b0010;
        b = 4'b0011;
        secim = 2'b01;
        sonucu_yaz(4'b1111);

        a = 4'b1111;
        b = 4'b0000;
        secim = 2'b10;
        sonucu_yaz(4'b0000);

        a = 4'b1111;
        b = 4'b0000;
        secim = 2'b11;
        sonucu_yaz(4'b1111);

        $display("Test bitti");
        $finish;
    end
endmodule
//https://www.edaplayground.com/x/iACA
