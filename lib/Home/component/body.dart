import 'package:flutter/material.dart';
import 'package:movmov/Home/component/header_with_searchbox.dart';
import 'package:movmov/Home/component/newupdate.dart';
import 'package:movmov/Home/component/recomends.dart';
import 'package:movmov/Home/component/title_with_more_btn.dart';
import 'package:movmov/fungsi_kirim_web_service.dart';

class Body extends StatelessWidget{
  // Future<List> getData() async {
  //   final response = await http.get(Uri.parse("https://awanapp.000webhostapp.com/getmovdata.php"));
  //   return json.decode(response.body);
  // }
  
  // Future<List> getDataNewUpdate() async{
  //   final response = await http.get(Uri.parse("https://awanapp.000webhostapp.com/getmovnewupdate.php"));
  //   return json.decode(response.body);
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return SingleChildScrollView(
      child: Column(
        children: <Widget>[

          HeaderWithSearchBox(size: size),
          TitleWithMoreBtn(
            title: "Recomended",
            press: (){},
          ),
          new FutureBuilder<List>(
            // future: getData(),
            // future: getDataGlobal("getmovdata.php", ""),
            future: SQLEksek("SELECT * FROM movie"),
            builder: (context, snapshot){
              if(snapshot.hasError) print(snapshot.error);

              return snapshot.hasData
                  ? new RecomendsPage(list: snapshot.data,)
                  : new Center(child: new CircularProgressIndicator(),);
            },
          ),
          TitleWithMoreBtn(
            title: "New Update",
            press: (){},
          ),
          new FutureBuilder<List>(
            // future: getDataNewUpdate(),
            // future: getDataGlobal("getmovnewupdate.php", ""),
            future: SQLEksek("SELECT e.episode_id, m.mov_title, m.mov_year, m.mov_cover_id, e.episode, e.tgl from movie m, episode e WHERE m.mov_id=e.mov_id ORDER BY `e`.`tgl` DESC"),
            builder: (context, snapshot){
              if(snapshot.hasError) print(snapshot.error);

              return snapshot.hasData
                  ? new NewUpdate(list: snapshot.data)
                  : new Center(child: new CircularProgressIndicator(),);
            },
          ),

          // new FloatingActionButton(
          //   child: new Icon(Icons.add),
          //   onPressed: ()=>Navigator.of(context).push(
          //     new MaterialPageRoute(
          //       // builder: (BuildContext context)=> new AddData(),
          //     )
          //
          //    ),
          // ),
          //       floatingActionButton: new FloatingActionButton(
//         child: new Icon(Icons.add),
//         onPressed: ()=>Navigator.of(context).push(
//             new MaterialPageRoute(
//               builder: (BuildContext context)=> new AddData(),
//             )
//         ),
//       ),
          // Container(
          //   width: size.width * 0.8,
          //   height: 185,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //   child: Column(
          //     children: <Widget>[
          //       new Image.network("https://drive.google.com/uc?export=view&id=10LnmkYfOvvpyXEt7YAEt9Gmmpw5OKJRH"),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}





