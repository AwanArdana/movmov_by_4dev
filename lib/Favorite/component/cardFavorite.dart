import 'package:flutter/material.dart';
import 'package:movmov/Detail/detail_screen.dart';
import 'package:movmov/constants.dart';
import 'package:movmov/fungsi_kirim_web_service.dart';

class CardFavorite extends StatelessWidget{
  final Size size;
  final String coverLink;
  final String MovTitle;
  final String year;
  final String MovID;

  const CardFavorite({Key key, this.size, this.coverLink, this.MovTitle, this.year, this.MovID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.18,
      width: size.width,
      padding: EdgeInsets.only(bottom: kDefaultPadding, left: kDefaultPadding),
      child: GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(Mov_id: MovID,),
            )
          );
        },
        child: Row(
          children: <Widget>[

            Container(
              width: size.width * 0.4,
              child: AspectRatio(
                aspectRatio: 100/80,
                  child: Container(
                    decoration: BoxDecoration(
                      // image: new DecorationImage(
                      //   fit: BoxFit.fitWidth,
                      //   alignment: FractionalOffset.topCenter,
                      //   image: new NetworkImage(coverLink),
                      // ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: kShadowColor,
                          )
                        ]
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(coverLink, fit: BoxFit.cover, alignment: FractionalOffset.topCenter,),
                    ),
                  ),
              ),
            ),

            Container(
              width: (size.width * 0.6) - kDefaultPadding,
              padding: EdgeInsets.only(top: kDefaultPadding, left: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    MovTitle,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(year),

                  Spacer(),

                  new FutureBuilder<List>(
                    future: SQLEksek("SELECT gen_title FROM genres g, movie_genres mg WHERE g.gen_id=mg.gen_id and mg.mov_id=" + MovID),
                    builder: (context, snapshot){
                      if(snapshot.hasError) print(snapshot.error);

                      return snapshot.hasData
                          ? Container(margin: new EdgeInsets.only(bottom: kDefaultPadding),child: new Text("${snapshot.data[0]['gen_title']} - ${snapshot.data[1]['gen_title']} - ${snapshot.data[2]['gen_title']}"))
                          : new Text("");
                    },
                  )

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

}