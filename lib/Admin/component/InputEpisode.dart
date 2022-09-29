import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:movmov/constants.dart';
import 'package:movmov/fungsi_kirim_web_service.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class InputEpisode extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Input Episode'),
      ),
      // body: BodyIndutEpisode(size: MediaQuery.of(context).size,),
      body: new FutureBuilder<List>(
        future: SQLEksek("SELECT mov_title FROM movie"),
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new BodyInputEpisode(list: snapshot.data, size: size,)
              : new Center(child: new CircularProgressIndicator(),);
        },
      ),
    );
  }

}

class BodyInputEpisode extends StatefulWidget{
  final Size size;
  final List list;

  const BodyInputEpisode({Key key, this.size, this.list}) : super(key: key);

  @override
  _BodyInputEpisode createState() => _BodyInputEpisode();

}

class _BodyInputEpisode extends State<BodyInputEpisode>{
  String selectedValue;
  String selectedID;
  TextEditingController controllerEpisode = new TextEditingController();
  TextEditingController controllerLink = new TextEditingController();

  List copylist(List listawal){
    List<String> listakhir = [];
    for(int i = 0; i < listawal.length; i++){
      listakhir.add(listawal[i]["mov_title"]);
    }
    return listakhir;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                //mov id || mov title
                margin: EdgeInsets.symmetric(horizontal: widget.size.width * 0.1, vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.circular(29),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    )
                ),
                child: DropdownButtonHideUnderline(
                  child: SizedBox(
                    width: widget.size.width,
                    child: DropdownButton(
                      hint: Text(
                        '-Select-',
                        style: TextStyle(
                          // fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      items: copylist(widget.list).map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(fontSize: 14),
                        ),
                      )).toList(),
                      value: selectedValue,
                      onChanged: (value){
                        setState((){
                          selectedValue = value as String;
                          cekMovId();
                        });
                      },

                    ),
                  ),
                ),
              ),

              Container(
                //Episode
                margin: EdgeInsets.symmetric(horizontal: widget.size.width * 0.1, vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.circular(29),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  )
                ),
                child: TextFormField(
                  controller: controllerEpisode,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: "Episode",
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                    border: InputBorder.none,
                  ),
                ),
              ),

              Container(
                //Link
                margin: EdgeInsets.symmetric(horizontal: widget.size.width * 0.1, vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.circular(29),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    )
                ),
                child: TextFormField(
                  controller: controllerLink,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: "Link",
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                    border: InputBorder.none,
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 5),
                child: SizedBox(
                  height: 50,
                  width: widget.size.width * 0.8,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (Set<MaterialState> states){
                            if(states.contains(MaterialState.pressed)) return kSecondaryColor.withOpacity(0.5);
                            return kSecondaryColor;
                          }
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(29),
                        )
                      )
                    ),
                    onPressed: () {
                      cekInput(context);
                    },
                    child: Text(
                      "Input",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }

  Future<void> cekMovId() async {
    String query = "SELECT mov_id FROM movie WHERE mov_title = '"+selectedValue+"'";
    // List list = SQLEksek(query) as List;
    final response = await http.get(Uri.parse(webserviceGetData + query));
    List list = json.decode(response.body);
    if(list.isNotEmpty){
      selectedID = list[0]["mov_id"];
      print("Mov id" + selectedID);
    }
  }

  void cekInput(BuildContext context){
    if(selectedValue != null && selectedID != null){
      if(controllerEpisode.text != ""){
        if(controllerLink.text != ""){
          String link = controllerLink.text;
          link = link.replaceAll("https://mega.nz/file/", "");
          //final original = 'Hello World';
          // final find = 'World';
          // final replaceWith = 'Home';
          // final newString = original.replaceAll(find, replaceWith);
          
          print("cek Oke");
          var now = new DateTime.now();
          var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
          String formattedDate = formatter.format(now);
          String query = "INSERT INTO episode (mov_id,episode, mov_cloud_link, tgl) VALUES ('"+selectedID+"', '"+controllerEpisode.text+"', '"+link+"', '"+formattedDate+"')";
          print("query insert " + query);
          // http.post(webserviceGetData)
          SQLEksekInsert(query);
          Navigator.pop(context);
        }else{
          Fluttertoast.showToast(msg: "Link is Empty", toastLength: Toast.LENGTH_SHORT);
        }
      }else{
        Fluttertoast.showToast(msg: "Episode is Empty", toastLength: Toast.LENGTH_SHORT);
      }
    }else{
      Fluttertoast.showToast(msg: "Select movie", toastLength: Toast.LENGTH_SHORT);
    }
  }

}