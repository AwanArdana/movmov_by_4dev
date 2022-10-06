import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movmov/constants.dart';
import 'package:movmov/fungsi_kirim_web_service.dart';
import 'package:http/http.dart' as http;

class InputMovie extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Input Movie'),
      ),
      body: new FutureBuilder<List>(
        future: SQLEksek("SELECT gen_title, gen_id FROM genres ORDER BY gen_title"),
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new BodyInputMovie(size: size, list: snapshot.data,)
              : new Center(child: new CircularProgressIndicator(),);
        },
      ),
    );
  }
  
}

class BodyInputMovie extends StatefulWidget{
  final Size size;
  final List list;

  const BodyInputMovie({Key key, this.size, this.list}) : super(key: key);

  @override
  _BodyInputMovie createState() => _BodyInputMovie();

}

class _BodyInputMovie extends State<BodyInputMovie>{

  //title
  TextEditingController controllerMovTitle = new TextEditingController();
  //year
  String selectedYear;
  //genres
  String selectedGenres1;
  String selectedGenres2;
  String selectedGenres3;
  // String selectedGenresID1;
  // String selectedGenresID2;
  // String selectedGenresID3;
  List<String> selectedGenresID = [];

  var tcVisibility2 = false;
  var tcVisibility3 = false;
  //cover link
  TextEditingController controllerCoverLink = new TextEditingController();
  //description
  TextEditingController controllerDescription = new TextEditingController();

  List copylist(List listawal){
    List<String> listakhir = [];
    for(int i = 0; i < listawal.length; i++){
      listakhir.add(listawal[i]["gen_title"]);
    }
    return listakhir;
  }

  Future<void> cekInput(BuildContext context) async {
    if(controllerMovTitle.text != ""){
      if(selectedYear != null){
        if(selectedGenres1 != null){
          if(controllerCoverLink.text != ""){
            if(controllerDescription.text != ""){
              print("cek okee");


              try{
                String query = "INSERT INTO "
                    "movie (mov_title, mov_year, mov_cover_id, mov_deskripsi) "
                    "VALUES ('"+controllerMovTitle.text+"', '"+selectedYear+"', '"+controllerCoverLink.text+"', '"+controllerDescription.text+"')";

                print("query insert movie " + query);
                SQLEksekInsert(query);

                // SQLEksek("SELECT mov_id FROM movie WHERE mov_title = '"+controllerMovTitle.text+"'");
                // List list = SQLEksek("SELECT mov_id FROM movie WHERE mov_title = '"+controllerMovTitle.text+"'");
                // Future<List> list = SQLEksek("SELECT mov_id FROM movie WHERE mov_title = '"+controllerMovTitle.text+"'");
                String querycariID = "SELECT mov_id FROM movie WHERE mov_title = '"+controllerMovTitle.text+"'";
                final response = await http.get(Uri.parse(webserviceGetData + querycariID));
                List list = json.decode(response.body);
                String movIdBaru;
                if(list.isNotEmpty){
                  movIdBaru = list[0]["mov_id"];
                  print("Mov id baru " + movIdBaru);

                  for(int i = 0; i < selectedGenresID.length; i++){
                    String qInsertGenre = "INSERT INTO movie_genres (mov_id, gen_id) VALUES ('"+movIdBaru+"', '"+selectedGenresID[i]+"')";
                    print(qInsertGenre + "");
                    SQLEksekInsert(qInsertGenre);
                  }
                }



                Navigator.pop(context);
              }on Exception catch (_) {
                print('never reached');
              }
            }else{
              Fluttertoast.showToast(msg: "Description Link is Empty", toastLength: Toast.LENGTH_SHORT);
            }
          }else{
            Fluttertoast.showToast(msg: "Cover Link is Empty", toastLength: Toast.LENGTH_SHORT);
          }
        }else{
          Fluttertoast.showToast(msg: "Must select 1 Genre", toastLength: Toast.LENGTH_SHORT);
        }
      }else{
        Fluttertoast.showToast(msg: "Year is Empty", toastLength: Toast.LENGTH_SHORT);
      }
    }else{
      Fluttertoast.showToast(msg: "Title is Empty", toastLength: Toast.LENGTH_SHORT);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              //Title
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
                controller: controllerMovTitle,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: "Movie Title",
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                  border: InputBorder.none,
                ),
              ),
            ),

            Container(
              //Tahun
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
                      '-Select Year-',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    items: listTanggal.map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(fontSize: 14),
                      ),
                    )).toList(),
                    value: selectedYear,
                    onChanged: (value){
                      setState(() {
                        selectedYear = value as String;
                        //cekgenres
                      });
                    },
                  ),
                ),
              ),
            ),

            Container(
              //genres 1
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
                      '-Select Genres 1-',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    items: copylist(widget.list).map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(fontSize: 14),
                      ),
                    )).toList(),
                    value: selectedGenres1,
                    onChanged: (value){
                      setState(() {
                        selectedGenres1 = value as String;
                        tcVisibility2 = true;
                        for(int i = 0; i < widget.list.length; i++){
                          if(widget.list[i]["gen_title"] == selectedGenres1){
                            // selectedGenresID1 = widget.list[i]["gen_id"];
                            // print("genre id = " + selectedGenresID1);
                            selectedGenresID.add(widget.list[i]["gen_id"]);
                          }
                        }
                        //cekgenres
                      });
                    },
                  ),
                ),
              ),
            ),

            Visibility(
              visible: tcVisibility2,
              child: Container(
                //genres 2
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
                        '-Select Genres 2-',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      items: copylist(widget.list).map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(fontSize: 14),
                        ),
                      )).toList(),
                      value: selectedGenres2,
                      onChanged: (value){
                        setState(() {
                          selectedGenres2 = value as String;
                          tcVisibility3 = true;
                          for(int i = 0; i < widget.list.length; i++){
                            if(widget.list[i]["gen_title"] == selectedGenres2){
                              // selectedGenresID2 = widget.list[i]["gen_id"];
                              // print("genre id = " + selectedGenresID2);
                              selectedGenresID.add(widget.list[i]["gen_id"]);
                            }
                          }
                          //cekgenres
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),

            Visibility(
              visible: tcVisibility3,
              child: Container(
                //genres 3
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
                        '-Select Genres 3-',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      items: copylist(widget.list).map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(fontSize: 14),
                        ),
                      )).toList(),
                      value: selectedGenres3,
                      onChanged: (value){
                        setState(() {
                          selectedGenres3 = value as String;
                          for(int i = 0; i < widget.list.length; i++){
                            if(widget.list[i]["gen_title"] == selectedGenres3){
                              // selectedGenresID3 = widget.list[i]["gen_id"];
                              // print("genre id = " + selectedGenresID3);
                              selectedGenresID.add(widget.list[i]["gen_id"]);
                            }
                          }
                          //cekgenres
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),

            Container(
              //cover link
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
                controller: controllerCoverLink,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: "Cover link",
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                  border: InputBorder.none,
                ),
              ),
            ),

            Container(
              //Description
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
                maxLines: 3,
                controller: controllerDescription,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: "Description",
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                  border: InputBorder.none,
                ),
              ),
            ),

            Container(
              //button
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
                    // cekInput(context);
                  },
                  child: Text(
                    "Input",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



}