import 'package:flutter/material.dart';

import 'package:qr_code/src/models/scan_model.dart';
import 'package:qr_code/src/providers/db_provider.dart';
import 'package:url_launcher/url_launcher.dart';



abrirScan(BuildContext context, ScanModel scans) async {
  if (scans.tipo == 'http') {
    
  if (await canLaunch(scans.valor)) {
    await launch(scans.valor);
  } else {
    throw 'Could not launch ${scans.valor}';
  }
  }else{
    Navigator.pushNamed(context, "mapa", arguments: scans);
  }

}
