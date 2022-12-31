import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movmov/constants.dart';
import 'package:http/http.dart' as http;
import 'package:movmov/fungsi_kirim_web_service.dart';

class AkunScreen extends StatefulWidget{
  @override
  State<AkunScreen> createState() => _AkunScreenState();
}

class _AkunScreenState extends State<AkunScreen> {
  GlobalKey key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(''),
        backgroundColor: kPrimaryColor,
        actions: <Widget>[
          IconButton(
            constraints: BoxConstraints.expand(width: 80),
            icon: Icon(Icons.save, color: Colors.white,),
            onPressed: (){
              final _AkunBodyState akunBodyState = key.currentState;
              akunBodyState.savestatedata();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
          child: new AkunBody(key: key)
      ),
    );
  }
}

class AkunBody extends StatefulWidget{
  AkunBody({Key key}) : super(key: key);

  TextEditingController controllerNickname = new TextEditingController();
  TextEditingController controllerOldPass = new TextEditingController();
  TextEditingController controllerNewPass = new TextEditingController();

  @override
  State<AkunBody> createState() => _AkunBodyState();
}

class _AkunBodyState extends State<AkunBody> {
  Color inputColorNickname = Colors.white;
  Color inputColorOldPassword = Colors.white;
  Color inputColorNewPassword = Colors.white;
  final storage = new FlutterSecureStorage();
  String kodeProfileTemplate;
  int selectedProfile;

