import 'package:flutter/material.dart';
import 'package:movmov/Setting/component/SettingGeneral.dart';
import 'package:movmov/Setting/component/SettingHeader.dart';
import 'package:movmov/constants.dart';

class SettingBody extends StatefulWidget{
  @override
  _SettingBody createState() => _SettingBody();

}

class _SettingBody extends State<SettingBody>{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        SettingHeader(size: size,),
        SettingGeneral(size: size,),
      ],
    );
  }

}

