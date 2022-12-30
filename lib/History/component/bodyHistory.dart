import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movmov/History/component/cardHistory.dart';
import 'package:movmov/constants.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BodyHistory extends StatelessWidget{

  final List listMov;

  const BodyHistory({Key key, this.listMov}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      primary: false,
      itemCount: listMov.length,
      itemBuilder: (BuildContext context, int index){
        return CardHistory(
          coverLink: "https://awanapp.000webhostapp.com/cover/${listMov[index]['mov_cover_id']}",
          MovTitle: "${listMov[index]['mov_title']}",
          episode: "${listMov[index]['episode']}",
          MovID: "${listMov[index]['mov_id']}",
          rating: "${listMov[index]['rating']}",
          size: size,
          genres: listMov[index]['all_genres'],
          // genres: listMov[index]['genre1'] + " - "+ listMov[index]['genre2'] + " - " + listMov[index]['genre3'],
        );
      },
    );
  }

}