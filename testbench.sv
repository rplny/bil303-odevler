module toplayici;

    reg [3:0] sayi1;
    reg [3:0] sayi2;
    reg elde_giris;

    wire [3:0] toplam;
    wire elde_cikis;

    toplayici_4bit uut (
        .sayi1(sayi1),
        .sayi2(sayi2),
        .elde_giris(elde_giris),
        .toplam(toplam),
        .elde_cikis(elde_cikis)
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, toplayici);

        $monitor("Zaman: %0t ns | Sayi1: %d, Sayi2: %d, EldeGiris: %d ---> Toplam: %d, EldeCikis: %d", 
                 $time, sayi1, sayi2, elde_giris, toplam, elde_cikis);

        sayi1 = 4'd11; 
        sayi2 = 4'd4; 
        elde_giris = 0;
        #15;

        sayi1 = 4'd12; 
        sayi2 = 4'd5; 
        elde_giris = 0;
        #15;

        sayi1 = 4'd2; 
        sayi2 = 4'd13; 
        elde_giris = 0;
        #15;
        
        sayi1 = 4'd7; 
        sayi2 = 4'd8; 
        elde_giris = 1; 
        #15;

        $finish;
    end

endmodule
