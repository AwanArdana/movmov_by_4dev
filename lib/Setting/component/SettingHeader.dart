import 'package:flutter/material.dart';
import 'package:movmov/Akun/AkunScreen.dart';
import 'package:movmov/constants.dart';

class SettingHeader extends StatefulWidget{
  final Size size;

  const SettingHeader({Key key, this.size}) : super(key: key);

  @override
  State<SettingHeader> createState() => _SettingHeaderState();
}

class _SettingHeaderState extends State<SettingHeader> with WidgetsBindingObserver{

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AkunScreen(),
            )
        ).then((value) {
          setState(() {
            // print("refresh page yessssssssss");
          });
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(20),
          // border: Border.all(
          //   color: Colors.white,
          //   width: 2
          // )
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 80.0,
              height: 80.0,
              child: Icon(Icons.person, size: 50, color: Colors.black.withOpacity(0.5),),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
                border: Border.all(
                  color: kSecondaryColor,
                  width: 5
                )
              ),
            ),

            // Text(Holder.namaAkun),
            Container(
              padding: EdgeInsets.only(left: kDefaultPadding),
              height: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(Holder.namaAkun, style: TextStyle(fontSize: 20),),

                  Text("("+JenisAkunConvert()+")"),

                  Text("Edit Profile")
                ],
              ),
            ),

            Spacer(),

            Container(
              child: Icon(Icons.chevron_right, color: Colors.white, size: 40,),
            ),

          ],
        ),
      ),
    );
  }

  String JenisAkunConvert(){
    String Tipe = "";
    if(Holder.JenisAkun == "0"){
      Tipe = "Admin";
    }else if(Holder.JenisAkun == "1"){
      Tipe = "Free";
    }else if(Holder.JenisAkun == "2"){
      Tipe = "Premium";
    }
    return Tipe;
  }
}