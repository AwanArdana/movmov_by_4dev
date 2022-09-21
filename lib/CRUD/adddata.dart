import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

class AddData extends StatefulWidget{
  @override
  _AddDataState createState()=> new _AddDataState();
}

class _AddDataState extends State<AddData>{

  TextEditingController controllerTitle = new TextEditingController();
  TextEditingController controllerYear = new TextEditingController();
  TextEditingController controllerCoverId = new TextEditingController();
  TextEditingController controllerCloudLink = new TextEditingController();

  void addData(){
    var url="https://awanapp.000webhostapp.com/adddata.php";

    http.post(url, body: {
      "mov_title": controllerTitle.text,
      "mov_year": controllerYear.text,
      "mov_cover_id": controllerCoverId.text,
      "mov_cloud_link": controllerCloudLink.text
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("ADD DATA"),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            new Column(
              children: <Widget>[
                new TextField(
                  controller: controllerTitle,
                  decoration: new InputDecoration(
                    hintText: "Title",
                    labelText: "Title"
                  ),
                ),
                new TextField(
                  controller: controllerYear,
                  decoration: new InputDecoration(
                      hintText: "Year",
                      labelText: "Year"
                  ),
                ),
                new TextField(
                  controller: controllerCoverId,
                  decoration: new InputDecoration(
                      hintText: "Cover ID",
                      labelText: "Cover ID"
                  ),
                ),
                new TextField(
                  controller: controllerCloudLink,
                  decoration: new InputDecoration(
                      hintText: "Cloud Link",
                      labelText: "Cloud Link"
                  ),
                ),

                new Padding(padding: const EdgeInsets.all(10.0)),

                new ElevatedButton(
                  child: new Text("ADD DATA"),
                  // color: Colors.blueAccent,
                  onPressed: (){
                    addData();
                    Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context)=> new MyApp(),
                        )
                    );
                    setState(() {});
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

}