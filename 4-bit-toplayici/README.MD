# 4-Bit Toplayıcı (Full Adder) Devresi

Bu projede, hazır bir toplama operatörü (`+`) kullanmak yerine doğrudan temel mantık kapılarını (XOR, AND, OR) kullanarak 4 bitlik bir toplayıcı devresi tasarladım. 

Önce 1 bitlik bir tam toplayıcı (full adder) oluşturup, ardından bunlardan 4 tanesini uca uca bağlayarak ana devreyi kurdum.

## 📂 Dosyalar
* **`design.sv`**: Devrenin asıl tasarım kodları.
* **`testbench.sv`**: Devrenin doğru çalışıp çalışmadığını farklı sayılar vererek denediğim test kodları.

## 🚀 Canlı Test Et
Kodları bilgisayarına indirmekle uğraşmadan, doğrudan tarayıcı üzerinden çalıştırıp inceleyebilirsin:
👉 **[EDA Playground Simülasyon Linkim](https://edaplayground.com/x/i2rZ)**

*(Not: Simülasyonu çalıştırdıktan sonra alt kısımdaki Log ekranında sonuçları doğrudan onluk tabanda görebilirsin.)*

## 📊 Test Sonuçları (Waveform)
Aşağıdaki görselde devrenin test sonuçları var. Okuması kolay olsun diye dalga formundaki sayıları onluk (decimal) tabana çevirdim:

![Simülasyon Sonucu](ekran-goruntusu.png)
