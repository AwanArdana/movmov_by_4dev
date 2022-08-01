import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movmov/Player/component/bodyplayer.dart';
import 'package:http/http.dart' as http;

class PlayerScreen extends StatelessWidget{
  PlayerScreen({Key key, this.Episode_id, this.listEpisode}): super(key: key);

  final String Episode_id;
  final List listEpisode;

  Future<List> getDataPlayer() async{
    final response = await http.get(Uri.parse("https://awanapp.000webhostapp.com/getmovplayer.php?id="+Episode_id));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new FutureBuilder<List>(
        future: getDataPlayer(),
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new BodyPlayer(list: snapshot.data, listEpisode: listEpisode, ep_id: Episode_id,)
              : new Center(child: new CircularProgressIndicator(),);
        },
      )

      // BodyPlayer(Episode_id: Episode_id,),
    );
  }
}