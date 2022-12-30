import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movmov/Favorite/component/BodyFavorite.dart';
import 'package:movmov/constants.dart';
import 'package:movmov/fungsi_kirim_web_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;

class FavoriteScreen extends StatefulWidget{
  @override
  _FavoriteScreen createState() => _FavoriteScreen();

}

class _FavoriteScreen extends State<FavoriteScreen>{
  // RefreshController _refreshController = RefreshController(initialRefresh: false);
  //
  // void _onRefresh() async{
  //   await Future.delayed(Duration(milliseconds: 1000));
  //   setState(() {
  //
  //   });
  //   _refreshController.refreshCompleted();
  // }
  //
  // void _onLoading() async{
  //   await Future.delayed(Duration(milliseconds: 1000));
  //   setState(() {
  //
  //   });
  //   _refreshController.loadComplete();
  // }
  static List listMov = [];
  bool datakosong = false;
  int jumlahData = 5;
  bool refresh = false;

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      // listMov = [];
      // if(refresh){
      //   getData();
      // }
      listMov = [];
      getData();
    });
    _refreshController.refreshCompleted();
    _refreshController.loadComplete();
  }

  void _onLoading() async{
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      // listMov = [];
      // getData();
    });
    // _refreshController.loadComplete();
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
    if(listMov.isNotEmpty){

    }else{
      getData();
    }
  }

  Future<void> getData() async{
    // String query = "SELECT * FROM fav_perakun WHERE id_akun = '"+Holder.id_akun+"'";
    // print("query " + query);
    // final response = await http.get(Uri.parse(webserviceGetData + query));
    //
    // List listfav = jsonDecode(response.body);

    // if(listfav.isNotEmpty){
    //   String getMovIDLIST = "";
    //   for(int i = 0; i < listfav.length; i++){
    //     getMovIDLIST += getMovIDLIST == ""
    //         ? listfav[i]['mov_id']
    //         : "," + listfav[i]['mov_id'];
    //   }
    //
    //   print("getMovIDLIST " + getMovIDLIST);
    //
    //   // query = "SELECT * FROM movie WHERE mov_id IN ("+getMovIDLIST+") limit 10";
    //   //select m.mov_id, m.mov_title, GROUP_CONCAT(g.gen_title) as genres1 from movie m NATURAL JOIN movie_genres mg NATURAL JOIN genres g GROUP by m.mov_id
    //
    //
    //   // query = "SELECT gen_title, mg.mov_id FROM genres g, movie_genres mg WHERE g.gen_id=mg.gen_id";
    //   // final response3 = await http.get(Uri.parse(webserviceGetData + query));
    //   // List listgenres = json.decode(response3.body);
    //
    //   setState(() {
    //     listMov = json.decode(response2.body);
    //     // int z = 0;
    //     // int k = 0;
    //     //
    //     // if(Holder.listGenres.isNotEmpty){
    //     //   for(int i = 0; i < listMov.length; i++){
    //     //     for(int j = 0; j < Holder.listGenres.length; j++){
    //     //
    //     //       if(listMov[i]['mov_id'] == Holder.listGenres[j]['mov_id']){
    //     //         if(k == 0){
    //     //           listMov[i]['genre1'] = Holder.listGenres[j]['gen_title'];
    //     //           k++;
    //     //         }else if(k == 1){
    //     //           listMov[i]['genre2'] = Holder.listGenres[j]['gen_title'];
    //     //           k++;
    //     //         }else{
    //     //           listMov[i]['genre3'] = Holder.listGenres[j]['gen_title'];
    //     //           k++;
    //     //         }
    //     //       }
    //     //       if(k == 3){
    //     //         k = 0;
    //     //         break;
    //     //       }
    //     //       z++;
    //     //     }
    //     //   }
    //     // }else{
    //     //   for(int i = 0; i < listMov.length; i++){
    //     //     listMov[i]['genre1'] = "";
    //     //     listMov[i]['genre2'] = "";
    //     //     listMov[i]['genre3'] = "";
    //     //   }
    //     //
    //     // }
    //     //
    //     // print("adadata" + z.toString());
    //   });
    // }else{
    //   setState(() {
    //     datakosong = true;
    //   });
    // }

    String query = "SELECT m.*, GROUP_CONCAT(g.gen_title) as all_genres FROM movie m NATURAL JOIN movie_genres mg NATURAL JOIN genres g NATURAL JOIN fav_perakun f WHERE f.id_akun = '"+Holder.id_akun+"' GROUP by m.mov_id";
    print("query " + query);
    final response2 = await http.get(Uri.parse(webserviceGetData + query));

    setState(() {
      listMov = jsonDecode(response2.body);
      if(listMov.isNotEmpty){
        datakosong = false;
      }else{
        datakosong = true;
      }
    });


  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   // body: BodyFavorite(),
    // );
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
        // child: FutureBuilder<List>(
        //   future: SQLEksek("SELECT * FROM fav_perakun WHERE id_akun = '"+Holder.id_akun+"'"),
        //   builder: (context, snapshot){
        //     if(snapshot.hasError) print(snapshot.error);
        //
        //     return snapshot.hasData
        //         ? new BodyFavorite(listFav: snapshot.data,)
        //         : new Center(child: new CircularProgressIndicator(),);
        //   },
        // ),
        child: _BodyFavorite(context),
      ),
    );
  }

  Widget _BodyFavorite(BuildContext context){
    if(datakosong){
      return Center(child: Text("No Data"));
    }

    if(listMov.isNotEmpty){
      return BodyFavorite(listMov: listMov,);
      // return Text("OKE BANG");
    }else{
      return Container(
        height: MediaQuery.of(context).size.height * 0.7,
          child: Center(child: new CircularProgressIndicator(),)
      );
    }
  }

}

