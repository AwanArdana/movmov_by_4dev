import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movmov/Favorite/component/cardFavorite.dart';
import 'package:http/http.dart' as http;
import 'package:movmov/constants.dart';
import 'package:movmov/fungsi_kirim_web_service.dart';

class BodyFavorite extends StatefulWidget{

  final List listFav;

  const BodyFavorite({Key key, this.listFav}) : super(key: key);

  @override
  _BodyFavorite createState() => _BodyFavorite();

}

class _BodyFavorite extends State<BodyFavorite>{

  List listMov = [];
  String movID = "";

  @override
  void initState() {
    super.initState();
    getMov();
  }

  Future<void> getMov() {
    String getMovIDLIST = "";
    for(int i = 0; i < widget.listFav.length; i++){
      getMovIDLIST += getMovIDLIST == ""? "${widget.listFav[i]['mov_id']}": "," + "${widget.listFav[i]['mov_id']}";
    }
    print("getMovIDLIST " +getMovIDLIST );
    setState(() {
      movID = getMovIDLIST;
    });
    // String query = "SELECT * FROM movie WHERE mov_id IN ("+movID+")";
    // print("query" + query);
    // final response = await http.get(Uri.parse(webserviceGetData + query));
    // listMov = json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [


        // new CardFavorite(
        //   size: size,
        //   listMov: listMov,
        // )
        new FutureBuilder<List>(
          future: SQLEksek("SELECT * FROM movie WHERE mov_id IN ("+movID+")"),
          builder: (context, snapshot){
            if(snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? new CardFavorite(size: size, listMov: snapshot.data,)
                : new Center(child: Text("FAVOOOO"),);
          },
        )
      ],
    );
  }

}