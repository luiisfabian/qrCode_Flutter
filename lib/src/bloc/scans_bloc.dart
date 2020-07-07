import 'dart:async';

import 'package:qr_code/src/models/scan_model.dart';
import 'package:qr_code/src/providers/db_provider.dart';

class ScansBloc {
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }
  ScansBloc._internal() {
    //obtener los scans de la base de datos
    obtenerScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scansController.stream;

  dispose() {
    _scansController?.close();
  }
 
  agregarScan(ScanModel scan) async{
    await DBProvider.db.nuevoScan(scan);
    obtenerScans();
  }
  obtenerScans() async {
    _scansController.sink.add(await DBProvider.db.getTodosLosScan());
  }

  borrarScan(int id) async {
    await DBProvider.db.deleteScan(id);
    obtenerScans();
  }

  borrarScansTodos() async{
    await DBProvider.db.deleteAll();
    obtenerScans();
  }


}
