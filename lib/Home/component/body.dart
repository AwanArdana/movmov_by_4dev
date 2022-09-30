import 'package:flutter/material.dart';
import 'package:movmov/Home/component/header_with_searchbox.dart';
import 'package:movmov/Home/component/newupdate.dart';
import 'package:movmov/Home/component/recomends.dart';
import 'package:movmov/Home/component/title_with_more_btn.dart';
import 'package:movmov/More/more_screen.dart';
import 'package:movmov/fungsi_kirim_web_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Body extends StatefulWidget{

  @override
  _Body createState() => _Body();
}

class _Body extends State<Body>{
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {

    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {

    });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SmartRefresher(
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      controller: _refreshController,
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
                        builder: (context) => MoreScreen(query: "SELECT * FROM movie", type: "recomends",)
                    )
                );
              },
            ),
            new FutureBuilder<List>(
              // future: getData(),
              // future: getDataGlobal("getmovdata.php", ""),
              future: SQLEksek("SELECT * FROM movie"),
              builder: (context, snapshot){
                if(snapshot.hasError) print(snapshot.error);

                return snapshot.hasData
                    ? new RecomendsPage(list: snapshot.data,)
                    : new Center(child: new CircularProgressIndicator(),);
              },
            ),
            TitleWithMoreBtn(
              title: "New Update",
              press: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MoreScreen(query: "SELECT e.episode_id, m.mov_title, m.mov_year, m.mov_cover_id, e.episode, e.tgl, m.mov_id from movie m, episode e WHERE m.mov_id=e.mov_id ORDER BY `e`.`tgl` DESC", type: "newupdate",)
                    )
                );
              },
            ),
            new FutureBuilder<List>(
              // future: getDataNewUpdate(),
              // future: getDataGlobal("getmovnewupdate.php", ""),
              future: SQLEksek("SELECT e.episode_id, m.mov_title, m.mov_year, m.mov_cover_id, e.episode, e.tgl, m.mov_id from movie m, episode e WHERE m.mov_id=e.mov_id ORDER BY `e`.`tgl` DESC"),
              builder: (context, snapshot){
                if(snapshot.hasError) print(snapshot.error);

                return snapshot.hasData
                    ? new NewUpdate(list: snapshot.data)
                    : new Center(child: new CircularProgressIndicator(),);
              },
            ),
          ],
        ),
      ),
    );
  }

}





