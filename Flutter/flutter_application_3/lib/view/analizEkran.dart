import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_3/model/analizKategori.dart';

import '../model/analizModel.dart';

var icons = {
  "Teknoloji": Icons.monitor,
  "Gıda": Icons.dining,
  "Temizlik": Icons.cleaning_services,
  "Kozmetik": Icons.auto_fix_high_sharp,
  "Aksesuar": Icons.auto_awesome,
  "Giyim": Icons.dry_cleaning_outlined,
  "Mobilya": Icons.chair,
  "Diğer": Icons.circle,
  "Eğitim": Icons.book_outlined
};
var colors = {
  "Teknoloji": Colors.blue.shade300,
  "Gıda": Colors.orange.shade300,
  "Temizlik": Colors.green.shade300,
  "Kozmetik": Colors.purple.shade300,
  "Aksesuar": Colors.pink.shade300,
  "Giyim": Colors.red.shade300,
  "Mobilya": Colors.brown.shade300,
  "Diğer": Colors.teal.shade300,
  "Eğitim": Colors.grey.shade500
};

class AnalizEkran extends StatefulWidget {
  const AnalizEkran({super.key});

  @override
  State<AnalizEkran> createState() => _AnalizEkranState();
}

class _AnalizEkranState extends State<AnalizEkran> {
  Future<List<Analiz>> _getEnCokHarcama() async {
    try {
      var response = await Dio()
          .get("http://localhost/");
      print(response.statusCode);
      print("1");
      List<Analiz> _AnalizListesi = [];
      if (response.statusCode == 200) {
        _AnalizListesi =
            (response.data as List).map((e) => Analiz.fromMap(e)).toList();
        print("asd");
        print(_AnalizListesi);
      }
      return _AnalizListesi;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<Analiz>> _getEnCokSatinAlinan() async {
    try {
      var response = await Dio()
          .get("https://www.gonderiyoo.com/api/getUrunAnaliz.php?type=1");
      print(response.statusCode);
      print("1");
      List<Analiz> _AnalizListesi = [];
      if (response.statusCode == 200) {
        _AnalizListesi =
            (response.data as List).map((e) => Analiz.fromMap(e)).toList();
        print("asd");
        print(_AnalizListesi);
      }
      return _AnalizListesi;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<AnalizKategori>> _getEnCokKategori() async {
    try {
      var response = await Dio()
          .get("https://www.gonderiyoo.com/api/getUrunAnaliz.php?type=2");
      print(response.statusCode);
      print("1");
      List<AnalizKategori> _AnalizListesi = [];
      if (response.statusCode == 200) {
        _AnalizListesi = (response.data as List)
            .map((e) => AnalizKategori.fromMap(e))
            .toList();
        print("asd");
        print(_AnalizListesi);
      }
      return _AnalizListesi;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  late Future<List<Analiz>> _analizEnCokHarcama;
  late Future<List<Analiz>> _analizEnCokSatinAlinan;
  late Future<List<AnalizKategori>> _analizEnCokKategori;
  @override
  void initState() {
    // TODO: implement initState
    _analizEnCokHarcama = _getEnCokHarcama();
    _analizEnCokSatinAlinan = _getEnCokSatinAlinan();
    _analizEnCokKategori = _getEnCokKategori();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Analiz"),
      // ),
      body: Container(
        child: Column(
          children: [
            Card(
              elevation: 10,
              shadowColor: Colors.black,
              color: Colors.indigo,
              child: ListTile(
                title: Text("En Çok Harcama Yapılan Ürünler",style: TextStyle(color: Colors.white),textAlign: TextAlign.center),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Analiz>>(
                future: _analizEnCokHarcama,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var alisverisList = snapshot.data!;
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        var alisveris = alisverisList[index];
                        // alisveris.email
                        return Card(
                          elevation: 10,
                          shadowColor: Colors.black,
                          color: colors[alisveris.kategoriId],
                          child: ListTile(
                            iconColor: Colors.white,
                            leading: Icon(icons["${alisveris.kategoriId}"]),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  alisveris.alinanUrun,
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "Tutar: ${alisveris.toplamHarcama}₺",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  "${alisveris.toplamAdet} adet",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: alisverisList.length,
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return Center(child: const CircularProgressIndicator());
                  }
                },
              ),
            ),
            Card(
              elevation: 10,
              shadowColor: Colors.black,
              color: Colors.indigo,
              child: ListTile(
                title: Text("En Çok Satın Alınan Ürünler",style: TextStyle(color: Colors.white),textAlign: TextAlign.center),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Analiz>>(
                future: _analizEnCokSatinAlinan,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var alisverisList = snapshot.data!;
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        var alisveris = alisverisList[index];
                        // alisveris.email
                        return Card(
                          elevation: 10,
                          shadowColor: Colors.black,
                          color: colors[alisveris.kategoriId],
                          child: ListTile(
                            iconColor: Colors.white,
                            leading: Icon(icons["${alisveris.kategoriId}"]),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  alisveris.alinanUrun,
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "Toplam Harcama: ${alisveris.toplamHarcama}₺",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${alisveris.toplamAdet} adet",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "Tane Fiyat: ${alisveris.taneFiyat}₺",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: alisverisList.length,
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return Center(child: const CircularProgressIndicator());
                  }
                },
              ),
            ),
            Card(
              elevation: 10,
              shadowColor: Colors.black,
              color: Colors.indigo,
              child: ListTile(
                title: Text("En Çok Harcama Yapılan Kategori",style: TextStyle(color: Colors.white),textAlign: TextAlign.center),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<AnalizKategori>>(
                future: _analizEnCokKategori,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var alisverisList = snapshot.data!;
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        var alisveris = alisverisList[index];
                        // alisveris.email
                        return Card(
                          elevation: 10,
                          shadowColor: Colors.black,
                          color: colors[alisveris.kategoriId],
                          child: ListTile(
                            iconColor: Colors.white,
                            leading: Icon(icons["${alisveris.kategoriId}"]),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  alisveris.kategoriId,
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "Toplam Harcama: ${alisveris.toplamHarcama}₺",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              "${alisveris.toplamAdet} ürün",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                      itemCount: alisverisList.length,
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return Center(child: const CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
