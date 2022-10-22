import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movmov/constants.dart';
// import 'package:sql_conn/sql_conn.dart';


Future<List> getDataGlobal(String API, String parameter) async{
  //getdata menurut API
  final response = await http.get(Uri.parse(webservice + API + parameter));
  return json.decode(response.body);
}

Future<List> SQLEksek(String query) async {
  //getData menurut SQL
  // print("SQLEksek " + query);
  final response = await http.get(Uri.parse(webserviceGetData + query));
  return json.decode(response.body);
}

Future<List> SQLEksekInsert(String query) async{
  http.post(Uri.parse(webservivePostData), body: {
    "query": query,
  });
}

// void SQLConnBaru(String query) async{
//   await SqlConn.connect(
//       ip: 'awanapp.000webhostapp.com',
//       port: '3306',
//       databaseName: 'id16677282_my_store',
//       username: 'id16677282_awan',
//       password: 'f0ur_d3Vf0ur_d3V');
//
//   var res = await SqlConn.readData("SELECT * FROM movie");
//   print(res.toString());
//   SqlConn.disconnect();
// }