import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:movmov/Detail/detail_screen.dart';
import 'package:movmov/constants.dart';


class RecomendsPage extends StatelessWidget{


  const RecomendsPage({
    Key key, this.list,
  }): super(key: key);

  final List list;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          RecomendCard(
            image:"https://movmovbyfourdev.000webhostapp.com/cover/${list[0]['mov_cover_id']}",
            title: "${list[0]['mov_title']}",
            year: "${list[0]['mov_year']}",
            press: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  // builder: (context) => DetailScreen(Mov_id: list[0]['mov_id'], listMov: list,),
                  builder: (context) => DetailScreen(Mov_id: list[0]['mov_id'], listMov: list, index: 0,)
                )
              );
            },
          ),
          RecomendCard(
            image:"https://movmovbyfourdev.000webhostapp.com/cover/${list[1]['mov_cover_id']}",
            title: "${list[1]['mov_title']}",
            year: "${list[1]['mov_year']}",
            press: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(Mov_id: list[1]['mov_id'], listMov: list, index: 1,)
                    // builder: (context) => DetailScreen(Mov_id: "${list[1]['mov_id']}",),
                  )
              );
            },
          ),
          RecomendCard(
            image:"https://movmovbyfourdev.000webhostapp.com/cover/${list[2]['mov_cover_id']}",
            title: "${list[2]['mov_title']}",
            year: "${list[2]['mov_year']}",
            press: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(Mov_id: list[2]['mov_id'], listMov: list, index: 2, )
                    // builder: (context) => DetailScreen(Mov_id: "${list[2]['mov_id']}",),
                  )
              );
            },
          ),
          RecomendCard(
            image:"https://movmovbyfourdev.000webhostapp.com/cover/${list[3]['mov_cover_id']}",
            title: "${list[3]['mov_title']}",
            year: "${list[3]['mov_year']}",
            press: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailScreen(Mov_id: list[3]['mov_id'], listMov: list, index: 3, )
                    // builder: (context) => DetailScreen(Mov_id: "${list[2]['mov_id']}",),
                  )
              );
            },
          ),
        ],
      ),
    );
  }

}

class RecomendCard extends StatelessWidget{
  const RecomendCard({
    Key key, this.image, this.title, this.year, this.press, this.list,

  }) : super(key: key);

  final List list;
  final String image, title, year;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(

      margin: EdgeInsets.only(
          left: kDefaultPadding,
          right: kDefaultPadding / 2,
          top: kDefaultPadding,
          bottom: kDefaultPadding * 2.5
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "$title".toUpperCase(),
                    style: Theme.of(context).textTheme.button,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                      "$year",
                      style: TextStyle(
                        color: kTextColor.withOpacity(0.5),
                      )
                  ),
                ],
              )
              // Row(
              //   children: <Widget>[
              //     RichText(
              //       text: TextSpan(
              //         children: [
              //           TextSpan(
              //             text: "$title\n".toUpperCase(),
              //             style: Theme.of(context).textTheme.button,
              //           ),
              //           TextSpan(
              //             text: "$year".toUpperCase(),
              //             style: TextStyle(
              //               color: kTextColor.withOpacity(0.5),
              //             )
              //           )
              //         ]
              //       ),
              //     )
              //   ],
              // ),
            )
          ],
        ),
      ),

    );
  }

}