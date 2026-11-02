# 5 bit ALU

## Soru

5 bitlik bir ALU tasarlayın. Girişler `a` ve `b` 5 bit, seçim `secim` 2 bit olsun.
Toplama ve çıkarma işlemlerini `+` / `-` yazmadan, full adder (bit toplayıcı) ile kurun.
Mantık işlemlerinde `*` kullanmayın; çarpım için `&`, toplam için uygun kapı ifadelerini kullanın.

| secim | işlem |
|---|---|
| 00 | toplama (`a + b`) |
| 01 | çıkarma (`a - b`) |
| 10 | XOR (`a ^ b`) |
| 11 | NAND (`~(a & b)`) |

Çıkış 5 bit `cikis` olsun. Toplama ve çıkarmada carry / borç bilgisini `elde` ucundan verin.
Mantık işlemlerinde `elde = 0` olsun.

Testbench ile dört işlemi de deneyin. Simülasyonu EDA Playground üzerinde Icarus Verilog ve `-g2012` ile çalıştırın.
