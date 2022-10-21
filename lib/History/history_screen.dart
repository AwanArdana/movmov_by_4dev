import 'package:flutter/material.dart';
import 'package:movmov/Favorite/component/BodyFavorite.dart';
import 'package:movmov/History/component/bodyHistory.dart';
import 'package:movmov/constants.dart';
import 'package:movmov/fungsi_kirim_web_service.dart';

class HistoryScreen extends StatefulWidget{
  @override
  _HistoryScreen createState() => _HistoryScreen();
}

class _HistoryScreen extends State<HistoryScreen>{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List>(
        future: SQLEksek("SELECT * FROM history WHERE akun_id = '"+Holder.id_akun+"'"),
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new BodyHistory(listHistory: snapshot.data,)
              : new Center(child: new CircularProgressIndicator(),);
        },
      ),
    );
  }
  
}