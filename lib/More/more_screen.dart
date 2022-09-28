import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movmov/Home/component/recomends.dart';
import 'package:movmov/constants.dart';
import 'package:movmov/fungsi_kirim_web_service.dart';

import '../Detail/detail_screen.dart';
import '../Home/component/newupdate.dart';

import 'package:http/http.dart' as http;

import '../Player/player_screen.dart';

class MoreScreen extends StatelessWidget{
  final String query;
  final String type;

  const MoreScreen({Key key, this.query, this.type}) : super(key: key);

  Widget _Text(){
    if(type == "newupdate"){
      return Text("New Updates");
    }else if(type == "recomends"){
      return Text("Recomended");
    }
}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: _Text(),
      ),
      body: new FutureBuilder<List>(
        future: SQLEksek(query),
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new BodyMore(list: snapshot.data, type: type,)
              : new Center(child: new CircularProgressIndicator(),);
        },
      ),
    );
  }

}

class BodyMore extends StatefulWidget{
  final List list;
  final String type;
  final Size size;

  const BodyMore({Key key, this.list, this.type, this.size}) : super(key: key);

  @override
  _BodyMore createState() => _BodyMore();

}

class _BodyMore extends State<BodyMore>{
  Future<void> moveToPlayer(int listKe, BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_){
          return Dialog(
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  Text("loading...", style: TextStyle(
                      color: Colors.black
                  ),)
                ],
              ),
            ),
          );
        }
    );
    String queryListGenres = "SELECT gen_title FROM genres g, movie_genres mg WHERE g.gen_id=mg.gen_id and mg.mov_id=" + "${widget.list[listKe]['mov_id']}";
    final response = await http.get(Uri.parse(webserviceGetData + queryListGenres));
    List listGenres = json.decode(response.body);
    if(listGenres.isNotEmpty){
      String queryListEpisode = "SELECT e.episode_id, e.episode FROM episode e WHERE e.mov_id=" + "${widget.list[listKe]['mov_id']}";
      final responseepisode = await http.get(Uri.parse(webserviceGetData + queryListEpisode));
      List listEpisode = json.decode(responseepisode.body);
      if(listEpisode.isNotEmpty){
        Navigator.of(context).pop();
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => new PlayerScreen(Episode: "${widget.list[listKe]['episode']}", mov_id: "${widget.list[listKe]['mov_id']}", listEpisode: listEpisode, listGenre: listGenres,),
        ));
      }

    }
    // Navigator.of(context).pop();

  }

  /*Widget _NewUpdateCard(BuildContext context, int index, int pos){
    print("index " + index.toString());
    print("length " + widget.list.length.toString());
    if(pos == 1){
      return NewUpdateCard(
        image: "https://awanapp.000webhostapp.com/cover/${widget.list[index]['mov_cover_id']}",
        title: "${widget.list[index]['mov_title']}",
        episode: "${widget.list[index]['episode']}",
        press: (){
          moveToPlayer(index, context);
        },
      );
    }else if((index + 1) < widget.list.length){
      return NewUpdateCard(
        image: "https://awanapp.000webhostapp.com/cover/${widget.list[index + 1]['mov_cover_id']}",
        title: "${widget.list[index + 1]['mov_title']}",
        episode: "${widget.list[index + 1]['episode']}",
        press: (){
          moveToPlayer(index + 1, context);
        },
      );
    }else{
      return SizedBox.shrink();
      // return NewUpdateCard(
      //   image: "https://awanapp.000webhostapp.com/cover/${widget.list[index]['mov_cover_id']}",
      //   title: "${widget.list[index]['mov_title']}",
      //   episode: "${widget.list[index]['episode']}",
      //   press: (){
      //     moveToPlayer(index + 1, context);
      //   },
      // );
    }
  }*/

  @override
  Widget build(BuildContext context) {
    if(widget.type == "newupdate"){
      // return new GridView.count(
      //   crossAxisCount: 2,
      //   // childAspectRatio: (),
      //   controller: new ScrollController(keepScrollOffset: false),
      //   shrinkWrap: true,
      //   scrollDirection: Axis.vertical,
      //   children: widget.list.map((String value){
      //     return new Container();
      //   }).toList(),
      // );

      return GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          // mainAxisSpacing: 100,
          // childAspectRatio: 2/1
          // childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.4),
          childAspectRatio: (140.0 / 240.0)
          // childAspectRatio: widget.size.width / widget.size.height
        ),
        itemCount: widget.list.length,
        padding: const EdgeInsets.all(8),
        // padding: const EdgeInsets.only(top: 10),
        itemBuilder: (BuildContext context, int index){
          return NewUpdateCard(
            image: "https://awanapp.000webhostapp.com/cover/${widget.list[index]['mov_cover_id']}",
            title: "${widget.list[index]['mov_title']}",
            episode: "${widget.list[index]['episode']}",
            press: (){
              moveToPlayer(index, context);
            },
          );
        },
      );

      // return new ListView.builder(
      //   scrollDirection: Axis.vertical,
      //   shrinkWrap: true,
      //   padding: const EdgeInsets.all(8),
      //   itemCount: widget.list.length,
      //   itemBuilder: (BuildContext context, int index){
      //     return Column(
      //       children: [
      //         Row(
      //           children: [
      //             // NewUpdateCard(
      //             //   image: "https://awanapp.000webhostapp.com/cover/${widget.list[index]['mov_cover_id']}",
      //             //   title: "${widget.list[index]['mov_title']}",
      //             //   episode: "${widget.list[index]['episode']}",
      //             //   press: (){
      //             //     moveToPlayer(index, context);
      //             //   },
      //             // ),
      //             _NewUpdateCard(context, index, 1),
      //             _NewUpdateCard(context, index, 2)
      //           ],
      //         )
      //       ],
      //     );
      //   },
      // );
    }else if(widget.type == "recomends"){
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              children: [
                RecomendCard(
                  image:"https://awanapp.000webhostapp.com/cover/${widget.list[0]['mov_cover_id']}",
                  title: "${widget.list[0]['mov_title']}",
                  year: "${widget.list[0]['mov_year']}",
                  press: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(Mov_id: "${widget.list[0]['mov_id']}",),
                        )
                    );
                  },
                ),

                RecomendCard(
                  image:"https://awanapp.000webhostapp.com/cover/${widget.list[1]['mov_cover_id']}",
                  title: "${widget.list[1]['mov_title']}",
                  year: "${widget.list[1]['mov_year']}",
                  press: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(Mov_id: "${widget.list[1]['mov_id']}",),
                        )
                    );
                  },
                ),
              ],
            )
          ],
        ),
      );
    }
  }

}