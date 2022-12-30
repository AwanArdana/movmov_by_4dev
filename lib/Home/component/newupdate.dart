import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movmov/Player/player_screen.dart';
import 'package:movmov/constants.dart';
import 'package:http/http.dart' as http;

class NewUpdate extends StatelessWidget{
  const NewUpdate({
    Key key, this.list,
  }): super(key: key);

  final List list;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              NewUpdateCard(
                image: "https://awanapp.000webhostapp.com/cover/${list[0]['mov_cover_id']}",
                title: "${list[0]['mov_title']}",
                episode: "${list[0]['episode']}",
                press: (){
                  moveToPlayer(0, context);
                },
              ),
              NewUpdateCard(
                image: "https://awanapp.000webhostapp.com/cover/${list[1]['mov_cover_id']}",
                title: "${list[1]['mov_title']}",
                episode: "${list[1]['episode']}",
                press: (){
                  moveToPlayer(1, context);
                },
              )
            ],
          ),

          Row(
            children: [
              NewUpdateCard(
                image: "https://awanapp.000webhostapp.com/cover/${list[2]['mov_cover_id']}",
                title: "${list[2]['mov_title']}",
                episode: "${list[2]['episode']}",
                press: (){
                  moveToPlayer(2, context);
                },
              ),
              NewUpdateCard(
                image: "https://awanapp.000webhostapp.com/cover/${list[3]['mov_cover_id']}",
                title: "${list[3]['mov_title']}",
                episode: "${list[3]['episode']}",
                press: (){
                  moveToPlayer(3, context);
                },
              )
            ],
          ),
        ],
      ),
    );
  }

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
    // String queryListGenres = "SELECT gen_title FROM genres g, movie_genres mg WHERE g.gen_id=mg.gen_id and mg.mov_id=" + "${list[listKe]['mov_id']}";
    // final response = await http.get(Uri.parse(webserviceGetData + queryListGenres));
    // List listGenres = json.decode(response.body);
    // if(listGenres.isNotEmpty){
    //   String queryListEpisode = "SELECT e.episode_id, e.episode FROM episode e WHERE e.mov_id=" + "${list[listKe]['mov_id']}";
    //   final responseepisode = await http.get(Uri.parse(webserviceGetData + queryListEpisode));
    //   List listEpisode = json.decode(responseepisode.body);
    //   if(listEpisode.isNotEmpty){
    //     Navigator.of(context).pop();
    //     Navigator.push(context, MaterialPageRoute(
    //       // builder: (context) => new PlayerScreen(Episode: "${list[listKe]['episode']}", mov_id: "${list[listKe]['mov_id']}", rating: "${list[listKe]['rating']}", listEpisode: listEpisode, listGenre: listGenres,),
    //     ));
    //   }
    //
    // }

    //getEpisode
    String query = "SELECT e.episode_id, e.episode from episode e WHERE e.mov_id='" + list[listKe]['mov_id'] + "'";
    final response = await http.get(Uri.parse(webserviceGetData + query));

    List listEpisode = jsonDecode(response.body);
    if(listEpisode.isNotEmpty){
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => new PlayerScreen(Episode: list[listKe]['episode'], listEpisode: listEpisode, mov_id: list[listKe]['mov_id'], rating: list[listKe]['rating'], genres: list[listKe]['all_genres'],),
      ));
    }else{
      Navigator.of(context).pop();
    }
    // Navigator.of(context).pop();

  }

}

class NewUpdateCard extends StatelessWidget{
  const NewUpdateCard({
    Key key, this.list, this.image, this.title, this.episode, this.press
  }): super(key: key);

  final List list;
  final String image, title, episode;
  final Function press;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding / 2,
        top: kDefaultPadding,
      ),
      width: size.width * 0.4,
      child: GestureDetector(
        onTap: press,
        child: Column(
          children: <Widget>[
            Container(
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
                child: Image.network(image),
              ),
            ),
            Container(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "$title\n".toUpperCase(),
                          style: Theme.of(context).textTheme.button,
                        ),
                        TextSpan(
                          text: "Episode "+"$episode".toUpperCase(),
                          style: TextStyle(
                            color: kTextColor.withOpacity(0.5),
                          )
                        )
                      ]
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }}