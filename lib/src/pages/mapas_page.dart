import 'package:flutter/material.dart';
import 'package:qr_code/src/bloc/scans_bloc.dart';
import 'package:qr_code/src/models/scan_model.dart';
import 'package:qr_code/src/utils/utils.dart' as utils;

class MapasPage extends StatelessWidget {
  final scansbloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    return StreamBuilder(
      stream: scansbloc.scansStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final scans = snapshot.data;

        if (scans.length == 0) {
          return Center(child: Text("NO HAY INFORMACION AUN"));
        }

        return ListView.builder(
          itemBuilder: (BuildContext context, int i) => Dismissible(
            onDismissed: (DismissDirection direction) {
              scansbloc.borrarScan(scans[i].id);
            },
            key: UniqueKey(),
            background: Container(
              color: Colors.redAccent,
            ),
            child: ListTile(
              leading: Icon(
                Icons.cloud_done,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(scans[i].valor),
              subtitle: Text('ID: ' + scans[i].id.toString()),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
              ),
              onTap: (){
                utils.abrirScan(context, scans[i]);
              },
            ),
          ),
          itemCount: scans.length,
        );
      },
    );
  }
}
