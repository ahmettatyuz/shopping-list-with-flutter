import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../model/model.dart';

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

class OncekiAlisveris extends StatefulWidget {
  const OncekiAlisveris({super.key});

  @override
  State<OncekiAlisveris> createState() => _OncekiAlisverisState();
}

class _OncekiAlisverisState extends State<OncekiAlisveris> {
  Future<List<Alisveris>> tamamlananlar() async {
    try {
      var response = await Dio()
          .get("https://www.gonderiyoo.com/api/getList.php?filter=1");
      print(response.statusCode);
      print("1");
      List<Alisveris> _tamamlananlar = [];
      if (response.statusCode == 200) {
        _tamamlananlar =
            (response.data as List).map((e) => Alisveris.fromMap(e)).toList();
        print("asd");
        print(_tamamlananlar);
      }
      return _tamamlananlar;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  late Future<List<Alisveris>> _tamamlananlar;
  @override
  var toplamtutar=0;
  Widget build(BuildContext context) {
    _tamamlananlar = tamamlananlar();
    return Scaffold(
      body: Container(
        child: FutureBuilder<List<Alisveris>>(
          future: _tamamlananlar,
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
                      leading: Icon(icons[alisveris.kategori]),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            alisveris.alinanUrun,
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "Tutar: ${alisveris.toplamTutar} ₺",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${alisveris.urunAdet} adet",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "Kategori: ${alisveris.kategori}",
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
    );
  }
}
