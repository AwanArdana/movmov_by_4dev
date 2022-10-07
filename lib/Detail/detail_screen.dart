

import 'package:flutter/material.dart';
import 'package:movmov/Detail/component/bodydetail.dart';
import 'package:movmov/fungsi_kirim_web_service.dart';

class DetailScreen extends StatelessWidget{
  DetailScreen({Key key, this.Mov_id,}) : super(key: key);

  final String Mov_id;

  // Future<List> getData() async{
  //   // final response = await http.get(Uri.parse("https://awanapp.000webhostapp.com/getmovepisode.php?id="+Mov_id));
  //   final response = await http.get(Uri.parse("https://awanapp.000webhostapp.com/getmovdetail.php?id=" + Mov_id));
  //   return json.decode(response.body);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: new FutureBuilder<List>(
        // future: getData(),
        // future: getDataGlobal("getmovdetail.php?id=", Mov_id),
        future: SQLEksek("SELECT * from movie WHERE mov_id=" + Mov_id),
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new BodyDetail(list: snapshot.data, Mov_id: Mov_id,)
              : new Center(child: new CircularProgressIndicator(),);
        },
      )
      // BodyDetail(Mov_id: Mov_id,),
    );
  }
}