import 'dart:io';

import 'package:flutter/material.dart';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:qr_code/src/bloc/scans_bloc.dart';
import 'package:qr_code/src/models/scan_model.dart';
import 'package:qr_code/src/pages/direcciones_page.dart';
import 'package:qr_code/src/pages/mapas_page.dart';
import 'package:qr_code/src/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scansbloc = new ScansBloc();

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Qr Scanner"),
        actions: [
          IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: () {
                scansbloc.borrarScansTodos();
              })
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _bottonNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: ()=> scanQR(context),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  // https://fernando-herrera.com/#/home
  // geo:6.244143848577258,-75.52892103632816

  scanQR(BuildContext context) async {
    String futureString = 'https://kuvanty.com/#/login';

    // try {
    //   futureString = await BarcodeScanner.scan();
    // } catch (e) {
    //   futureString = e.toString();
    // }

    if (futureString != null) {
      final scans =
          ScanModel(valor: futureString); // DBProvider.db.nuevoScan(scans);
      scansbloc.agregarScan(scans);

      final scans2 = ScanModel(
          valor:
              "geo:6.244143848577258,-75.52892103632816"); // DBProvider.db.nuevoScan(scans);
      scansbloc.agregarScan(scans2);

      if (Platform.isIOS) {
        Future.delayed(Duration(milliseconds: 750), () {
          utils.abrirScan(context,scans);
        });
      } else {
        utils.abrirScan(context, scans);
      }
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
