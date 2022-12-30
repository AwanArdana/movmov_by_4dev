import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movmov/Detail/component/bodydetail.dart';
import 'package:movmov/constants.dart';
import 'package:movmov/fungsi_kirim_web_service.dart';
import 'package:http/http.dart' as http;

class DetailScreen extends StatefulWidget{
  DetailScreen({Key key, this.Mov_id, this.listMov, this.index,}) : super(key: key);

  final List listMov;
  final String Mov_id;
  final int index;

  @override
  _DetailScreen createState() => _DetailScreen();
}

class _DetailScreen extends State<DetailScreen>{
  Color _iconColor = Colors.white;
  bool fav = false;
  String fav_id = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CekFav();
  }

  void SaveFav(int proses){
    // 1 save , 2 delete
    try{
      String idAkun = Holder.id_akun;
      String fav_id = widget.Mov_id + "/" + idAkun;
      if(proses == 1){
        String qInsertFav = "INSERT INTO fav_perakun (fav_id, id_akun, mov_id) VALUES ('"+fav_id+"', '"+idAkun+"', '"+widget.Mov_id+"')";
        print(qInsertFav);
        SQLEksekInsert(qInsertFav);
        Fluttertoast.showToast(msg: "Favorite Saved");
      }else{
        if(fav_id != ""){
          String qInsertFav = "DELETE FROM fav_perakun WHERE fav_id = '"+fav_id+"'";
          print(qInsertFav);
          SQLEksekInsert(qInsertFav);
          Fluttertoast.showToast(msg: "Favorite Deleted");
        }else{
          Fluttertoast.showToast(msg: "Favorite Deleted ERROR");
        }

      }

    }on Exception catch(e){
      print("" + e.toString());
    }
  }

  Future<void> CekFav() async {
    String qCekFav = "SELECT * FROM fav_perakun WHERE id_akun = '"+Holder.id_akun+"' AND mov_id = '"+widget.Mov_id+"'";
    print(qCekFav);
    final response = await http.get(Uri.parse(webserviceGetData + qCekFav));
    List list = json.decode(response.body);
    if(list.isNotEmpty){
      setState(() {
        fav_id = list[0]["fav_id"];
        fav = true;
        _iconColor = Colors.red;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            IconButton(
              constraints: BoxConstraints.expand(width: 80),
              icon: Icon(Icons.favorite, color: _iconColor,),
              onPressed: () {
                setState(() {
                  if(fav){
                    _iconColor = Colors.white;
                    fav = false;
                    SaveFav(2);
                  }else{
                    _iconColor = Colors.red;
                    fav = true;
                    SaveFav(1);
                  }
                  // _iconColor = Colors.red;
                  // fav = true;
                });
              },
            ),
          ],
        ),
        body: new BodyDetail(listMov: widget.listMov, Mov_id: widget.Mov_id, index: widget.index,),
        // body: new FutureBuilder<List>(
        //   // future: getData(),
        //   // future: getDataGlobal("getmovdetail.php?id=", Mov_id),
        //   future: SQLEksek("SELECT * from movie WHERE mov_id=" + widget.Mov_id),
        //   builder: (context, snapshot){
        //     if(snapshot.hasError) print(snapshot.error);
        //
        //     return snapshot.hasData
        //         ? new BodyDetail(list: snapshot.data, Mov_id: widget.Mov_id,)
        //         : new Center(child: new CircularProgressIndicator(),);
        //   },
        // )
      // BodyDetail(Mov_id: Mov_id,),
    );
  }

}