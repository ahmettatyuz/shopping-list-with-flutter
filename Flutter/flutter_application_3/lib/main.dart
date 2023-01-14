import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/model/model.dart';
import 'package:flutter_application_3/view/AnaEkran.dart';
import 'package:flutter_application_3/view/analizEkran.dart';
import 'package:flutter_application_3/view/oncekiAlisveris.dart';
import 'package:flutter_application_3/view/urunEkle.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();  
}

class _MyAppState extends State<MyApp> {
  // Future<List<Alisveris>> _getAlisverisList() async {
  void yenile() {
    print("yenile calisti.");
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final screens = [
    AnaEkran(),
    UrunEkle(),
    OncekiAlisveris(),
    AnalizEkran()
  ];
  dynamic _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Alışveriş Listesi",
      // home: AnaEkran(),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Alışveriş Listesi"),
        ),
        body: screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: Colors.indigo,
          items: [
            
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: "Listem",
                backgroundColor: Colors.indigo),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_shopping_cart),
                label: "Urun Ekle",
                backgroundColor: Colors.orange),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopify_sharp),
                label: "Önceki Alışverişler",
                backgroundColor: Colors.red),
            BottomNavigationBarItem(
                icon: Icon(Icons.analytics),
                label: "Analiz",
                backgroundColor: Colors.green),
          ],
          onTap: (index) {
            setState(() {_currentIndex = index;});
          },
        ),
      ),
      theme: ThemeData(primarySwatch: Colors.indigo),
    );
  }
}
