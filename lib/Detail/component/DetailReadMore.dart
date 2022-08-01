import 'package:flutter/material.dart';
import 'package:movmov/constants.dart';


class ReadMore extends StatefulWidget{
  final String Detail;
  ReadMore({@required this.Detail});

  @override
  _DataReadMOre createState() => new _DataReadMOre();
}

class _DataReadMOre extends State<ReadMore>{
  String firstHalf;
  String secondHalf;

  bool flag = true;

  @override
  void initState(){
    super.initState();

    if(widget.Detail.length > 100){
      firstHalf = widget.Detail.substring(0, 100);
      secondHalf = widget.Detail.substring(100, widget.Detail.length);
    }else{
      firstHalf = widget.Detail;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      padding: new EdgeInsets.symmetric(horizontal: kDefaultPadding , vertical: 10.0),
      child:  secondHalf.isEmpty
          ? new Text("firstHalf")
          : new Column(
        children: <Widget>[
          new Text(
            flag ? (firstHalf + "...") : (firstHalf + secondHalf),
            style: new TextStyle(color: Colors.white70),
          ),
          new InkWell(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Text(
                  flag ? "show more" : "show less",
                  style: new TextStyle(color: Colors.white),
                ),
              ],
            ),
            onTap: () {
              setState(() {
                flag = !flag;
              });
            },
          ),
        ],
      ),
    );
  }

}