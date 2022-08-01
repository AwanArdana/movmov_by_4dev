import 'package:flutter/material.dart';
import 'package:movmov/constants.dart';

class TitleWithDetail extends StatelessWidget{
  const TitleWithDetail({
    Key key, this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      margin: const EdgeInsets.only(
          top: kDefaultPadding * 2,
          left: kDefaultPadding
      ),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                left: kDefaultPadding / 4
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(
                  right: kDefaultPadding/4
              ),
              height: 7,
              color: kShadowColor.withOpacity(0.3),
            ),
          )
        ],
      ),
    );
  }


}