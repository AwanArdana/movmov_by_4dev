import 'package:flutter/material.dart';
import 'package:movmov/Admin/component/InputEpisode.dart';
import 'package:movmov/Admin/component/InputMovie.dart';
import 'package:movmov/constants.dart';

class BodyAdmin extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // HeaderAdmin(size: size,)
          AdminButton(size: size,)
        ],
      ),
    );
  }

}

class AdminButton extends StatelessWidget{

  final Size size;

  const AdminButton({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Container(
              // margin: EdgeInsets.all(kDefaultPadding),
              margin: EdgeInsets.only(top: kDefaultPadding, right: kDefaultPadding * 0.5),
              width: size.width * 0.4,
              height: size.height * 0.2,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => InputMovie(),
                      ));
                },
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: kSecondaryColor,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: kShadowColor,
                          )
                        ]
                    ),
                    child: Container(
                      // padding: EdgeInsets.all(kDefaultPadding / 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Input Movie', style: TextStyle(
                              fontSize: 24
                          ),),
                          Icon(Icons.input, color: Colors.white,)
                        ],
                      ),
                    )
                ),
              ),
            ),
            Container(
              // margin: EdgeInsets.all(kDefaultPadding),
              margin: EdgeInsets.only(top: kDefaultPadding, left: kDefaultPadding * 0.5),
              width: size.width * 0.4,
              height: size.height * 0.2,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => InputEpisode(),
                  ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kSecondaryColor,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: kShadowColor,
                      )
                    ]
                  ),
                  child: Container(
                    // padding: EdgeInsets.all(kDefaultPadding / 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Input episode', style: TextStyle(
                          fontSize: 24
                        ),),
                        Icon(Icons.input, color: Colors.white,)
                      ],
                    ),
                  )
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

}

