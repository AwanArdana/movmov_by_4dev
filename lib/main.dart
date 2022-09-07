import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movmov/Home/home_screen.dart';
import 'package:movmov/Login/login_screen.dart';
import './constants.dart';
import 'Home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Future<List> getData() async{
  //   final response = await http.get(Uri.parse("https://awanapp.000webhostapp.com/getmovdata.php"));
  //   return json.decode(response.body);
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MOV MOV',
      theme: ThemeData(
        canvasColor: kPrimaryColor,
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor, ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
      },

    );
  }
}

