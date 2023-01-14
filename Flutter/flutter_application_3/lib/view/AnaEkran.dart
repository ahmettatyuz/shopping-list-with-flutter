import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/view/analizEkran.dart';
import 'package:flutter_application_3/view/oncekiAlisveris.dart';
import 'package:flutter_application_3/view/urunEkle.dart';

import '../model/model.dart';

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

class AnaEkran extends StatefulWidget {
  const AnaEkran({super.key});

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  Future<List<Alisveris>> _getAlisverisList() async {
    try {
      var response = await Dio()
          .get("http://localhost/");
      List<Alisveris> _alisverisListesi = [];
      if (response.statusCode == 200) {
        _alisverisListesi =
            (response.data as List).map((e) => Alisveris.fromMap(e)).toList();
      }
      return _alisverisListesi;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  late Future<List<Alisveris>> _alisverisListesi;
  @override
  void initState() {
    // TODO: implement initState
  }

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
  dynamic _currentIndex = 0;
  Widget build(BuildContext context) {
    void yenile() {
      print("yenile calisti.");
      setState(() {});
    }

    _alisverisListesi = _getAlisverisList();
    return Container(
      child: FutureBuilder<List<Alisveris>>(
        future: _alisverisListesi,
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
                  color: colors[alisveris.kategori],
                  child: ListTile(
                    iconColor: Colors.white,
                    leading: Icon(icons["${alisveris.kategori}"]),
                    title: Text(
                      alisveris.alinanUrun,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${alisveris.urunAdet} adet ",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Kategori : ${alisveris.kategori}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      color: Colors.white,
                      onPressed: () async {
                        var response = await Dio().get(
                            "https://www.gonderiyoo.com/api/setAlindi.php?urun_id=${alisveris.id}");
                        setState(() {});
                      },
                      icon: Icon(Icons.check),
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
    );
  }
}
