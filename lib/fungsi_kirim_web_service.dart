import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movmov/constants.dart';


Future<List> getDataGlobal(String API, String parameter) async{
  final response = await http.get(Uri.parse(webservice + API + parameter));
  return json.decode(response.body);
}