import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movmov/constants.dart';

class HeaderDetail extends StatelessWidget{
  const HeaderDetail({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: kDefaultPadding+10,
        // bottom: kDefaultPadding,
      ),
      height: size.height * 0.1,
      decoration: BoxDecoration(
        color: kPrimaryColor,
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/back_arrow.svg",
              color: Colors.white,
            ),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          Text(
            "MOV MOV!",
            style: Theme.of(context).textTheme.headline6.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold
            ),
          )
        ],
      ),
    );
  }}