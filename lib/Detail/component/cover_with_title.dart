
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movmov/Player/player_screen.dart';
import 'package:movmov/constants.dart';
import 'package:simple_shadow/simple_shadow.dart';

class CoverWithTitle extends StatelessWidget{
  const CoverWithTitle({
    Key key, this.size, this.title, this.coverId, this.mov_id, this.rating, this.genres, this.listEpisode
  }) : super(key: key);

  final String title, coverId;
  final Size size;
  final List listEpisode;
  final String genres;
  final String mov_id;
  final String rating;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.6,
      width: size.width,
      // alignment: Alignment.bottomCenter,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Text(
              title,
              style: TextStyle(
                color: kTextColor.withOpacity(0.8),
                fontSize: 39,
                fontWeight: FontWeight.bold
              )
          ),
          // new FutureBuilder<List>(
          //   future: getGenres(),
          //   builder: (context, snapshot){
          //     if(snapshot.hasError) print(snapshot.error);
          //
          //     return snapshot.hasData
          //         ? new ListView.builder(
          //           shrinkWrap: true,
          //           padding: const EdgeInsets.all(0),
          //           scrollDirection: Axis.vertical,
          //           itemCount: snapshot.data.length,
          //           itemBuilder: (BuildContext context, int index){
          //             return Center(
          //               child: Text("${snapshot.data[index]['gen_title']}"),
          //             );
          //           },
          //         )
          //     // new Text(
          //     //             "${snapshot.data[0]['gen_title']}, "
          //     //             "${snapshot.data[1]['gen_title']}, "
          //     //             "${snapshot.data[2]['gen_title']}"
          //     //       )
          //           // ListView.builder(
          //           //   scrollDirection: Axis.horizontal,
          //           //   itemCount: snapshot.data.length,
          //           //   itemBuilder: (BuildContext context, int index){
          //           //     return Text(
          //           //         "${snapshot.data[index]['gen_title']}"
          //           //     );
          //           //   },
          //           // )
          //         : new Center(child: new Text("Genre"),);
          //   }
          // ),

          new Text(
            // cekGenre("listGenre"),
            genres,
            style: TextStyle(
              color: kTextColor.withOpacity(0.7),
              fontSize: 18,
            ),
          ),
          // new Text(
          //     "${listGenre[0]['gen_title']}, ${listGenre[1]['gen_title']}, ${listGenre[2]['gen_title']}",
          //     style: TextStyle(
          //       color: kTextColor.withOpacity(0.7),
          //       fontSize: 20,
          //     )
          // ),
          new Text(
              "Rating " + rating,
              style: TextStyle(
                color: kTextColor.withOpacity(0.8),
                fontSize: 16,
              )
          ),

          _PlayButton(context),

        ],
      ),

      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            bottomLeft: Radius.circular(10)
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            blurRadius: 10,
            color: kShadowColor,
          )
        ],
        image: new DecorationImage(
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
            image: new NetworkImage(
              "https://awanapp.000webhostapp.com/cover/"+coverId,
            )
        ),

      ),
    );
  }

  Widget _PlayButton(BuildContext context){
    if(listEpisode.isNotEmpty){
      return Container(

        transform: Matrix4.translationValues(0.0, 25.0, 0.0),
        // child: FlatButton(
        //   onPressed: (){
        //     Navigator.push(context,
        //       MaterialPageRoute(
        //         builder: (context) => PlayerScreen(Episode_id: "1",)
        //       )
        //     );
        //   },
        //   child: SimpleShadow(
        //     child: SvgPicture.asset(
        //       "assets/icons/play-button-svgrepo-com.svg",
        //       color: Colors.white,
        //     ),
        //     opacity: 1,
        //     color: Colors.white,
        //     offset: Offset(0,0),
        //     sigma: 10,
        //   ),
        // ),

        child: new FloatingActionButton(
          backgroundColor: Colors.transparent,
          child: SimpleShadow(
            child: SvgPicture.asset(
              "assets/icons/play-button-svgrepo-com.svg",
              color: Colors.white,
            ),
            opacity: 1,
            color: Colors.white,
            offset: Offset(0,0),
            sigma: 10,
          ),
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => new PlayerScreen(Episode: "1", listEpisode: listEpisode,rating: rating, mov_id: mov_id, genres: genres)
                  // builder: (context) => new PlayerScreen(Episode: "1", listEpisode: ,)
                  // builder: (context) => new PlayerScreen(Episode: "1", listGenre: listGenre, listEpisode: listEpisode, mov_id: mov_id, rating: rating,)
                )
            );
          },
        ),
        // child: SimpleShadow(
        //   child: SvgPicture.asset(
        //     "assets/icons/play-button-svgrepo-com.svg",
        //     color: Colors.white,
        //   ),
        //   opacity: 1,
        //   color: Colors.white,
        //   offset: Offset(0,0),
        //   sigma: 10,
        // ),


        // child: ClipRRect(
        //   borderRadius: BorderRadius.circular(33),
        //   child: BackdropFilter(
        //     filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        //     child: Container(
        //       decoration: BoxDecoration(
        //         color: Colors.black.withOpacity(0.15),
        //       ),
        //       child: SvgPicture.asset(
        //         "assets/icons/play-button-svgrepo-com.svg",
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
        // )


      );
    }else{
      return Text("");
    }
  }

}

// cekGenre(List list){
//   String genre = "";
//   for(int i=0; i<list.length; i++){
//     if(list[i].isEmpty){
//       print("empty " + i.toString());
//     } else {
//       if(genre == ""){
//         genre += "${list[i]['gen_title']}";
//       }else{
//         genre += ", ${list[i]['gen_title']}";
//       }
//
//     }
//   }
//   return genre;
// }