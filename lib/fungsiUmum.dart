import 'package:http/http.dart' as http;
import 'package:movmov/constants.dart';

String makeNewCode(String kode, int panjang){
  int spasi = panjang - kode.length;
  String kodeBaru = "";
  for(int i = 0; i < spasi; i++){
    kodeBaru += "0";
  }
  kodeBaru += kode;
  return kodeBaru;
}
