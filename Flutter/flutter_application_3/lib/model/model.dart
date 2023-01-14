// To parse this JSON data, do
//
//     final alisveris = alisverisFromMap(jsonString);
import 'dart:convert';

Alisveris alisverisFromMap(String str) => Alisveris.fromMap(json.decode(str));

String alisverisToMap(Alisveris data) => json.encode(data.toMap());

class Alisveris {
    Alisveris({
        required this.id,
        required this.alinanUrun,
        required this.urunAdet,
        required this.kategori,
        required this.taneFiyat,
        required this.toplamTutar,
        required this.date,
    });

    final String id;
    final String alinanUrun;
    final String urunAdet;
    final String kategori;
    final String taneFiyat;
    final String toplamTutar;
    final DateTime date;

    factory Alisveris.fromMap(Map<String, dynamic> json) => Alisveris(
        id: json["ID"],
        alinanUrun: json["ALINAN_URUN"],
        urunAdet: json["URUN_ADET"],
        kategori: json["KATEGORI_ID"],
        taneFiyat: json["TANE_FIYAT"],
        toplamTutar: json["TOPLAM_TUTAR"],
        date: DateTime.parse(json["DATE"]),
    );

    Map<String, dynamic> toMap() => {
        "ID": id,
        "ALINAN_URUN": alinanUrun,
        "URUN_ADET": urunAdet,
        "KATEGORI_ID": kategori,
        "TANE_FIYAT": taneFiyat,
        "TOPLAM_TUTAR": toplamTutar,
        "DATE": date.toIso8601String(),
    };
}
