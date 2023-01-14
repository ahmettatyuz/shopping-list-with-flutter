// To parse this JSON data, do
//
//     final analizKategori = analizKategoriFromMap(jsonString);

import 'dart:convert';

AnalizKategori analizKategoriFromMap(String str) => AnalizKategori.fromMap(json.decode(str));

String analizKategoriToMap(AnalizKategori data) => json.encode(data.toMap());

class AnalizKategori {
    AnalizKategori({
        required this.kategoriId,
        required this.toplamAdet,
        required this.toplamHarcama,
    });

    final String kategoriId;
    final String toplamAdet;
    final String toplamHarcama;

    factory AnalizKategori.fromMap(Map<String, dynamic> json) => AnalizKategori(
        kategoriId: json["KATEGORI_ID"],
        toplamAdet: json["TOPLAM_ADET"],
        toplamHarcama: json["TOPLAM_HARCAMA"],
    );

    Map<String, dynamic> toMap() => {
        "KATEGORI_ID": kategoriId,
        "TOPLAM_ADET": toplamAdet,
        "TOPLAM_HARCAMA": toplamHarcama,
    };
}
