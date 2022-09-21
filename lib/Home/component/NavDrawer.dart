import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movmov/Admin/admin_screen.dart';
import 'package:movmov/Login/comnponent/loginbody.dart';
import 'package:movmov/Login/login_screen.dart';
import 'package:movmov/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavDrawer extends StatelessWidget{

  final storage = new FlutterSecureStorage();

  Widget _insertData(BuildContext context){

    if(Holder.JenisAkun == "0"){
      return ListTile(
        leading: Icon(Icons.input, color: Colors.white,),
        title: Text('Insert Data'),
        onTap: () => {
          Navigator.of(context).push(
            new MaterialPageRoute(
              builder: (BuildContext context)=> new AdminScreen(),
            )
          )
        },
      );
    }else return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: new ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          new Container(
            child: new DrawerHeader(
              child: Text(
                Holder.namaAkun,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              decoration: BoxDecoration(
                color: kSecondaryColor,

              ),
            ),
          ),

          new Container(
            child: new Column(
              children: [
                // ListTile(
                //   leading: Icon(Icons.input, color: Colors.white,),
                //   title: Text('Insert Data'),
                //   onTap: () => {},
                // ),
                _insertData(context),
                ListTile(
                  leading: Icon(Icons.verified_user, color: Colors.white,),
                  title: Text('Profile'),
                  onTap: () => {Navigator.of(context).pop()},
                ),
                ListTile(
                  leading: Icon(Icons.settings, color: Colors.white,),
                  title: Text('Settings'),
                  onTap: () => {Navigator.of(context).pop()},
                ),
                ListTile(
                  leading: Icon(Icons.border_color, color: Colors.white,),
                  title: Text('Feedback'),
                  onTap: () => {Navigator.of(context).pop()},
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app, color: Colors.white,),
                  title: Text('Logout'),
                  // onTap: () => {Navigator.popAndPushNamed(context, '/login')},
                  // onTap: () {Navigator.pop(context,'/login');},
                  // onTap: (){Navigator.popUntil(context, (route) => route.isFirst);},
                  onTap: () async {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => LoginScreen()
                    ));
                    // SharedPreferences prefs = await SharedPreferences.getInstance();
                    // prefs?.setBool("isLoggedIn", false);
                    await storage.delete(key: "Username");
                    await storage.delete(key: "Password");
                  },
                ),
              ],
            ),
          )



        ],
      ),
    );
  }

}