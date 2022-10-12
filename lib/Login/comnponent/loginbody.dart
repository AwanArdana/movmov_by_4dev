import 'dart:async';
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:movmov/Home/home_screen.dart';
import 'package:movmov/Login/comnponent/signupbody.dart';
import 'package:movmov/constants.dart';
import 'package:movmov/fungsi_kirim_web_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LoginBody extends StatefulWidget{
  @override
  _LoginBody createState() => new _LoginBody();
}

class _LoginBody extends State<LoginBody>{
  bool saving = false;

  final storage = new FlutterSecureStorage();

  TextEditingController controllerUsername = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();

  String version = "";

  void main() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo){
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      Holder.versiapk = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
      print(appName +" "+ packageName +" "+ version +" "+ buildNumber);
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ModalProgressHUD(child: _buildWidget(context), inAsyncCall: saving,),
    );
  }

  @override
  void initState() {
    main();
    // TODO: implement initState
    super.initState();
    startTimer();
  }



  void startTimer(){
    Timer(Duration(seconds: 0), (){
      // navigateUser();
      ReadData();
    });
  }

  void ReadData() async{
    String username = await storage.read(key: "Username");
    String password = await storage.read(key: "Password");
    // print("Username " + username);
    // print("Password " + password);
    if(username.isNotEmpty && password.isNotEmpty){
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_){
          return Dialog(
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  Text("Relogin...", style: TextStyle(
                    color: Colors.black
                  ),)
                ],
              ),
            ),
          );
        }
      );
      DownloadData(username, password);
      print("ada data" + " sekarang download data");
    }else{
      print("data kosong");
    }

  }

  void navigateUser() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var status = preferences.getBool("isLoggedIn") ?? false;
    print(status);
    if(status){
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ));

    }
  }

  void DownloadData(String username,String password) async{
    String query = "SELECT * FROM akun WHERE username ='"+username+"' and password = '"+password+"'";
    final response = await http.get(Uri.parse(webserviceGetData + query));
    List list = json.decode(response.body);
    if(list.isNotEmpty){
      Holder.JenisAkun = list[0]["kodeJenisAkun"];
      Holder.namaAkun = list[0]["username"];
      Holder.id_akun = list[0]["id_akun"];

      Navigator.push(context, MaterialPageRoute(
        builder: (context) => HomeScreen()
      ));
    }else{

    }
  }

  Widget _buildWidget(BuildContext context ){
    Size size = MediaQuery.of(context).size;



    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Spacer(),
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
                          //setbool prefs
                          // SharedPreferences prefs = await SharedPreferences.getInstance();
                          // prefs?.setBool("isLoggedIn", true);

                          //Secure Storage
                          await storage.write(key: "Username", value: controllerUsername.text);
                          await storage.write(key: "Password", value: controllerPassword.text);

                          Holder.JenisAkun = list[0]["kodeJenisAkun"];
                          Holder.namaAkun = list[0]["username"];
                          Holder.id_akun = list[0]["id_akun"];
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
                          Fluttertoast.showToast(
                            msg: "Username or Password not Correct",
                            toastLength: Toast.LENGTH_SHORT,
                          );

                          // Scaffold.of(context).showSnackBar(new SnackBar(
                          //   content: new Text("Username or Password not Correct"),
                          // ));
                          setState(() {
                            saving = false;
                          });

                          // Center(child: new CircularProgressIndicator(),);
                        }
                      }else{
                        Fluttertoast.showToast(
                          msg: "Password is Empty",
                          toastLength: Toast.LENGTH_SHORT,
                        );
                        // Scaffold.of(context).showSnackBar(new SnackBar(
                        //   content: new Text("Password is Empty"),
                        // ));
                      }
                    }else{
                      Fluttertoast.showToast(
                        msg: "Username is Empty",
                        toastLength: Toast.LENGTH_SHORT,
                      );
                      // Scaffold.of(context).showSnackBar(new SnackBar(
                      //   content: new Text("Username is Empty"),
                      // ));
                    }
                  },

                  child: Text(
                    "LOGIN",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
          ),

          Container(
            //sign up button
              margin: EdgeInsets.only(top: 5),
              child: TextButton(
                // minWidth: size.width * 0.8,
                // height: 50,
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(29)
                // ),
                // color: kSecondaryColor,
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

          Spacer(),

          Text(Holder.versiapk),
        ],
      ),
    );
  }

}

