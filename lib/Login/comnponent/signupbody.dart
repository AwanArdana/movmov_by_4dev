import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movmov/constants.dart';
import 'package:http/http.dart' as http;

class SignUpBody extends StatefulWidget{
  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  // final Size size;
  TextEditingController controllerUsername = new TextEditingController();

  TextEditingController controllerPassword = new TextEditingController();

  TextEditingController controllerPasswordConfirm = new TextEditingController();

  //show or hide password
  bool passwordVisible;

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
  }

  void cekAkun(BuildContext context)async{
    String query = "SELECT * FROM akun WHERE username='" + controllerUsername.text + "'";
    final response = await http.get(Uri.parse(webserviceGetData + query));
    List list = json.decode(response.body);
    if(list.isNotEmpty){
      Fluttertoast.showToast(
        msg: "Username has used.",
        toastLength: Toast.LENGTH_SHORT,
      );
    }else{
      RegisterData();
      Navigator.pop(context);
    }
  }

  void RegisterData(){
    Uri url = Uri.parse("https://movmovbyfourdev.000webhostapp.com/WebServiceAPI/registerakun.php");

    http.post(url, body: {
      "username": controllerUsername.text,
      "password": controllerPassword.text,
      "kodeJenisAkun": "1",
      "kodeProfileTemplate": "0"
    });
  }

  // bool cekConfirmPassword(){
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        title: Text(""),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  "Create Your Account",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),

              Container(
                //username
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
                  obscureText: !passwordVisible,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Icon(Icons.lock, color: Colors.white,),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible?Icons.visibility:Icons.visibility_off,
                        color: Colors.white.withOpacity(0.3),
                      ),
                      onPressed: (){
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
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
                  controller: controllerPasswordConfirm,
                  textInputAction: TextInputAction.done,
                  obscureText: !passwordVisible,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: "Password Confirm",
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Icon(Icons.lock, color: Colors.white,),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible?Icons.visibility:Icons.visibility_off,
                        color: Colors.white.withOpacity(0.3),
                      ),
                      onPressed: (){
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),

              Container(
                //login button
                  margin: EdgeInsets.only(top: 5),
                  child: SizedBox(
                    height: 50,
                    width: size.width * 0.8,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (Set<MaterialState> states){
                              if(states.contains(MaterialState.pressed)) return kSecondaryColor.withOpacity(0.5);
                              return kSecondaryColor;
                            }
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(29),
                          )
                        )
                      ),
                      // minWidth: size.width * 0.8,
                      // height: 50,
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(29)
                      // ),
                      // color: kSecondaryColor,
                      onPressed: (){
                        // cekConfirmPassword();
                        // if(cekConfirmPassword()){
                        //   Navigator.pop(context);
                        // }
                        if(controllerUsername.text.isNotEmpty && controllerPassword.text.isNotEmpty && controllerPasswordConfirm.text.isNotEmpty){
                          if(controllerPassword.text.length > 30){
                            Fluttertoast.showToast(msg: "Password to Long");
                          }else if(controllerPassword.text.length < 5){
                            Fluttertoast.showToast(msg: "Password to Short");
                          }else{
                            if(controllerPassword.text == controllerPasswordConfirm.text){
                              // RegisterData();
                              cekAkun(context);
                              // Navigator.pop(context);
                              // return true;
                            }else{
                              Fluttertoast.showToast(msg: "Password Confirm not Correct");
                              // return false;
                            }
                          }
                        }else{
                          Fluttertoast.showToast(msg: "Incomplete Data");
                        }

                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}