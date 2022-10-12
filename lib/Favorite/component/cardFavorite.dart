import 'package:flutter/material.dart';
import 'package:movmov/constants.dart';

class CardFavorite extends StatelessWidget{
  final Size size;
  final List listMov;

  const CardFavorite({Key key, this.size, this.listMov}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.3,
      width: size.width * 0.3,
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
              // child: Image.network("https://awanapp.000webhostapp.com/cover/${listMov[0]['mov_cover_id']}"),
            ),
          )
        ],
      ),
    );
  }

}