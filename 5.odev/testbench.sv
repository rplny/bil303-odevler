`timescale 1ns/1ps

module tb_ieee_coz;

    logic [31:0] giris;
    logic        isaret;
    logic [7:0]  us;
    logic [22:0] kesir;
    logic        sifir, altnormal, normal, sonsuz, nan;

    ieee_coz devre (
        .giris(giris),
        .isaret(isaret),
        .us(us),
        .kesir(kesir),
        .sifir(sifir),
        .altnormal(altnormal),
        .normal(normal),
        .sonsuz(sonsuz),
        .nan(nan)
    );

    task automatic sonucu_yaz(
        input logic [31:0] deger,
        input logic        beklenen_sifir,
        input logic        beklenen_altnormal,
        input logic        beklenen_normal,
        input logic        beklenen_sonsuz,
        input logic        beklenen_nan
    );
        giris = deger;
        #10;
        if (sifir !== beklenen_sifir || altnormal !== beklenen_altnormal ||
            normal !== beklenen_normal || sonsuz !== beklenen_sonsuz ||
            nan !== beklenen_nan)
            $display("HATA  giris=%h sifir=%b altnormal=%b normal=%b sonsuz=%b nan=%b",
                     giris, sifir, altnormal, normal, sonsuz, nan);
        else
            $display("OK    giris=%h isaret=%b us=%h kesir=%h sinif=%s",
                     giris, isaret, us, kesir,
                     sifir ? "sifir" : altnormal ? "altnormal" : normal ? "normal" :
                     sonsuz ? "sonsuz" : "nan");
    endtask

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_ieee_coz);

        sonucu_yaz(32'h00000000, 1, 0, 0, 0, 0);
        sonucu_yaz(32'h80000000, 1, 0, 0, 0, 0);
        sonucu_yaz(32'h41000000, 0, 0, 1, 0, 0);
        sonucu_yaz(32'hbe800000, 0, 0, 1, 0, 0);
        sonucu_yaz(32'h41840000, 0, 0, 1, 0, 0);
        sonucu_yaz(32'h00000010, 0, 1, 0, 0, 0);
        sonucu_yaz(32'h00200000, 0, 1, 0, 0, 0);
        sonucu_yaz(32'h7f800000, 0, 0, 0, 1, 0);
        sonucu_yaz(32'hff800000, 0, 0, 0, 1, 0);
        sonucu_yaz(32'h7fa00000, 0, 0, 0, 0, 1);
        sonucu_yaz(32'hff810000, 0, 0, 0, 0, 1);

        $display("Test bitti");
        $finish;
    end

endmodule
