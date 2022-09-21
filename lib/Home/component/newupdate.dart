import 'package:flutter/material.dart';
import 'package:movmov/Player/player_screen.dart';
import 'package:movmov/constants.dart';

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

                },
              ),
              // NewUpdateCard(
              //   image: "https://awanapp.000webhostapp.com/cover/${list[1]['mov_cover_id']}",
              //   title: "${list[1]['mov_title']}",
              //   episode: "${list[1]['episode']}",
              //   press: (){},
              // )
            ],
          ),

          // Row(
          //   children: [
          //     NewUpdateCard(
          //       image: "https://awanapp.000webhostapp.com/cover/${list[2]['mov_cover_id']}",
          //       title: "${list[2]['mov_title']}",
          //       episode: "${list[2]['episode']}",
          //       press: (){},
          //     ),
          //     NewUpdateCard(
          //       image: "https://awanapp.000webhostapp.com/cover/${list[3]['mov_cover_id']}",
          //       title: "${list[3]['mov_title']}",
          //       episode: "${list[3]['episode']}",
          //       press: (){},
          //     )
          //   ],
          // ),
        ],
      ),
    );
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
                          text: "$episode".toUpperCase(),
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