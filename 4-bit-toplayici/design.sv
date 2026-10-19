module tam_toplayici (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));
endmodule

module toplayici_4bit (
    input [3:0] sayi1,
    input [3:0] sayi2,
    input elde_giris,
    output [3:0] toplam,
    output elde_cikis
);

    wire c1, c2, c3;

    tam_toplayici bit0 ( .a(sayi1[0]), .b(sayi2[0]), .cin(elde_giris), .sum(toplam[0]), .cout(c1) );
    tam_toplayici bit1 ( .a(sayi1[1]), .b(sayi2[1]), .cin(c1),         .sum(toplam[1]), .cout(c2) );
    tam_toplayici bit2 ( .a(sayi1[2]), .b(sayi2[2]), .cin(c2),         .sum(toplam[2]), .cout(c3) );
    tam_toplayici bit3 ( .a(sayi1[3]), .b(sayi2[3]), .cin(c3),         .sum(toplam[3]), .cout(elde_cikis) );

endmodule

// EDA Playground Simülasyon Linki:
// https://edaplayground.com/x/i2rZ
