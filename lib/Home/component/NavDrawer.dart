import 'package:flutter/material.dart';
import 'package:movmov/Login/comnponent/loginbody.dart';
import 'package:movmov/constants.dart';

class NavDrawer extends StatelessWidget{
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
                'Side menu',
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
                ListTile(
                  leading: Icon(Icons.input, color: Colors.white,),
                  title: Text('Welcome'),
                  onTap: () => {},
                ),
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
                  onTap: (){Navigator.popUntil(context, (route) => route.isFirst);},
                ),
              ],
            ),
          )



        ],
      ),
    );
  }

}