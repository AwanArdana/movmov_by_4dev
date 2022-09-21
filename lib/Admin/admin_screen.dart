import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movmov/Admin/component/bodyadmin.dart';
import 'package:movmov/Detail/component/bodydetail.dart';

class AdminScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Admin'),
      ),
      body: BodyAdmin(),
    );
  }


}