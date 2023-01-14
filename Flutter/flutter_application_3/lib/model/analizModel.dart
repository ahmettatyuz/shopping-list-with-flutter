// To parse this JSON data, do
//
//     final analiz = analizFromMap(jsonString);

import 'dart:convert';

Analiz analizFromMap(String str) => Analiz.fromMap(json.decode(str));

String analizToMap(Analiz data) => json.encode(data.toMap());

class Analiz {
    Analiz({
        required this.alinanUrun,
        required this.toplamAdet,
        required this.kategoriId,
        required this.toplamHarcama,
        required this.taneFiyat,
    });

    final String alinanUrun;
    final String toplamAdet;
    final String kategoriId;
    final String toplamHarcama;
    final String taneFiyat;

    factory Analiz.fromMap(Map<String, dynamic> json) => Analiz(
        alinanUrun: json["ALINAN_URUN"],
        toplamAdet: json["TOPLAM_ADET"],
        kategoriId: json["KATEGORI_ID"],
        toplamHarcama: json["TOPLAM_HARCAMA"],
        taneFiyat: json["TANE_FIYAT"],
    );

    Map<String, dynamic> toMap() => {
        "ALINAN_URUN": alinanUrun,
        "TOPLAM_ADET": toplamAdet,
        "KATEGORI_ID": kategoriId,
        "TOPLAM_HARCAMA": toplamHarcama,
        "TANE_FIYAT": taneFiyat,
    };
}
