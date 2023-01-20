import 'package:flutter/material.dart';

// const kPrimaryColor = Color(0xFF002B86);
// const kTextColor = Color(0xFFFFFFFF);
// const kBackgroundColor  = Color(0xFF000E2F);

const kPrimaryColor = Color(0xFF1C1C34);
const kTextColor = Color(0xFFFFFFFF);
const kBackgroundColor  = Color(0xFF242444);
const kShadowColor = Color(0xFF000000);
const kSecondaryColor = Color(0xFF556de3);

const double kDefaultPadding = 20.0;

const String webservice = "https://movmovbyfourdev.000webhostapp.com/";
const String webserviceGetData = "https://movmovbyfourdev.000webhostapp.com/WebServiceAPI/getDataGlobal.php?query=";
const String webservivePostData = "https://movmovbyfourdev.000webhostapp.com/WebServiceAPI/postDataGlobal.php";

const List<String> listTanggal = ['2010','2011','2012','2013','2014','2015','2016','2017','2018','2019','2020','2021','2022','2023','2024','2025','2026','2027','2028','2029','2030'];

// const String versiapk = "0.0.1";

class Holder{
  static String JenisAkun = ""; // 0 Admin , 1 Free registred, 2 Guest
  static String namaAkun = "";
  static String id_akun = "";
  static String kodeProfileTemplate = "";
  static String versiapk = "";

  // static List listGenres = [];
}