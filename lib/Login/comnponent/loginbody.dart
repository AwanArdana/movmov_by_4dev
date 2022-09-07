import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movmov/Home/home_screen.dart';
import 'package:movmov/Login/comnponent/signupbody.dart';
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
            //login button
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
          ),

          Container(
            //sign up button
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
                          builder: (context) => SignUpBody()
                      )
                  );
                },
                child: Text(
                  "SIGN UP",
                  style: TextStyle(color: Colors.white),
                ),
              )
          ),
        ],
      ),
    );
  }}