//class BodyFavorite extends StatefulWidget{
//
//   final List listFav;
//
//   const BodyFavorite({Key key, this.listFav}) : super(key: key);
//
//   @override
//   _BodyFavorite createState() => _BodyFavorite();
//
// }
//
// class _BodyFavorite extends State<BodyFavorite>{
//
//   List listMov = [];
//   String movID = "";
//   int jumlahData = 5;
//
//   RefreshController _refreshController = RefreshController(
//     initialRefresh: false
//   );
//
//   void _onRefresh() async{
//     await Future.delayed(Duration(milliseconds: 1000));
//     setState(() {
//
//     });
//     _refreshController.refreshCompleted();
//   }
//
//   void _onLoading() async{
//     await Future.delayed(Duration(milliseconds: 1000));
//     if(mounted)
//     setState(() {
//
//     });
//     if(jumlahData < listMov.length){
//       jumlahData ++;
//       _refreshController.loadComplete();
//     }else{
//       _refreshController.loadNoData();
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getMov();
//   }
//
//   Future<void> getMov() async {
//     String getMovIDLIST = "";
//     for(int i = 0; i < widget.listFav.length; i++){
//       getMovIDLIST += getMovIDLIST == ""? "${widget.listFav[i]['mov_id']}": "," + "${widget.listFav[i]['mov_id']}";
//     }
//     print("getMovIDLIST " +getMovIDLIST );
//
//     String query = "SELECT * FROM movie WHERE mov_id IN ("+getMovIDLIST+") limit 10";
//     print("query" + query);
//     final response = await http.get(Uri.parse(webserviceGetData + query));
//
//     setState(() {
//       movID = getMovIDLIST;
//       listMov = json.decode(response.body);
//       print("object" + "setstate ulang");
//     });
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return SmartRefresher(
//       enablePullUp: true,
//       onRefresh: _onRefresh,
//       onLoading: _onLoading,
//       controller: _refreshController,
//       header: WaterDropMaterialHeader(backgroundColor: kSecondaryColor,),
//       footer: CustomFooter(
//         loadStyle: LoadStyle.ShowWhenLoading,
//         builder: (BuildContext context, LoadStatus mode){
//           Widget body;
//           if(mode==LoadStatus.idle){
//             body = Text("");
//           }else if(mode==LoadStatus.loading){
//             body = CupertinoActivityIndicator();
//           }else if(mode==LoadStatus.failed){
//             body = Text("Load Failed!Click retry!");
//           }else if(mode == LoadStatus.canLoading){
//             body = Text("Release to load more");
//           }else{
//             body = Text("No more Data");
//           }
//           return Container(
//             height: 55.0,
//             child: Center(child: body,),
//           );
//         },
//       ),
//       child: SingleChildScrollView(
//           child: _CardFavorite(context, size)
//       ),
//     );
//   }
//
//   Widget _CardFavorite(BuildContext context, Size size){
//     print("object" + "terima ulang");
//     if(listMov.isNotEmpty){
//       return ListView.builder(
//         scrollDirection: Axis.vertical,
//         shrinkWrap: true,
//         primary: false,
//         itemCount: listMov.length,
//         itemBuilder: (BuildContext context, int index){
//           return CardFavorite(
//             size: size,
//             coverLink: "https://awanapp.000webhostapp.com/cover/${listMov[index]['mov_cover_id']}",
//             MovTitle: "${listMov[index]['mov_title']}",
//             year: "${listMov[index]['mov_year']}",
//             MovID: "${listMov[index]['mov_id']}",
//             rating: "${listMov[index]['rating']}",
//           );
//         },
//         //CardFavorite(
//         //         size: size,
//         //         coverLink: "https://awanapp.000webhostapp.com/cover/${listMov[0]['mov_cover_id']}",
//         //         MovTitle: "${listMov[0]['mov_title']}",
//         //         year: "${listMov[0]['mov_year']}",
//         //       );
//       );
//     }else{
//       return Center(child: Text(""));
//     }
//   }
//
// }