  Future<void> savestatedata() async {
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
                Text("Saving...", style: TextStyle(
                  color: Colors.black
                ),)
              ],
            ),
          ),
        );
      }
    );
    // print("harus bisa " + widget.controllerNickname.text);
    if(inputColorNickname != Colors.red){
      if(inputColorOldPassword != Colors.red){
        if(inputColorNewPassword != Colors.red){
          String query = "SELECT * FROM akun WHERE id_akun = '"+Holder.id_akun+"'";
          final response = await http.get(Uri.parse(webserviceGetData + query));
          List list = jsonDecode(response.body);
          if(list.isNotEmpty){
            if(list[0]['password'] == widget.controllerOldPass.text){
              String qupdate = "";
              if(widget.controllerNewPass.text != ""){
                if(inputColorNickname == Colors.green){
                  qupdate = "UPDATE akun SET username = '" + widget.controllerNickname.text + "' , password ='" + widget.controllerNewPass.text +"'";
                  await storage.write(key: "Username", value: widget.controllerNickname.text);
                  Holder.namaAkun = widget.controllerNickname.text;
                }else{
                  qupdate = "UPDATE akun SET password = '" + widget.controllerNewPass.text + "'";
                }
                await storage.write(key: "Password", value: widget.controllerNewPass.text);


              }else{
                if(inputColorNickname == Colors.green){
                  qupdate = "UPDATE akun SET username = '" + widget.controllerNickname.text + "'";
                  await storage.write(key: "Username", value: widget.controllerNickname.text);
                  Holder.namaAkun = widget.controllerNickname.text;
                }
              }

              if(qupdate != ""){
                if(selectedProfile.toString() != Holder.kodeProfileTemplate){
                  qupdate += ", kodeProfileTemplate ='" + selectedProfile.toString() + "'";
                  Holder.kodeProfileTemplate = selectedProfile.toString();
                }
                qupdate += " WHERE id_akun ='" + Holder.id_akun +"'";
              }else{
                if(selectedProfile.toString() != Holder.kodeProfileTemplate){
                  qupdate += "UPDATE akun SET kodeProfileTemplate ='" + selectedProfile.toString() + "'";
                  qupdate += " WHERE id_akun ='" + Holder.id_akun +"'";
                  Holder.kodeProfileTemplate = selectedProfile.toString();
                }
              }

              if(qupdate != ""){
                print(qupdate);
                SQLEksekInsert(qupdate);
                Navigator.of(context).pop(); //nutup dialog
                Navigator.of(context).pop(); //nutup halaman
              }
            }
          }else{
            Fluttertoast.showToast(
              msg: "Old Password not correct",
              toastLength: Toast.LENGTH_SHORT,
            );
            Navigator.of(context).pop();
          }
        }else{
          Fluttertoast.showToast(
            msg: "New Password not correct",
            toastLength: Toast.LENGTH_SHORT,
          );
          Navigator.of(context).pop();
        }
      }else{
        Fluttertoast.showToast(
          msg: "Old Password cant be empty",
          toastLength: Toast.LENGTH_SHORT,
        );
        Navigator.of(context).pop();
      }
    }else if(widget.controllerNickname.text == ""){
      Fluttertoast.showToast(
        msg: "Nickname cant be empty",
        toastLength: Toast.LENGTH_SHORT,
      );
      Navigator.of(context).pop();
    }else{
      Fluttertoast.showToast(
        msg: "Nickname not correct",
        toastLength: Toast.LENGTH_SHORT,
      );
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    widget.controllerNickname = new TextEditingController(text: Holder.namaAkun);

    if(Holder.kodeProfileTemplate != "0" && Holder.kodeProfileTemplate != null){
      kodeProfileTemplate = "assets/profile/"+Holder.kodeProfileTemplate+"-removebg-preview.png";
    }else{
      kodeProfileTemplate = "0";
    }
    selectedProfile = int.parse(Holder.kodeProfileTemplate);
    super.initState();

    // widget.controllerNickname.addListener(() {
    //
    //   setState(() {
    //
    //   });
    // });
  }

  Future<void> selectProfile(Size size) async {
    List<Color> colors = [Colors.transparent,Colors.transparent,Colors.transparent,Colors.transparent,Colors.transparent,Colors.transparent,];
    final result = await showDialog<bool>(
        context: context,
        builder: (_){

          return StatefulBuilder(
            builder: (context, refresh){
              return AlertDialog(
                title: Text(
                  "Select Profile",
                  style: TextStyle(
                      color: Colors.black
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Spacer(),
                        GestureDetector(
                          onTap: (){
                            refresh(() {
                              for(int i = 0; i < colors.length; i++){
                                colors[i] = Colors.transparent;
                              }
                              colors[0] = kSecondaryColor;
                              print("ganti warna border");
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: colors[0],
                                      width: 5
                                  )
                              ),
                              child: Image.asset("assets/profile/1-removebg-preview.png", width: (size.width / 4) * 0.7,)
                          ),
                        ),
                        GestureDetector(
                            onTap: (){
                              refresh((){
                                for(int i = 0; i < colors.length; i++){
                                  colors[i] = Colors.transparent;
                                }
                                colors[1] = kSecondaryColor;
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: colors[1],
                                        width: 5
                                    )
                                ),
                                child: Image.asset("assets/profile/2-removebg-preview.png", width: (size.width / 4) * 0.7,)
                            )
                        ),
                        GestureDetector(
                            onTap: (){
                              refresh((){
                                for(int i = 0; i < colors.length; i++){
                                  colors[i] = Colors.transparent;
                                }
                                colors[2] = kSecondaryColor;
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: colors[2],
                                        width: 5
                                    )
                                ),
                                child: Image.asset("assets/profile/3-removebg-preview.png", width: (size.width / 4) * 0.7,)
                            )
                        ),
                        Spacer(),
                      ],
                    ),

                    Row(
                      children: [
                        Spacer(),
                        GestureDetector(
                          onTap: (){
                            refresh(() {
                              for(int i = 0; i < colors.length; i++){
                                colors[i] = Colors.transparent;
                              }
                              colors[3] = kSecondaryColor;
                              print("ganti warna border");
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: colors[3],
                                      width: 5
                                  )
                              ),
                              child: Image.asset("assets/profile/4-removebg-preview.png", width: (size.width / 4) * 0.7,)
                          ),
                        ),
                        GestureDetector(
                            onTap: (){
                              refresh((){
                                for(int i = 0; i < colors.length; i++){
                                  colors[i] = Colors.transparent;
                                }
                                colors[4] = kSecondaryColor;
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: colors[4],
                                        width: 5
                                    )
                                ),
                                child: Image.asset("assets/profile/5-removebg-preview.png", width: (size.width / 4) * 0.7,)
                            )
                        ),
                        GestureDetector(
                            onTap: (){
                              refresh((){
                                for(int i = 0; i < colors.length; i++){
                                  colors[i] = Colors.transparent;
                                }
                                colors[5] = kSecondaryColor;
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: colors[5],
                                        width: 5
                                    )
                                ),
                                child: Image.asset("assets/profile/6-removebg-preview.png", width: (size.width / 4) * 0.7,)
                            )
                        ),
                        Spacer(),
                      ],
                    ),

                    TextButton(
                      onPressed: (){
                        // int selected = 0;
                        for(int i = 0; i < colors.length; i++){
                          if(colors[i] == kSecondaryColor){
                            selectedProfile = i + 1;
                          }
                        }
                        print("selected " + selectedProfile.toString());
                        kodeProfileTemplate = "assets/profile/"+selectedProfile.toString()+"-removebg-preview.png";
                        Navigator.of(context).pop(false);
                      },
                      child: Text('OK'),
                    )
                  ],
                ),
              );
            },
          );
        }
    );
    if(!result){
      setState(() {

      });
    }
    // showDialog(
    //
    // );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Center(
          child: GestureDetector(
            onTap: (){
              selectProfile(size);
            },
            child: Container(
              margin: EdgeInsets.only(top: kDefaultPadding),
              width: 80.0,
              height: 80.0,
              // child: Icon(Icons.person, size: 50, color: Colors.black.withOpacity(0.5)),
              child: kodeProfileTemplate=="0"
                  ? Icon(Icons.person, size: 50, color: Colors.black.withOpacity(0.5),)
                  : Image.asset(kodeProfileTemplate, scale: 0.5,),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                  border: Border.all(
                      color: kSecondaryColor,
                      width: 5
                  )
              ),
            ),
          ),
        ),

        Container(
            margin: EdgeInsets.only(top: kDefaultPadding),
            padding: EdgeInsets.all(20),
            width: size.width - (kDefaultPadding * 2),
            decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Nickname"),
                Container(
                  margin: EdgeInsets.only(top: kDefaultPadding * 0.5, bottom: kDefaultPadding),
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                  decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.circular(29),
                      border: Border.all(
                        color: inputColorNickname,
                        width: 2,
                      )
                  ),
                  child: TextFormField(
                    controller: widget.controllerNickname,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: inputColorNickname != Colors.red
                          ? (inputColorNickname != Colors.green? null:Icon(Icons.check, color: Colors.green,))
                          : Icon(Icons.not_interested, color: Colors.red,)
                    ),
                    onChanged: (text) async {
                      if(widget.controllerNickname != Holder.namaAkun && widget.controllerNickname.text != ""){
                        print("gakosong");
                        print("ganti ke " + widget.controllerNickname.text);
                        String query = "SELECT * FROM akun WHERE username ='"+ widget.controllerNickname.text+ "' ";
                        final response = await http.get(Uri.parse(webserviceGetData + query));
                        List list = json.decode(response.body);
                        if(list.isNotEmpty){
                          if(list[0]['username'] == Holder.namaAkun){
                            print("data sama");
                            setState(() {
                              inputColorNickname = Colors.white;
                            });
                          }else{
                            print("data ada");
                            setState(() {
                              inputColorNickname = Colors.red;
                            });
                          }

                        }else{
                          if(widget.controllerNickname.text != ""){
                            setState(() {
                              inputColorNickname = Colors.green;
                            });
                          }
                        }
                      }else{
                        print("kosong");
                        setState(() {
                          inputColorNickname = Colors.red;
                        });
                      }
                    },
                  ),
                ),

                Text("Old Password"),
                Container(
                  margin: EdgeInsets.only(top: kDefaultPadding * 0.5, bottom: kDefaultPadding),
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                  decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.circular(29),
                      border: Border.all(
                        color: inputColorOldPassword,
                        width: 2,
                      )
                  ),
                  child: TextFormField(
                    controller: widget.controllerOldPass,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        border: InputBorder.none
                    ),
                    onChanged: (text) {
                      if(widget.controllerOldPass.text == ""){
                        setState(() {
                          inputColorOldPassword = Colors.red;
                        });
                      }else{
                        setState(() {
                          inputColorOldPassword = Colors.white;
                        });
                      }
                    },
                  ),
                ),

                Text("New Password"),
                Container(
                  margin: EdgeInsets.only(top: kDefaultPadding * 0.5),
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                  decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.circular(29),
                      border: Border.all(
                        color: inputColorNewPassword,
                        width: 2,
                      )
                  ),
                  child: TextFormField(
                    controller: widget.controllerNewPass,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        border: InputBorder.none
                    ),
                    onChanged: (text) {
                      if(widget.controllerNewPass.text.length > 30 || widget.controllerNewPass.text.length < 5){
                        if(widget.controllerNewPass.text == ""){
                          setState(() {
                            inputColorNewPassword = Colors.white;
                          });
                        }else{
                          setState(() {
                            inputColorNewPassword = Colors.red;
                          });
                        }

                      }else{
                        setState(() {
                          inputColorNewPassword = Colors.white;
                        });
                      }
                    },
                  ),
                ),
              ],
            )
        )
      ],
    );
  }
}