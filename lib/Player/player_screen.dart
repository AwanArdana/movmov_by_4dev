import 'package:flutter/material.dart';
import 'package:movmov/Player/component/bodyplayer.dart';
import 'package:movmov/fungsi_kirim_web_service.dart';

class PlayerScreen extends StatelessWidget{
  PlayerScreen({Key key, this.Episode, this.listEpisode, this.mov_id, this.rating, this.genres}): super(key: key);

  final String Episode;
  final List listEpisode;
  final String genres;
  final String mov_id;
  final String rating;

  // Future<List> getDataPlayer() async{
  //   final response = await http.get(Uri.parse("https://awanapp.000webhostapp.com/getmovplayer.php?id="+Episode));
  //   return json.decode(response.body);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new FutureBuilder<List>(
        // future: getDataPlayer(),
        // future: getDataGlobal("getmovplayer.php?id=", Episode_id),
        future: SQLEksek("SELECT e.episode_id, e.download_link1, m.mov_title, m.mov_year, m.mov_cover_id, e.episode, m.mov_deskripsi, e.mov_cloud_link, e.mov_cloud_link2 from movie m, episode e WHERE m.mov_id=e.mov_id and e.episode=" + Episode + " and m.mov_id = " + mov_id),
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new BodyPlayer(list: snapshot.data,ep_id: snapshot.data[0]['episode_id'], listEpisode: listEpisode, ep: Episode, mov_id: mov_id, rating: rating, genres: genres,)
              : new Center(child: new CircularProgressIndicator(),);
        },
      )

      // BodyPlayer(Episode_id: Episode_id,),
    );
  }
}