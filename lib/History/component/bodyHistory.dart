import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movmov/History/component/cardHistory.dart';
import 'package:movmov/constants.dart';

class BodyHistory extends StatefulWidget{
  final List listHistory;

  const BodyHistory({Key key, this.listHistory}) : super(key: key);

  @override
  _BodyHistory createState() => _BodyHistory();
}

class _BodyHistory extends State<BodyHistory>{
  List listMov = [];
  String episode_id = "";

  @override
  void initState() {
    super.initState();
    getMov();
  }

  Future<void> getMov() async{
    String getMovIDList = "";
    for(int i = 0; i < widget.listHistory.length; i++){
      getMovIDList += getMovIDList == ""? "${widget.listHistory[i]['mov_id']}": "," + "${widget.listHistory[i]['mov_id']}";
    }
    print("getMovIDList " + getMovIDList);

    String query = "SELECT e.episode_id, e.episode, m.mov_title, m.mov_id, m.mov_cover_id FROM movie m, episode e WHERE m.mov_id=e.mov_id AND m.mov_id IN("+getMovIDList+") limit 10";
    print("query " + query);
    final response = await http.get(Uri.parse(webserviceGetData + query));

    setState(() {
      episode_id = getMovIDList;
      listMov = json.decode(response.body);
      print("object " + "setstate ULANG");
    });

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          _CardHistory(context, size),
        ],
      ),
    );
  }

  Widget _CardHistory(BuildContext context, Size size){
    print("object" + "Terima Ulang");
    if(listMov.isNotEmpty){
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        itemCount: listMov.length,
        itemBuilder: (BuildContext context, int index){
          return CardHistory(
            coverLink: "https://awanapp.000webhostapp.com/cover/${listMov[index]['mov_cover_id']}",
            MovTitle: "${listMov[index]['mov_title']}",
            episode: "${listMov[index]['episode']}",
            MovID: "${listMov[index]['mov_id']}",
            size: size,
          );
        },
      );
    }else{
      return Text("KOSONG");
    }
  }

}