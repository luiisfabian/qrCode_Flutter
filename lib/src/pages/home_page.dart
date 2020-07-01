import 'package:flutter/material.dart';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:qr_code/src/pages/direcciones_page.dart';
import 'package:qr_code/src/pages/mapas_page.dart';
import 'package:qr_code/src/providers/db_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Qr Scanner"),
        actions: [
          IconButton(icon: Icon(Icons.delete_forever), onPressed: () {})
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _bottonNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: scanQR,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  // https://fernando-herrera.com/#/home
  // geo:6.244143848577258,-75.52892103632816

  scanQR() async {
    String futureString = 'https://kuvanty.com/#/login';

    // try {
    //   futureString = await BarcodeScanner.scan();
    // } catch (e) {
    //   futureString = e.toString();
    // }

    
    if (futureString != null) {
      final scans = ScanModel(valor: futureString);
      DBProvider.db.nuevoScan(scans);
    }

    // print('Future String: ${futureString.rawContent}');
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return MapasPage();
        break;
      case 1:
        return DireccionesPage();
        break;
      default:
        return MapasPage();
    }
  }

  Widget _bottonNavigationBar() {
    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.map), title: Text("Mapas")),
          BottomNavigationBarItem(
              icon: Icon(Icons.streetview), title: Text("Direcciones"))
        ]);
  }
}
