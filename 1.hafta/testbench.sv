`timescale 1ns/1ps

module tb_dortten_bire_mux;

    logic [7:0] kaynak0, kaynak1, kaynak2, kaynak3;
    logic [1:0] secim;
    logic [7:0] cikis;

    dortten_bire_mux devre (
        .kaynak0(kaynak0),
        .kaynak1(kaynak1),
        .kaynak2(kaynak2),
        .kaynak3(kaynak3),
        .secim(secim),
        .cikis(cikis)
    );

   
    task automatic sonucu_yaz(input logic [7:0] beklenen);
        #10;
        if (cikis !== beklenen)
            $display("HATA  secim=%b  cikis=%b  beklenen=%b", secim, cikis, beklenen);
        else
            $display("OK    secim=%b  cikis=%b", secim, cikis);
    endtask

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_dortten_bire_mux);

       
        kaynak0 = 8'b0000_0001;
        kaynak1 = 8'b0001_0000;
        kaynak2 = 8'b0100_0000;
        kaynak3 = 8'b1000_0000;

        secim = 2'b00; sonucu_yaz(kaynak0);
        secim = 2'b01; sonucu_yaz(kaynak1);
        secim = 2'b10; sonucu_yaz(kaynak2);
        secim = 2'b11; sonucu_yaz(kaynak3);

       
        kaynak0 = 8'h00;
        kaynak1 = 8'hFF;
        kaynak2 = 8'h0F;
        kaynak3 = 8'hF0;

        secim = 2'b00; sonucu_yaz(kaynak0);
        secim = 2'b01; sonucu_yaz(kaynak1);
        secim = 2'b10; sonucu_yaz(kaynak2);
        secim = 2'b11; sonucu_yaz(kaynak3);

        $display("Test bitti");
        $finish;
    end

endmodule
