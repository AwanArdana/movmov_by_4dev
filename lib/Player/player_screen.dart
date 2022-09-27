import 'package:flutter/material.dart';
import 'package:movmov/Player/component/bodyplayer.dart';
import 'package:movmov/fungsi_kirim_web_service.dart';

class PlayerScreen extends StatelessWidget{
  PlayerScreen({Key key, this.Episode, this.listEpisode, this.listGenre, this.mov_id}): super(key: key);

  final String Episode;
  final List listEpisode;
  final List listGenre;
  final String mov_id;

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
        future: SQLEksek("SELECT e.episode_id, m.mov_title, m.mov_year, m.mov_cover_id, e.episode, m.mov_deskripsi, e.mov_cloud_link from movie m, episode e WHERE m.mov_id=e.mov_id and e.episode=" + Episode + " and m.mov_id = " + mov_id),
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new BodyPlayer(list: snapshot.data, listEpisode: listEpisode, ep: Episode, listGenre: listGenre != null ? listGenre : [], mov_id: mov_id,)
              : new Center(child: new CircularProgressIndicator(),);
        },
      )

      // BodyPlayer(Episode_id: Episode_id,),
    );
  }
}