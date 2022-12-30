import 'package:flutter/material.dart';
import 'package:movmov/Detail/detail_screen.dart';
import 'package:movmov/constants.dart';
import 'package:movmov/fungsi_kirim_web_service.dart';

class CardFavorite extends StatefulWidget{
  final Size size;
  final String coverLink;
  final String MovTitle;
  final String year;
  final String MovID;
  final String rating;
  final String genres;
  final List list;
  final int index;

  const CardFavorite({Key key, this.size, this.coverLink, this.MovTitle, this.year, this.MovID, this.rating, this.genres, this.list, this.index}) : super(key: key);

  @override
  State<CardFavorite> createState() => _CardFavoriteState();
}

class _CardFavoriteState extends State<CardFavorite> {
  List listGenres = [];

  @override
  void initState() {
    super.initState();
    // getGenres();
  }

  // Future<void> getGenres() async{
  //   List list = [];
  //   list = await SQLEksek("SELECT gen_title FROM genres g, movie_genres mg WHERE g.gen_id=mg.gen_id and mg.mov_id=" + widget.MovID);
  //   setState(() {
  //     listGenres = list;
  //   });
  // }

  Widget _Genres(){
    // if(listGenres.isNotEmpty){
    //   return Text(widget.genres);
    //   //return Text("${listGenres[0]['gen_title']} - ${listGenres[1]['gen_title']} - ${listGenres[2]['gen_title']}");
    // }else{
    //   return Text("");
    // }
    return Text(widget.genres);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size.height * 0.18,
      width: widget.size.width,
      padding: EdgeInsets.only(bottom: kDefaultPadding, left: kDefaultPadding),
      child: GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(Mov_id: widget.MovID, index: widget.index, listMov: widget.list,),
              // builder: (context) => DetailScreen(Mov_id: widget.MovID,),
            )
          );
        },
        child: Row(
          children: <Widget>[

            Container(
              width: widget.size.width * 0.4,
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
                      child: Image.network(widget.coverLink, fit: BoxFit.cover, alignment: FractionalOffset.topCenter,),
                    ),
                  ),
              ),
            ),

            Container(
              width: (widget.size.width * 0.6) - kDefaultPadding,
              padding: EdgeInsets.only(left: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.MovTitle,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(widget.year),

                  Text(
                    "* " + widget.rating
                  ),

                  _Genres(),

                  // new FutureBuilder<List>(
                  //   future: SQLEksek("SELECT gen_title FROM genres g, movie_genres mg WHERE g.gen_id=mg.gen_id and mg.mov_id=" + widget.MovID),
                  //   builder: (context, snapshot){
                  //     if(snapshot.hasError) print(snapshot.error);
                  //
                  //     return snapshot.hasData
                  //         ? Container(margin: new EdgeInsets.only(bottom: kDefaultPadding),child: new Text("${snapshot.data[0]['gen_title']} - ${snapshot.data[1]['gen_title']} - ${snapshot.data[2]['gen_title']}"))
                  //         : new Text("");
                  //   },
                  // )

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}