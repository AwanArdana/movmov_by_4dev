import 'package:flutter/material.dart';
import 'package:movmov/constants.dart';
import 'package:movmov/fungsi_kirim_web_service.dart';

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
        future: SQLEksek("SELECT mov_id, mov_title FROM movie"),
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

  List copylist(List listawal){
    List<String> listakhir = [];
    for(int i = 0; i < listawal.length; i++){
      listakhir.add(listawal[i]["mov_title"]);
    }
    return listakhir;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      setState(() {
                        selectedValue = value as String;
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
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: "Episode",
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                  border: InputBorder.none,
                ),
              ),
            )
          ],
        )
    );
  }

}