import 'package:flutter/material.dart';
import 'package:movmov/Favorite/component/BodyFavorite.dart';
import 'package:movmov/constants.dart';
import 'package:movmov/fungsi_kirim_web_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   // body: BodyFavorite(),
    // );
    return Center(
      child: FutureBuilder<List>(
        future: SQLEksek("SELECT * FROM fav_perakun WHERE id_akun = '"+Holder.id_akun+"'"),
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new BodyFavorite(listFav: snapshot.data,)
              : new Center(child: new CircularProgressIndicator(),);
        },
      ),
    );
  }

}