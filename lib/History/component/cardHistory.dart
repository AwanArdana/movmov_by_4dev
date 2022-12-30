import 'package:flutter/material.dart';
import 'package:movmov/Player/player_screen.dart';
import 'package:movmov/constants.dart';
import 'package:movmov/fungsi_kirim_web_service.dart';

class CardHistory extends StatefulWidget{
  final Size size;
  final String coverLink;
  final String MovTitle;
  final String episode;
  final String MovID;
  final String rating;
  final String genres;

  const CardHistory({Key key, this.size, this.coverLink, this.MovTitle, this.episode, this.MovID, this.rating, this.genres}) : super(key: key);

  @override
  State<CardHistory> createState() => _CardHistoryState();
}

class _CardHistoryState extends State<CardHistory> {
  // List listGenres = [];

  @override
  void initState() {
    super.initState();
    // getGenres();
  }

  // Future<void> getGenres() async{
  //   // List list = [];
  //   // list = await SQLEksek("SELECT gen_title FROM genres g, movie_genres mg WHERE g.gen_id=mg.gen_id and mg.mov_id=" + widget.MovID);
  //   // setState(() {
  //   //   listGenres = list;
  //   // });
  //   var split = widget.genres.split(" - ");
  //   listGenres.add(split);
  //   print(listGenres[0]);
  // }

  Widget _Genres(){
    // if(listGenres.isNotEmpty){
    //   return Text("${listGenres[0]['gen_title']} - ${listGenres[1]['gen_title']} - ${listGenres[2]['gen_title']}");
    //   // new Text("ada");
    // }else{
    //   return Text("");
    // }
    return Text(widget.genres);
  }

  Future<void> moveToPlayer(BuildContext context) async{
    showDialog(
        context: context,
        builder: (_){
          return Dialog(
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const[
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Loading...",
                    style: TextStyle(
                      color: Colors.black
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
    String qListEpisode = "SELECT e.episode_id, e.episode FROM episode e WHERE e.mov_id=" + widget.MovID;
    List listepisode = await SQLEksek(qListEpisode);
    if(listepisode.isNotEmpty){
      Navigator.of(context).pop();
      Navigator.push(
          context,
          MaterialPageRoute(

            // builder: (context) => new PlayerScreen(Episode: widget.episode, mov_id: widget.MovID, listEpisode: listepisode, listGenre: listGenres, rating: widget.rating, )
              builder: (context) => new PlayerScreen(Episode: widget.episode, mov_id: widget.MovID, listEpisode: listepisode, rating: widget.rating, genres: widget.genres, )
          )
      );
    }else{
      Navigator.of(context).pop();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size.height * 0.18,
      width: widget.size.width,
      padding: EdgeInsets.only(bottom: kDefaultPadding, left: kDefaultPadding),
      child: GestureDetector(
        onTap: (){
          moveToPlayer(context);
        },
        child: Row(
          children: <Widget>[
            Container(
              width: widget.size.width * 0.4,
              child: AspectRatio(
                aspectRatio: 100/80,
                child: Container(
                  decoration: BoxDecoration(
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
                    style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    "Eps. " + widget.episode
                  ),
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
            )
          ],
        ),
      ),
    );
  }
}