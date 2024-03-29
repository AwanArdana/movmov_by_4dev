import 'dart:async';
import 'dart:convert';
import 'dart:io';

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
import 'package:crypto/crypto.dart';

class LoginBody extends StatefulWidget{
  @override
  _LoginBody createState() => new _LoginBody();
}

class _LoginBody extends State<LoginBody>{
  bool saving = false;

  final storage = new FlutterSecureStorage();

  TextEditingController controllerEmail = new TextEditingController();
  TextEditingController controllerUsername = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();

  String version = "";

  //show or hide password
  bool passwordVisible;

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
      resizeToAvoidBottomInset: false,
      body: ModalProgressHUD(child: _buildWidget(context), inAsyncCall: saving,),
    );
  }

  @override
  void initState() {
    main();
    // TODO: implement initState
    super.initState();
    startTimer();
    passwordVisible = false;
    // getAllGenres();
    // SQLConnBaru("");
  }

  // void getAllGenres() async{
  //   String query = "SELECT gen_title, mg.mov_id FROM genres g, movie_genres mg WHERE g.gen_id=mg.gen_id";
  //   final response = await http.get(Uri.parse(webserviceGetData + query));
  //
  //   Holder.listGenres = jsonDecode(response.body);
  // }


  void startTimer(){
    Timer(Duration(seconds: 0), (){
      // navigateUser();
      ReadData();
    });
  }

  void ReadData() async{
    String username = await storage.read(key: "Username");
    String email = await storage.read(key: "Email");
    String password = await storage.read(key: "Password");
    // Fluttertoast.showToast(msg: username + email + password);
    // print("Username " + username);
    // print("Password " + password);
    if(username == "GUEST" && password == "GUEST"){
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
                    Text("GUEST Relogin...", style: TextStyle(
                        color: Colors.black
                    ),)
                  ],
                ),
              ),
            );
          }
      );
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => HomeScreen()
      ));
    }else if(email.isNotEmpty && username.isNotEmpty && password.isNotEmpty){
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
      DownloadData(email, password);
      print("ada data" + " sekarang download data");
    }else{
      print("data kosong");
    }

  }

  // void navigateUser() async{
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var status = preferences.getBool("isLoggedIn") ?? false;
  //   print(status);
  //   if(status){
  //     Navigator.pushReplacement(context, MaterialPageRoute(
  //       builder: (context) => HomeScreen(),
  //     ));
  //
  //   }
  // }

  void DownloadData(String email,String password) async{
    String query = "SELECT * FROM akun WHERE email ='"+email+"' and password = '"+password+"'";
    final response = await http.get(Uri.parse(webserviceGetData + query)).timeout(
      const Duration(seconds: 10),
      onTimeout: (){
        return http.Response('Error', 408);
      }
    );
    if(response.statusCode == 408){
      Fluttertoast.showToast(msg: "Timeout 408 (Relogin)");
    }else{
      List list = json.decode(response.body);
      if(list.isNotEmpty){
        Holder.JenisAkun = list[0]["kodeJenisAkun"];
        Holder.namaAkun = list[0]["username"];
        Holder.email = list[0]["email"];
        Holder.id_akun = list[0]["id_akun"];
        Holder.kodeProfileTemplate = list[0]["kodeProfileTemplate"];

        Navigator.push(context, MaterialPageRoute(
            builder: (context) => HomeScreen()
        ));
      }else{
        Navigator.of(context).pop();
        Fluttertoast.showToast(
          msg: "Email or Password Changes",
          toastLength: Toast.LENGTH_SHORT,
        );
      }
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
            //email edittext
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
              controller: controllerEmail,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: "Email",
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
                    if(controllerEmail.text != ""){
                      if(controllerPassword.text != ""){
                        setState(() {
                          saving = true;
                        });
                        // String generateMd5(){
                        //   return md5.convert(utf8.encode(controllerPassword.text)).toString();
                        // }
                        // print("" + generateMd5());
                        String query = "SELECT * FROM akun where email ='"+controllerEmail.text+"' and password = '"+Holder.generateMd5(controllerPassword.text)+"'";
                        final client = new HttpClient();
                        client.connectionTimeout = const Duration(seconds: 10);
                        // final request = await client.get(host, port, path)
                        final response = await http.get(Uri.parse(webserviceGetData + query)).timeout(
                          const Duration(seconds: 10),
                          onTimeout: (){
                            return http.Response('Error', 408);
                          }
                        );
                        if(response.statusCode == 408){
                          setState(() {
                            saving = false;
                          });
                          Fluttertoast.showToast(
                            msg: "Timeout 408",
                            toastLength: Toast.LENGTH_SHORT,
                          );
                        }else{
                          List list = json.decode(response.body);
                          if (list.isNotEmpty){
                            //setbool prefs
                            // SharedPreferences prefs = await SharedPreferences.getInstance();
                            // prefs?.setBool("isLoggedIn", true);

                            //Secure Storage
                            await storage.write(key: "Username", value: list[0]['username']);
                            await storage.write(key: "Email", value: controllerEmail.text);
                            await storage.write(key: "Password", value: Holder.generateMd5(controllerPassword.text));

                            Holder.JenisAkun = list[0]["kodeJenisAkun"];
                            Holder.namaAkun = list[0]["username"];
                            Holder.email = list[0]["email"];
                            Holder.id_akun = list[0]["id_akun"];
                            Holder.kodeProfileTemplate = list[0]["kodeProfileTemplate"];
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
                              msg: "Email or Password not Correct",
                              toastLength: Toast.LENGTH_SHORT,
                            );
                            setState(() {
                              saving = false;
                            });

                            // Center(child: new CircularProgressIndicator(),);
                          }
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
                        msg: "Email is Empty",
                        toastLength: Toast.LENGTH_SHORT,
                      );
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
            //guest button
              margin: EdgeInsets.only(top: 5),
              child: SizedBox(
                height: 50,
                width: size.width * 0.8,
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                              (Set<MaterialState> states){
                            if(states.contains(MaterialState.pressed)) return Colors.white10;
                            return Colors.white10;
                          }
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(29),
                          )
                      )

                  ),
                  onPressed: () async {
                    await storage.write(key: "Email", value: "GUEST");
                    await storage.write(key: "Username", value: "GUEST");
                    await storage.write(key: "Password", value: "GUEST");

                    Holder.JenisAkun = "2";
                    Holder.namaAkun = "GUEST";
                    Holder.email = "GUEST";
                    Holder.id_akun = "0";
                    Holder.kodeProfileTemplate = "0";
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen()
                        )
                    );
                  },

                  child: Text(
                    "GUEST",
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

