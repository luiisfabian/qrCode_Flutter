import 'package:flutter/material.dart';
import 'package:qr_code/src/models/scan_model.dart';

import 'package:flutter_map/flutter_map.dart';

class MapaPage extends StatefulWidget {
  MapaPage({Key key}) : super(key: key);

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  final map = new MapController();
  String tipoMapa  = 'streets';
  @override
  Widget build(BuildContext context) {
    final ScanModel scans = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text("cordenadas QR"),
          actions: [
            IconButton(icon: Icon(Icons.my_location),
             onPressed: () {
               map.move(scans.getLatLng(), 50);
             }
             )
          ],
        ),
        body: _crearFlutterMap(scans),
        floatingActionButton: _crearBotonFlotante(context),
        );
        
  }
  Widget _crearBotonFlotante(context){
    return FloatingActionButton(
      onPressed: (){
           //streets, dark, ligth, autdoors, satellite, 

        if (tipoMapa == "streets") {
          tipoMapa = "dark";
        } else if(tipoMapa == "dark"){
          tipoMapa = "ligth";
        }else if(tipoMapa == "autdoors"){
          tipoMapa = "satellite";          
        }else{
          tipoMapa = "streets";
        }

        setState(() {
          
        });

      },
      backgroundColor: Theme.of(context).primaryColor,
      child: Icon(Icons.repeat),


      );
  }

  Widget _crearFlutterMap(ScanModel scans) {
    return FlutterMap(
      mapController: map,
      options: MapOptions(center: scans.getLatLng(), zoom: 50.0),
      layers: [
        _crearMapa(),
        _marcadores(scans),
      ],
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
                    "id": "mapbox.$tipoMapa"
           //streets, dark, ligth, autdoors, satellite, 


        });
  }
  _marcadores(ScanModel scans){
    return MarkerLayerOptions(
      markers: [
        Marker(
          width: 100.0,
          height: 100.0,
          point: scans.getLatLng(),
          builder: (context ) => Container(
              child: Icon(Icons.location_on, size: 45.0, color: Theme.of(context).primaryColor,),
              
            )
         
        ),
      ]
    );
  }


}
