import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movmov/constants.dart';


Future<List> getDataGlobal(String API, String parameter) async{
  //getdata menurut API
  final response = await http.get(Uri.parse(webservice + API + parameter));
  return json.decode(response.body);
}

Future<List> SQLEksek(String query) async {
  //getData menurut SQL
  final response = await http.get(Uri.parse(webserviceGetData + query));
  return json.decode(response.body);
}