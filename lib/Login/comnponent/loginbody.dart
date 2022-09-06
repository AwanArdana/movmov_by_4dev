import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movmov/Home/home_screen.dart';
import 'package:movmov/constants.dart';

class LoginBody extends StatelessWidget{

  const LoginBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            //title login
            margin: EdgeInsets.only(bottom: 20),
            child: Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),

          Container(
            //username edittext
            // margin: EdgeInsets.only(top: 10),
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            // width: size.width * 0.8,
            decoration: BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.circular(29),
              border: Border.all(
                color: Colors.white,
                width: 2,
              )
            ),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: "Username",
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Icon(Icons.person, color: Colors.white,),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            //password edittext
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            // width: size.width * 0.8,
            decoration: BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.circular(29),
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                )
            ),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Icon(Icons.lock, color: Colors.white,),
                ),
                border: InputBorder.none,
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 5),
            child: FlatButton(
              minWidth: size.width * 0.8,
              height: 50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(29)
              ),
              color: kSecondaryColor,
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen()
                  )
                );
              },
              child: Text(
                "LOGIN",
                style: TextStyle(color: Colors.white),
              ),
            )
          )
        ],
      ),
    );
    // return BackGround(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: <Widget>[
    //       Text(
    //         "LOGIN",style: TextStyle(fontWeight: FontWeight.bold),
    //       ),
    //       // SvgPicture.asset(
    //       //   "assets/icons/login.svg",
    //       //   height: size.height * 0.3,
    //       // ),
    //       TextFieldContainer(size: size,icon: Icons.person, hintText: "Your Email",),
    //
    //       TextFieldContainer(size: size,icon: Icons.lock, hintText: "Password",),
    //     ],
    //   )
    // );
  }}

class TextFieldContainer extends StatelessWidget{
  final Size size;
  final IconData icon;
  final String hintText;


  const TextFieldContainer({Key key, this.size, this.icon, this.hintText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }

}

class BackGround extends StatelessWidget{
  final Widget child;

  const BackGround({Key key,@required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/main_top.png",
                width: size.width * 0.35,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/images/main_bottom.png",
                width: size.width * 0.3,
              ),
            ),
            child
          ],
        ),
      ),
    );
  }

}