import 'package:bilgiyarismasi2023/sorular.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'hakkinda.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        //'/': (context)=>MyHomePage(title: "Anasayfa"),
        '/hakkinda': (context) => Hakkinda(),
      },
      home: const MyHomePage(title: 'Anasayfa'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String adSoyad = '';
  String ogrNo = '';

  void kontrol() {
    if ((adSoyad.length > 9) && (ogrNo.length == 9)) {
      var data = [];
      data.add(adSoyad);
      data.add(ogrNo);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Sorular(), settings: RouteSettings(arguments: data)));
      //Navigator.pushNamed(context, '/sorular');
    } else {
      Navigator.pushNamed(context, '/hata');
    }
  }

  void _adSoyadKaydet(String text) {
    setState(() {
      adSoyad = text;
    });
  }

  void _ogrNoKaydet(String text) {
    setState(() {
      ogrNo = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool butonpasif = true;

    if ((adSoyad.length > 9) && (ogrNo.length == 9)) {
      butonpasif = false;
    } else {
      butonpasif = true;
    }

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Adınız Soyadınız',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (text) {
                  _adSoyadKaydet(text);
                },
                decoration:
                    InputDecoration(hintText: 'Adınızı ve Soyadınızı Giriniz'),
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.singleLineFormatter
                ],
              ),
            ),
            Text(
              'Öğrenci Numaranız',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (text) {
                  _ogrNoKaydet(text);
                },
                decoration:
                    InputDecoration(hintText: 'Öğrenci Numaranızı Giriniz'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: butonpasif ? null : kontrol,
                  child: Text('Sınava Başla')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Hakkinda()));
                  },
                  child: Text('Hakkında')),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
