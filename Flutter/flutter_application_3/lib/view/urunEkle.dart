import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

const List<String> list = <String>[
  'Teknoloji',
  'Gıda',
  "Eğitim",
  'Temizlik',
  'Kozmetik',
  "Aksesuar",
  "Giyim",
  "Mobilya",
  "Diğer"
];

class UrunEkle extends StatefulWidget {
  const UrunEkle({super.key});
  @override
  State<UrunEkle> createState() => _UurnEkleState();
}

late TextEditingController iUrunAd = TextEditingController();
late TextEditingController iUrunAdet = TextEditingController();
late TextEditingController iUrunFiyat = TextEditingController();
String dropdownValue = list.first;

class _UurnEkleState extends State<UrunEkle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Ürün Ekle"),
      // ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: iUrunAd,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusColor: Colors.deepOrange,
                  iconColor: Colors.deepOrange,
                  labelText: "Ürün adı girin...",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: iUrunAdet,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusColor: Colors.deepOrange,
                  iconColor: Colors.deepOrange,
                  labelText: "Ürün adet girin...",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: iUrunFiyat,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusColor: Colors.deepOrange,
                  iconColor: Colors.deepOrange,
                  labelText: "Ürün fiyatı girin...",
                ),
              ),
            ),
            DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.indigo),
              underline: Container(
                height: 2,
                color: Colors.indigo,
              ),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  dropdownValue = value!;
                });
              },
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  String urunAdi = iUrunAd.text.toString();
                  String urunAdeti = iUrunAdet.text.toString();
                  String urunFiyat = iUrunFiyat.text.toString();
                  print(urunAdi);
                  print(urunAdeti);
                  String url =
                      "http://localhost/";
                  print(url);
                  setState(() {
                    Dio().get(
                      url,
                    );
                  });
                  iUrunAd.clear();
                  iUrunAdet.clear();
                  iUrunFiyat.clear();
                },
                child: Text(
                  "Ekle",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
