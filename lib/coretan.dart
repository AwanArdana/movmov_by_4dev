import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget{
  final Size size;
  final IconData icon;
  final String hintText;


  const TextFieldContainer({Key key, this.size, this.icon, this.hintText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }

  String query = "SELECT * FROM akun where username ='"+controllerUsername.text+"' and password = '"+controllerPassword.text+"'";
  final response = await http.get(Uri.parse(webserviceGetData + query));
  List list = json.decode(response.body);
  if (list.isNotEmpty){
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs?.setBool("isLoggedIn", true);
  Holder.JenisAkun = list[0]["kodeJenisAkun"];
  Holder.namaAkun = list[0]["username"];
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

}