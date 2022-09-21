import 'package:flutter/material.dart';
import 'package:movmov/constants.dart';


class TitleWithMoreBtn extends StatelessWidget{
  const TitleWithMoreBtn({
    Key key, this.title, this.press,
  }) : super(key: key);

  final String title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: <Widget>[
          TitleWithCustomUnderline(text: title,),
          Spacer(),
          TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                        (Set<MaterialState> states){
                      if(states.contains(MaterialState.pressed)) return kSecondaryColor.withOpacity(0.5);
                      return kSecondaryColor;
                    }
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )
                )

            ),
            // shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(20)
            // ),
            // color: kSecondaryColor,
            onPressed: press,
            child: Text(
              "More",
              style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }

}

class TitleWithCustomUnderline extends StatelessWidget{
  const TitleWithCustomUnderline({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding / 4),
            child: Text(
              text,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(right: kDefaultPadding/4),
              height: 7,
              color: kSecondaryColor.withOpacity(0.3),
            ),
          )
        ],
      ),
    );
  }

}