import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movmov/Detail/component/titlewithdetail.dart';
import 'package:movmov/Player/player_screen.dart';
import 'package:movmov/Detail/component/headerdetail.dart';
import 'package:movmov/constants.dart';
import 'package:movmov/fungsi_kirim_web_service.dart';


import 'DetailReadMore.dart';
import 'cover_with_title.dart';

class BodyDetail extends StatelessWidget{
  BodyDetail({Key key, this.list, this.Mov_id}) : super(key: key);

  final List list;
  final String Mov_id;

  // Future<List> getGenres() async{
  //   final response = await http.get(Uri.parse("https://awanapp.000webhostapp.com/getmovgenre.php?id=" + Mov_id));
  //   return json.decode(response.body);
  // }



  // InAppWebViewGroupOptions _options = InAppWebViewGroupOptions(
  //   android: AndroidInAppWebViewOptions(
  //     useHybridComposition: true,
  //   )
  // );
  // InAppWebViewController webView;
  // String Url = "https://drive.google.com/file/d/18bcKYHpxizSFvdwT4fBlSG_PNridmpnc/preview";
  // bool status = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          HeaderDetail(size: size),
          /*new FutureBuilder<List>(
            future: getData(),
            builder: (context, snapshot){
              if(snapshot.hasError) print(snapshot.error);

              return snapshot.hasData
                  ? new Detail(list: snapshot.data,size: size,)
                  : new Center(child: new CircularProgressIndicator(),);
            },

          ),*/
          new FutureBuilder<List>(
            // future: getGenres(Mov_id),
            // future: getDataGlobal("getmovgenre.php?id=", Mov_id),
            future: SQLEksek("SELECT gen_title FROM genres g, movie_genres mg WHERE g.gen_id=mg.gen_id and mg.mov_id=" + Mov_id),
            builder: (context, snapshot){
              if(snapshot.hasError) print(snapshot.error);

              return snapshot.hasData
                  ? new Detail(list: list, size: size, Mov_id: Mov_id, listGenre: snapshot.data,)
                  // :  new Center(child: new CircularProgressIndicator(),);
                  : Detail(list: list, size: size, Mov_id: Mov_id,listGenre: [],);
            },
          ),
          // Detail(list: list,size: size, Mov_id: Mov_id,)

        ],
      ),
    );
  }

}

class Detail extends StatelessWidget{

  const Detail({
    Key key, this.list, this.size, this.Mov_id, this.listGenre,
  }): super(key: key);

  final List list;
  final List listGenre;
  final Size size;
  final String Mov_id;

  // Future<List> getEpisode() async{
  //   final response = await http.get(Uri.parse("https://awanapp.000webhostapp.com/getmovepisode.php?id=" + Mov_id));
  //   return json.decode(response.body);
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CoverWithTitle(
            size: size,
            title: "${list[0]['mov_title']}",
            coverId: "${list[0]['mov_cover_id']}",
            listGenre: listGenre,
          ),

          DetailWithReadMore(Detail: "${list[0]['mov_deskripsi']}",),

          new FutureBuilder<List>(
            // future: getEpisode(Mov_id),
            // future: getDataGlobal("getmovepisode.php?id=", Mov_id),
            future: SQLEksek("SELECT e.episode_id, e.episode from episode e WHERE e.mov_id=" + Mov_id),
            builder: (context, snapshot){
              if(snapshot.hasError) print(snapshot.error);

              return snapshot.hasData
                  ? new ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index){

                            return Container(
                              padding: const EdgeInsets.all(8),
                              height: 50,
                              color: kPrimaryColor,
                              child: Row(
                                children: [
                                  Text(
                                      'Episode ${snapshot.data[index]['episode']}'
                                  ),
                                  Spacer(),

                                  FlatButton(

                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                    color: kSecondaryColor,
                                    onPressed: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => new PlayerScreen(Episode_id: "${snapshot.data[index]['episode_id']}", listEpisode: snapshot.data, listGenre: listGenre,),
                                          )
                                      );
                                    },
                                    child: Text(
                                      "Play",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        )
                  : new Center(child: new CircularProgressIndicator(),);
            },
          )

          // ListView.builder(
          //   scrollDirection: Axis.vertical,
          //   shrinkWrap: true,
          //   padding: const EdgeInsets.all(8),
          //   itemCount: list.length,
          //   itemBuilder: (BuildContext context, int index){
          //
          //     return Container(
          //       padding: const EdgeInsets.all(8),
          //       height: 50,
          //       color: kPrimaryColor,
          //       child: Row(
          //         children: [
          //           Text(
          //               'Episode ${list[index]['episode']}'
          //           ),
          //           Spacer(),
          //
          //           FlatButton(
          //
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(20)
          //             ),
          //             color: kSecondaryColor,
          //             onPressed: (){
          //               Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                     builder: (context) => PlayerScreen(Episode_id: "${list[index]['episode_id']}",),
          //                   )
          //               );
          //             },
          //             child: Text(
          //               "Play",
          //               style: TextStyle(color: Colors.white),
          //             ),
          //           )
          //         ],
          //       ),
          //     );
          //   },
          // ),




        ],
      ),
    );
  }

}

class DetailWithReadMore extends StatelessWidget{
  const DetailWithReadMore({
    Key key, this.Detail,
  }) : super(key: key);

  final String Detail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleWithDetail(title: "Detail",),

        new ReadMore(Detail: Detail),


      ],
    );
  }

}






