# 8 bit genişliğinde 4'ten 1'e mux

SystemVerilog ile yazılmış kombinasyonel bir çoğullayıcı. Dört adet 8 bitlik kaynaktan birini, 2 bitlik `secim` sinyaline göre `cikis` hattına bağlar. Saat yoktur; çıkış yalnız o andaki girişlere bağlıdır.

## Seçim

| secim | cikis |
| --- | --- |
| 00 | kaynak0 |
| 01 | kaynak1 |
| 10 | kaynak2 |
| 11 | kaynak3 |

`secim` bu dört değerden biri değilse (`x` veya `z`) `cikis` sıfırlanır. Böylece çıkış boş kalmaz ve devre eski değeri tutmaz.

## Dosyalar

- `design.sv`: `dortten_bire_mux` modülü
- `testbench.sv`: devreyi deneyen sınama kodu

## Test

Icarus Verilog 12.0, derleme seçeneği `-g2012`.

İlk turda her kaynakta tek bir bit 1'dir. Logda yanan bit, seçilen kaynağı gösterir:

- `secim=00` → `00000001`
- `secim=01` → `00010000`
- `secim=10` → `01000000`
- `secim=11` → `10000000`

İkinci tur sınır değerleridir: `00000000`, `11111111`, `00001111`, `11110000`.

Sekiz kontrol de `OK` verdi. Süre 8 × 10 ns = 80 ns.

EDA Playground: https://www.edaplayground.com/x/Pe2i

