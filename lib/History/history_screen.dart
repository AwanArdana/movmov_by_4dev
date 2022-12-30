import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movmov/Favorite/component/BodyFavorite.dart';
import 'package:movmov/History/component/bodyHistory.dart';
import 'package:movmov/constants.dart';
import 'package:movmov/fungsi_kirim_web_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;

class HistoryScreen extends StatefulWidget{
  @override
  _HistoryScreen createState() => _HistoryScreen();
}

class _HistoryScreen extends State<HistoryScreen>{

  static List listMov = [];
  bool datakosong = false;
  int jumlahData = 5;
  bool refresh = false;

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      listMov = [];
      getData();
    });
    _refreshController.refreshCompleted();
    _refreshController.loadComplete();
  }

  void _onLoading() async{
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {

    });
    if(jumlahData < listMov.length){
      jumlahData++;
      _refreshController.loadComplete();
    }else{
      _refreshController.loadNoData();
    }
  }

  @override
  void initState() {
    super.initState();
    if(listMov.isNotEmpty){

    }else{
      getData();
    }
  }

  Future<void> getData() async{

    String query = "SELECT m.*, e.episode, GROUP_CONCAT(g.gen_title) as all_genres from movie m NATURAL JOIN episode e NATURAL JOIN history h NATURAL JOIN movie_genres mg NATURAL JOIN genres g WHERE h.akun_id = '" + Holder.id_akun + "' GROUP BY h.history_id ORDER BY h.tglNonton DESC";
        // "from movie m"
        // "NATURAL JOIN episode e"
        // "NATURAL JOIN history h"
        // "NATURAL JOIN movie_genres mg"
        // "NATURAL JOIN genres g"
        // "WHERE h.akun_id = '" + Holder.id_akun + "'"
        // "GROUP BY h.history_id"
        // "ORDER BY h.tglNonton DESC";

    final response = await http.get(Uri.parse(webserviceGetData + query));

    setState(() {
      listMov = jsonDecode(response.body);
      if(listMov.isNotEmpty){
        datakosong = false;
      }else{
        datakosong = true;
      }
    });

    // String query = "SELECT * FROM history WHERE akun_id = '" + Holder.id_akun +"'";
    // final response = await http.get(Uri.parse(webserviceGetData + query));
    //
    // List listhistory = jsonDecode(response.body);
    //
    // if(listhistory.isNotEmpty){
    //   String getMovIDLIST = "";
    //   for(int i = 0; i < listhistory.length; i++){
    //     getMovIDLIST += getMovIDLIST == ""
    //         ? listhistory[i]['mov_id']
    //         : "," + listhistory[i]['mov_id'];
    //   }
    //
    //   // query = "SELECT * FROM movie WHERE mov_id IN ("+ getMovIDLIST+") limit 10";
    //   query = "SELECT m.*, e.episode, h.tglNonton from episode e, movie m, history h WHERE e.mov_id=m.mov_id AND h.episode_id=e.episode_id AND h.akun_id = '"+Holder.id_akun+"' order by h.tglNonton DESC limit 50";
    //   //SELECT m.*, e.episode, h.tglNonton from episode e, movie m, history h WHERE e.mov_id=m.mov_id AND h.episode_id=e.episode_id AND h.akun_id = '"+Holder.id_akun+"' order by h.tglNonton DESC limit 50
    //
    //
    //   final response2 = await http.get(Uri.parse(webserviceGetData + query));
    //
    //   setState(() {
    //     listMov = json.decode(response2.body);
    //     int z = 0;
    //     int k = 0;
    //
    //     if(Holder.listGenres.isNotEmpty){
    //       for(int i = 0; i < listMov.length; i++){
    //         for(int j = 0; j < Holder.listGenres.length; j++){
    //
    //           if(listMov[i]['mov_id'] == Holder.listGenres[j]['mov_id']){
    //             if(k == 0){
    //               listMov[i]['genre1'] = Holder.listGenres[j]['gen_title'];
    //               k++;
    //             }else if(k == 1){
    //               listMov[i]['genre2'] = Holder.listGenres[j]['gen_title'];
    //               k++;
    //             }else{
    //               listMov[i]['genre3'] = Holder.listGenres[j]['gen_title'];
    //               k++;
    //             }
    //           }
    //
    //           if(k == 3){
    //             k = 0;
    //             break;
    //           }
    //           z++;
    //         }
    //       }
    //     }else{
    //       for(int i = 0; i < listMov.length; i++){
    //         listMov[i]['genre1'] = "";
    //         listMov[i]['genre2'] = "";
    //         listMov[i]['genre3'] = "";
    //       }
    //
    //     }
    //
    //     print("adadata" + z.toString());
    //
    //   });
    // }else{
    //   setState(() {
    //     datakosong = true;
    //   });
    // }

  }

  @override
  Widget build(BuildContext context) {

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
        child: _BodyHistory(context),
      ),
    );
    // return Center(
    //   child: FutureBuilder<List>(
    //     future: SQLEksek("SELECT * FROM history WHERE akun_id = '"+Holder.id_akun+"'"),
    //     builder: (context, snapshot){
    //       if(snapshot.hasError) print(snapshot.error);
    //
    //       return snapshot.hasData
    //           ? new BodyHistory(listHistory: snapshot.data,)
    //           : new Center(child: new CircularProgressIndicator(),);
    //     },
    //   ),
    // );
  }

  Widget _BodyHistory(BuildContext context){
    if(datakosong){
      return Center(child: Text("No Data"),);
    }

    if(listMov.isNotEmpty){
      // return BodyHistory(list)
      return BodyHistory(listMov: listMov,);
    }else{
      return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Center(child: new CircularProgressIndicator(),)
      );
    }
  }
  
}