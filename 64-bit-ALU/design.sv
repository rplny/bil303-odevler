`timescale 1ns/1ps

module tb_alu64;
    logic [63:0] a, b;
    logic [1:0]  secim;
    logic [63:0] cikis;

    alu64 devre (
        .a(a),
        .b(b),
        .secim(secim),
        .cikis(cikis)
    );

    task automatic sonucu_yaz(input logic [63:0] beklenen);
        #10;
        if (cikis !== beklenen)
            $display("HATA  secim=%b  a=%h  b=%h  cikis=%h  beklenen=%h",
                     secim, a, b, cikis, beklenen);
        else
            $display("OK    secim=%b  a=%h  b=%h  cikis=%h",
                     secim, a, b, cikis);
    endtask

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_alu64);

        a = 64'd40;
        b = 64'd25;
        secim = 2'b00;
        sonucu_yaz(64'd65);
        $display("add x16, x15, x5  ->  x16 = %0d", cikis);

        a = 64'd40;
        b = 64'd25;
        secim = 2'b01;
        sonucu_yaz(64'd15);

        a = 64'hFFFF_0000_FFFF_0000;
        b = 64'h0F0F_0F0F_0F0F_0F0F;
        secim = 2'b10;
        sonucu_yaz(64'h0F0F_0000_0F0F_0000);

        a = 64'hFFFF_0000_FFFF_0000;
        b = 64'h0F0F_0F0F_0F0F_0F0F;
        secim = 2'b11;
        sonucu_yaz(64'hFFFF_0F0F_FFFF_0F0F);

        a = 64'h0000_0000_0000_0001;
        b = 64'hFFFF_FFFF_FFFF_FFFF;
        secim = 2'b00;
        sonucu_yaz(64'h0);

        a = 64'h5;
        b = 64'h14;
        secim = 2'b01;
        sonucu_yaz(64'hFFFF_FFFF_FFFF_FFF1);

        a = 64'hFFFF_FFFF_FFFF_FFFF;
        b = 64'h0;
        secim = 2'b10;
        sonucu_yaz(64'h0);

        a = 64'hFFFF_FFFF_FFFF_FFFF;
        b = 64'h0;
        secim = 2'b11;
        sonucu_yaz(64'hFFFF_FFFF_FFFF_FFFF);

        $display("Test bitti");
        $finish;
    end
endmodule
