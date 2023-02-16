import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movmov/Home/component/header_with_searchbox.dart';
import 'package:movmov/Home/component/newupdate.dart';
import 'package:movmov/Home/component/recomends.dart';
import 'package:movmov/Home/component/title_with_more_btn.dart';
import 'package:movmov/More/more_screen.dart';
import 'package:movmov/constants.dart';
import 'package:movmov/fungsi_kirim_web_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget{

  @override
  _Body createState() => _Body();
}

class _Body extends State<Body>{
  RefreshController _refreshController = RefreshController(initialRefresh: false);


  static List listRecomends = [];
  static List listUpdate = [];


  void _onRefresh() async{
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      // data = null;
      listRecomends = [];
      listUpdate = [];
      getData();
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      // data = null;
      listRecomends = [];
      listUpdate = [];
      getData();
    });
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async{
    // String queryRecomends = "SELECT m.*, COUNT(f.mov_id) AS total FROM movie m, fav_perakun f WHERE m.mov_id = f.mov_id GROUP BY m.mov_id ORDER BY total DESC LIMIT 3";
    // String queryRecomends = "SELECT * FROM movie";
    // String queryRecomends = "SELECT m.*, GROUP_CONCAT(g.gen_title) as all_genres FROM movie m NATURAL JOIN movie_genres mg NATURAL JOIN genres g GROUP BY m.mov_id";
    //SELECT m.*, COUNT(f.mov_id) AS totalF, COUNT(f.mov_id) + watch_time AS total FROM movie m, fav_perakun f WHERE m.mov_id = f.mov_id GROUP BY m.mov_id ORDER BY totalF desc, watch_time DESC LIMIT 5
    // String queryRecomends = "SELECT m.*, COUNT(f.mov_id) AS totalF FROM movie m, fav_perakun f WHERE m.mov_id = f.mov_id GROUP BY m.mov_id ORDER BY totalF desc, watch_time DESC";
    String queryRecomends = "SELECT m.*, GROUP_CONCAT(g.gen_title) as all_genres FROM movie m NATURAL JOIN movie_genres mg NATURAL JOIN genres g GROUP BY m.mov_id ORDER BY watch_time desc";

    final responseRecomends = await http.get(Uri.parse(webserviceGetData + queryRecomends));

    // String queryUpdate = "SELECT e.episode_id, m.*, e.episode, e.tgl from movie m, episode e WHERE m.mov_id=e.mov_id ORDER BY e.tgl DESC";
    String queryUpdate = "SELECT m.*, GROUP_CONCAT(g.gen_title) as all_genres, e.episode_id, e.episode, e.tgl from movie m NATURAL JOIN movie_genres mg NATURAL JOIN genres g NATURAL JOIN episode e GROUP BY e.episode_id ORDER BY e.tgl DESC";
    final responseUpdate = await http.get(Uri.parse(webserviceGetData + queryUpdate));

    setState(() {
      listRecomends = json.decode(responseRecomends.body);
      listUpdate = json.decode(responseUpdate.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SmartRefresher(
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      controller: _refreshController,
      header: WaterDropMaterialHeader(backgroundColor: kSecondaryColor,),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            HeaderWithSearchBox(size: size),
            TitleWithMoreBtn(
              title: "Recomended",
              press: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MoreScreen(query: "SELECT m.*, GROUP_CONCAT(g.gen_title) as all_genres FROM movie m NATURAL JOIN movie_genres mg NATURAL JOIN genres g GROUP BY m.mov_id", type: "recomends",)
                    )
                );
              },
            ),
            _RecomendsPage(context),
            // new FutureBuilder<List>(
            //   // future: getData(),
            //   // future: getDataGlobal("getmovdata.php", ""),
            //   future: SQLEksek("SELECT m.*, COUNT(f.mov_id) AS total FROM movie m, fav_perakun f WHERE m.mov_id = f.mov_id GROUP BY m.mov_id ORDER BY total DESC LIMIT 3"),
            //   builder: (context, snapshot){
            //
            //     if(data != null){
            //       return Text("adadata");
            //       // return RecomendsPage(list: data,);
            //     }else{
            //       if(snapshot.hasError) print(snapshot.error);
            //
            //       if(snapshot.hasData){
            //         data = snapshot.data;
            //       }
            //
            //       return snapshot.hasData
            //           // ? RecomendsPage(list: snapshot.data,)
            //           ? Text("databaru")
            //           : Center(child: new CircularProgressIndicator(),);
            //     }
            //
            //   },
            // ),
            TitleWithMoreBtn(
              title: "New Update",
              press: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MoreScreen(query: "SELECT m.*, GROUP_CONCAT(g.gen_title) as all_genres, e.episode_id, e.episode, e.tgl from movie m NATURAL JOIN movie_genres mg NATURAL JOIN genres g NATURAL JOIN episode e GROUP BY e.episode_id ORDER BY e.tgl DESC", type: "newupdate",)
                    )
                );
              },
            ),
            // new FutureBuilder<List>(
            //   // future: getDataNewUpdate(),
            //   // future: getDataGlobal("getmovnewupdate.php", ""),
            //   future: SQLEksek("SELECT e.episode_id, m.*, e.episode, e.tgl from movie m, episode e WHERE m.mov_id=e.mov_id ORDER BY e.tgl DESC"),
            //   builder: (context, snapshot){
            //     if(snapshot.hasError) print(snapshot.error);
            //
            //     return snapshot.hasData
            //         ? new NewUpdate(list: snapshot.data)
            //         : new Center(child: new CircularProgressIndicator(),);
            //   },
            // ),
            _NewUpdate(context),
          ],
        ),
      ),
    );
  }

  Widget _RecomendsPage(BuildContext context){
    if(listRecomends.isNotEmpty){
      return RecomendsPage(list: listRecomends,);
    }else{
      return Center(child: new CircularProgressIndicator(),);
    }
  }

  Widget _NewUpdate(BuildContext context){
    if(listUpdate.isNotEmpty){
      return NewUpdate(list: listUpdate,);
    }else{
      return Center(child: new CircularProgressIndicator(),);
    }
  }

}





