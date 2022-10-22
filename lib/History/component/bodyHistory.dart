import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movmov/History/component/cardHistory.dart';
import 'package:movmov/constants.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BodyHistory extends StatefulWidget{
  final List listHistory;

  const BodyHistory({Key key, this.listHistory}) : super(key: key);

  @override
  _BodyHistory createState() => _BodyHistory();
}

class _BodyHistory extends State<BodyHistory>{
  List listMov = [];
  String episode_id = "";
  int jumlahData = 5;

  @override
  void initState() {
    super.initState();
    getMov();
  }

  RefreshController _refreshController = RefreshController(
    initialRefresh: false
  );

  void _onRefresh() async{
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {

    });
    print("Refresh");
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    await Future.delayed(Duration(milliseconds: 1000));
    if(mounted)
    setState(() {

    });
    print("loading");
    if(jumlahData < listMov.length){
      jumlahData ++;
      _refreshController.loadComplete();
    }else{
      _refreshController.loadNoData();
    }

  }

  Future<void> getMov() async{
    // String getMovIDList = "";
    // for(int i = 0; i < widget.listHistory.length; i++){
    //   getMovIDList += getMovIDList == ""? "${widget.listHistory[i]['mov_id']}": "," + "${widget.listHistory[i]['mov_id']}";
    // }
    // print("getMovIDList " + getMovIDList);
    //gethistory
    String query = "SELECT m.*, e.episode, h.tglNonton from episode e, movie m, history h WHERE e.mov_id=m.mov_id AND h.episode_id=e.episode_id AND h.akun_id = '"+Holder.id_akun+"' order by h.tglNonton DESC limit 50";
    print("query " + query);
    final response = await http.get(Uri.parse(webserviceGetData + query));

    setState(() {
      // episode_id = getMovIDList;
      listMov = json.decode(response.body);
      print("object " + "setstate ULANG");
    });

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
        builder: (BuildContext context,LoadStatus mode){
          Widget body ;
          if(mode==LoadStatus.idle){
            body =  Text("");
          }
          else if(mode==LoadStatus.loading){
            body =  CupertinoActivityIndicator();
          }
          else if(mode == LoadStatus.failed){
            body = Text("Load Failed!Click retry!");
          }
          else if(mode == LoadStatus.canLoading){
            body = Text("release to load more");
          }
          else{
            body = Text("No more Data");
          }
          return Container(
            height: 55.0,
            child: Center(child:body),
          );
        },
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _CardHistory(context, size),
          ],
        ),
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
        itemCount: (listMov.length > jumlahData?jumlahData:listMov.length),
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
      return Text("");
    }
  }

}