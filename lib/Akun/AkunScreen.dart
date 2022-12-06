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
  TextEditingController controlerNewPass = new TextEditingController();

  @override
  State<AkunBody> createState() => _AkunBodyState();
}

class _AkunBodyState extends State<AkunBody> {
  Color inputColorNickname = Colors.white;
  final storage = new FlutterSecureStorage();

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
    print("harus bisa " + widget.controllerNickname.text);
    if(inputColorNickname != Colors.red){
      if(widget.controllerOldPass.text != ""){
        String query = "SELECT * FROM akun WHERE id_akun = '"+Holder.id_akun+"'";
        final response = await http.get(Uri.parse(webserviceGetData + query));
        List list = json.decode(response.body);
        if(list.isNotEmpty){
          if(list[0]['password'] == widget.controllerOldPass.text){
            if(widget.controlerNewPass.text != ""){
              String qupdate = "";
              if(inputColorNickname == Colors.green){
                qupdate = "UPDATE akun SET username = '" + widget.controllerNickname.text + "' , password ='" + widget.controlerNewPass.text +"' WHERE id_akun = '" +Holder.id_akun+ "'";
                print(qupdate);
              }else{
                qupdate = "UPDATE akun SET password = '" + widget.controlerNewPass.text + "' WHERE id_akun = '"+Holder.id_akun+"'";
              }

              SQLEksekInsert(qupdate);
              await storage.write(key: "Password", value: widget.controlerNewPass.text);
              if(inputColorNickname == Colors.green){
                await storage.write(key: "Username", value: widget.controllerNickname.text);
                Holder.namaAkun = widget.controllerNickname.text;
              }
            }else{
              String qupdate = "";
              if(inputColorNickname == Colors.green){
                qupdate = "UPDATE akun SET username = '" + widget.controllerNickname.text + "' WHERE id_akun = '" +Holder.id_akun+ "'";
                print(qupdate);

                SQLEksekInsert(qupdate);
                await storage.write(key: "Username", value: widget.controllerNickname.text);
                Holder.namaAkun = widget.controllerNickname.text;
              }
            }
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }else{
            Fluttertoast.showToast(
              msg: "Old Password not correct",
              toastLength: Toast.LENGTH_SHORT,
            );
            Navigator.of(context).pop();
          }
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


    // widget.controllerNickname.addListener(() {
    //
    //   setState(() {
    //
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Center(
          child: Container(
            margin: EdgeInsets.only(top: kDefaultPadding),
            width: 80.0,
            height: 80.0,
            child: Icon(Icons.person, size: 50, color: Colors.black.withOpacity(0.5)),
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
                        color: Colors.white,
                        width: 2,
                      )
                  ),
                  child: TextFormField(
                    controller: widget.controllerOldPass,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        border: InputBorder.none
                    ),
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
                        color: Colors.white,
                        width: 2,
                      )
                  ),
                  child: TextFormField(
                    controller: widget.controlerNewPass,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        border: InputBorder.none
                    ),
                  ),
                ),
              ],
            )
        )
      ],
    );
  }
}