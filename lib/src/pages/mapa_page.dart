import 'package:flutter/material.dart';
import 'package:qr_code/src/models/scan_model.dart';

import 'package:flutter_map/flutter_map.dart';

class MapaPage extends StatefulWidget {
  MapaPage({Key key}) : super(key: key);

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  @override
  Widget build(BuildContext context) {
    final ScanModel scans = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text("cordenadas QR"),
          actions: [
            IconButton(icon: Icon(Icons.my_location), onPressed: () {})
          ],
        ),
        body: _crearFlutterMap(scans));
  }

  Widget _crearFlutterMap(ScanModel scans) {
    return FlutterMap(
      options: MapOptions(center: scans.getLatLng(), zoom: 12),
      layers: [_crearMapa()],
    );
  }

  _crearMapa() {
    return TileLayerOptions(
        urlTemplate: 'https://api.mapbox.com/styles/v1/'
            'mapbox/streets-v11/tiles/{z}/{x}/{y}@2x?access_token={accessToken}',
        additionalOptions: {
          "accessToken":
              "pk.eyJ1IjoibHVpaXNmYWJpYW4iLCJhIjoiY2tjY2MzZzMzMDM5eDJ5b2J6ZzM0eWs5bCJ9.NVOBwDmC69xn-7LBLBT1eA",
          // "id": "mapbox.streets",
                    "id": "mapbox.satellite"
           //dark, ligth, autdoors, satellite, 


        });
  }
}
