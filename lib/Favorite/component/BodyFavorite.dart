import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movmov/Favorite/component/cardFavorite.dart';
import 'package:http/http.dart' as http;
import 'package:movmov/constants.dart';
import 'package:movmov/fungsi_kirim_web_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BodyFavorite extends StatefulWidget{

  final List listFav;

  const BodyFavorite({Key key, this.listFav}) : super(key: key);

  @override
  _BodyFavorite createState() => _BodyFavorite();

}

class _BodyFavorite extends State<BodyFavorite>{

  List listMov = [];
  String movID = "";
  int jumlahData = 5;

  RefreshController _refreshController = RefreshController(
    initialRefresh: false
  );

  void _onRefresh() async{
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {

    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    await Future.delayed(Duration(milliseconds: 1000));
    if(mounted)
    setState(() {

    });
    if(jumlahData < listMov.length){
      jumlahData ++;
      _refreshController.loadComplete();
    }else{
      _refreshController.loadNoData();
    }
  }

  @override
  void initState() {
    super.initState();
    getMov();
  }

  Future<void> getMov() async {
    String getMovIDLIST = "";
    for(int i = 0; i < widget.listFav.length; i++){
      getMovIDLIST += getMovIDLIST == ""? "${widget.listFav[i]['mov_id']}": "," + "${widget.listFav[i]['mov_id']}";
    }
    print("getMovIDLIST " +getMovIDLIST );

    String query = "SELECT * FROM movie WHERE mov_id IN ("+getMovIDLIST+") limit 10";
    print("query" + query);
    final response = await http.get(Uri.parse(webserviceGetData + query));

    setState(() {
      movID = getMovIDLIST;
      listMov = json.decode(response.body);
      print("object" + "setstate ulang");
    });
  }

  Widget _CardFavorite(BuildContext context, Size size){
    print("object" + "terima ulang");
    if(listMov.isNotEmpty){
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        itemCount: listMov.length,
        itemBuilder: (BuildContext context, int index){
          return CardFavorite(
            size: size,
            coverLink: "https://awanapp.000webhostapp.com/cover/${listMov[index]['mov_cover_id']}",
            MovTitle: "${listMov[index]['mov_title']}",
            year: "${listMov[index]['mov_year']}",
            MovID: "${listMov[index]['mov_id']}",
            rating: "${listMov[index]['rating']}",
          );
        },
        //CardFavorite(
        //         size: size,
        //         coverLink: "https://awanapp.000webhostapp.com/cover/${listMov[0]['mov_cover_id']}",
        //         MovTitle: "${listMov[0]['mov_title']}",
        //         year: "${listMov[0]['mov_year']}",
        //       );
      );
    }else{
      return Center(child: Text(""));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SmartRefresher(
      enablePullUp: true,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      controller: _refreshController,
      header: WaterDropMaterialHeader(backgroundColor: kSecondaryColor,),
      footer: CustomFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        builder: (BuildContext context, LoadStatus mode){
          Widget body;
          if(mode==LoadStatus.idle){
            body = Text("");
          }else if(mode==LoadStatus.loading){
            body = CupertinoActivityIndicator();
          }else if(mode==LoadStatus.failed){
            body = Text("Load Failed!Click retry!");
          }else if(mode == LoadStatus.canLoading){
            body = Text("Release to load more");
          }else{
            body = Text("No more Data");
          }
          return Container(
            height: 55.0,
            child: Center(child: body,),
          );
        },
      ),
      child: SingleChildScrollView(
          child: _CardFavorite(context, size)
      ),
    );
  }

}