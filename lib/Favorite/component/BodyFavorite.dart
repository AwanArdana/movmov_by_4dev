import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movmov/Favorite/component/cardFavorite.dart';
import 'package:http/http.dart' as http;
import 'package:movmov/constants.dart';
import 'package:movmov/fungsi_kirim_web_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BodyFavorite extends StatelessWidget {

  final List listMov;

  const BodyFavorite({Key key, this.listMov}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      primary: false,
      itemCount: listMov.length,
      itemBuilder: (BuildContext context, int index){
        return CardFavorite(
          size: size,
          coverLink: "https://movmovbyfourdev.000webhostapp.com/cover/${listMov[index]['mov_cover_id']}",
          MovTitle: "${listMov[index]['mov_title']}",
          year: "${listMov[index]['mov_year']}",
          MovID: "${listMov[index]['mov_id']}",
          rating: "${listMov[index]['rating']}",
          genres: listMov[index]['all_genres'],
          list: listMov,
          index: index,
          // genres: listMov[index]['genre1'] + " - "+ listMov[index]['genre2'] + " - " + listMov[index]['genre3'],
        );
      },
    );
  }

}