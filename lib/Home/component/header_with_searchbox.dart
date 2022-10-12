import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movmov/More/more_screen.dart';
import 'package:movmov/constants.dart';


class HeaderWithSearchBox extends StatelessWidget{
  const HeaderWithSearchBox({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;



  @override
  Widget build(BuildContext context) {
    TextEditingController controllerSearch = new TextEditingController();
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5),
      //
      height: size.height * 0.2,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: 36 + kDefaultPadding,
            ),
            height: size.height * 0.2 - 27,
            // decoration: BoxDecoration(
            //     color: kPrimaryColor,
            //     borderRadius: BorderRadius.only(
            //       bottomLeft: Radius.circular(36),
            //       bottomRight: Radius.circular(36),
            //     )
            // ),
            child: Center(child: Image.asset("assets/picture/MOV LOGO 2.png", width: size.width * 0.6,)),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                height: 54,
                decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: kPrimaryColor.withOpacity(0.23),
                      )
                    ]
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: controllerSearch,
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(
                            color: kTextColor.withOpacity(0.5),
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,

                          // suffixIcon: SvgPicture.asset("assets/icons/search.svg"),
                        ),
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.only(left: 30),
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MoreScreen(query: "SELECT * FROM movie WHERE mov_title like '%"+controllerSearch.text+"%'", type: "search",)
                            )
                        );
                      },
                      icon: SvgPicture.asset(
                        "assets/icons/search.svg",
                        color: Colors.white,
                      ),
                    ),

                  ],
                ),
              )
          )
        ],
      ),
    );
  }}