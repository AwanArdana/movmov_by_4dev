import 'package:flutter/material.dart';
import 'package:movmov/Player/component/bodyplayer.dart';
import 'package:movmov/fungsi_kirim_web_service.dart';

class PlayerScreen extends StatelessWidget{
  PlayerScreen({Key key, this.Episode_id, this.listEpisode, this.listGenre}): super(key: key);

  final String Episode_id;
  final List listEpisode;
  final List listGenre;

  // Future<List> getDataPlayer() async{
  //   final response = await http.get(Uri.parse("https://awanapp.000webhostapp.com/getmovplayer.php?id="+Episode_id));
  //   return json.decode(response.body);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new FutureBuilder<List>(
        // future: getDataPlayer(),
        // future: getDataGlobal("getmovplayer.php?id=", Episode_id),
        future: SQLEksek("SELECT e.episode_id, m.mov_title, m.mov_year, m.mov_cover_id, e.episode, m.mov_deskripsi, e.mov_cloud_link from movie m, episode e WHERE m.mov_id=e.mov_id and e.episode_id=" + Episode_id),
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new BodyPlayer(list: snapshot.data, listEpisode: listEpisode, ep_id: Episode_id, listGenre: listGenre != null ? listGenre : [],)
              : new Center(child: new CircularProgressIndicator(),);
        },
      )

      // BodyPlayer(Episode_id: Episode_id,),
    );
  }
}