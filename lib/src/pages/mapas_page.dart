import 'package:flutter/material.dart';
import 'package:qr_code/src/providers/db_provider.dart';


class MapasPage extends StatelessWidget {
  const MapasPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot){
        print(snapshot);
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
          itemBuilder: (BuildContext context, int i ) => ListTile(
            leading: Icon(Icons.cloud_done, color: Theme.of(context).primaryColor,),
            title: Text(scans[i].valor),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
          ),
          itemCount: scans.length,

          );

      },
      future: DBProvider.db.getTodosLosScan(),
    );
  }
}