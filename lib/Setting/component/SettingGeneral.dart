import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movmov/Login/login_screen.dart';
import 'package:movmov/constants.dart';

class SettingGeneral extends StatefulWidget{
  final Size size;

  const SettingGeneral({Key key, this.size}) : super(key: key);

  @override
  State<SettingGeneral> createState() => _SettingGeneralState();
}

class _SettingGeneralState extends State<SettingGeneral> {
  final storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width,
      margin: EdgeInsets.only(top: kDefaultPadding, left: kDefaultPadding, right: kDefaultPadding),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text("General"),
          // Container(
          //   child: Text("General"),
          // ),

          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.white,),
            title: Text("Logout"),
            onTap: () async{
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => LoginScreen()
              ));

              await storage.delete(key: "Username");
              await storage.delete(key: "Password");
            },
          )
        ],
      ),
    );
  }
}