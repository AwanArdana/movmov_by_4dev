import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:movmov/Home/home_screen.dart';
import 'package:movmov/Login/comnponent/signupbody.dart';
import 'package:movmov/constants.dart';
import 'package:movmov/fungsi_kirim_web_service.dart';
import 'package:http/http.dart' as http;

class LoginBody extends StatefulWidget{
  @override
  _LoginBody createState() => new _LoginBody();
}

class _LoginBody extends State<LoginBody>{
  bool saving = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ModalProgressHUD(child: _buildWidget(context), inAsyncCall: saving,),
    );
  }

  Widget _buildWidget(BuildContext context ){
    Size size = MediaQuery.of(context).size;

    TextEditingController controllerUsername = new TextEditingController();
    TextEditingController controllerPassword = new TextEditingController();

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
              controller: controllerUsername,
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
              controller: controllerPassword,
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
                onPressed: () async {
                  if(controllerUsername.text != ""){
                    if(controllerPassword.text != ""){
                      setState(() {
                        saving = true;
                      });
                      String query = "SELECT * FROM akun where username ='"+controllerUsername.text+"' and password = '"+controllerPassword.text+"'";
                      final response = await http.get(Uri.parse(webserviceGetData + query));
                      List list = json.decode(response.body);
                      if (list.isNotEmpty){
                        new Future.delayed(new Duration(seconds: 1), (){
                          setState(() {
                            saving = false;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()
                              )
                          );
                        });

                      }else{
                        // Fluttertoast.showToast(
                        //   msg: "This is Center Short Toast",
                        //   toastLength: Toast.LENGTH_SHORT,
                        // );

                        Scaffold.of(context).showSnackBar(new SnackBar(
                          content: new Text("Username or Password not Correct"),
                        ));
                        setState(() {
                          saving = false;
                        });

                        // Center(child: new CircularProgressIndicator(),);
                      }
                    }else{
                      Scaffold.of(context).showSnackBar(new SnackBar(
                        content: new Text("Password is Empty"),
                      ));
                    }
                  }else{
                    Scaffold.of(context).showSnackBar(new SnackBar(
                      content: new Text("Username is Empty"),
                    ));
                  }
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
  }

}

