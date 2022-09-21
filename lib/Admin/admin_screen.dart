import 'package:flutter/material.dart';
import 'package:movmov/Admin/component/bodyadmin.dart';

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