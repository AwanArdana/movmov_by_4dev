import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movmov/Player/player_screen.dart';
import 'package:movmov/constants.dart';

import '../../constants.dart';

class BodyPlayer extends StatelessWidget{
  BodyPlayer({Key key, this.list, this.listEpisode, this.ep_id, this.listGenre}):super(key: key);

  final List list;
  final String ep_id;
  final List listEpisode;
  final List listGenre;

  // Future<List> getGenres() async{
  //   final response = await http.get(Uri.parse("https://awanapp.000webhostapp.com/getmovgenre.php?id=" + ep_id));
  //   return json.decode(response.body);
  // }



  InAppWebViewGroupOptions _options = InAppWebViewGroupOptions(
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    )
  );
  InAppWebViewController webView;

  String Url = "https://drive.google.com/file/d/18bcKYHpxizSFvdwT4fBlSG_PNridmpnc/preview";
  // String Url = list[0]["mov_cloud_link"];
  bool status = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          HeaderPlayer(
            size: size,
            title: "${list[0]["mov_title"]}",
            episode: "${list[0]["episode"]}",
          ),

          Container(
            height: size.height * 0.3,
            decoration: BoxDecoration(
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 20),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.33),
                  )
                ]
            ),
            child: Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                    // url: Uri.parse(Url)
                  url: Uri.parse("https://drive.google.com/file/d/"+"${list[0]["mov_cloud_link"]}"+"/preview")
                ),
                initialOptions: _options,
                onWebViewCreated: (InAppWebViewController controller){
                  webView = controller;
                },
                onLoadStart: (InAppWebViewController controller, Url){
                  status = false;
                },
                onLoadStop: (InAppWebViewController controller, Url){
                  status = true;
                },
              ),
            ),
          ),

          Container(

            width: size.width,
            padding: new EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding),
            decoration: BoxDecoration(
              // color: Colors.green,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${list[0]["mov_title"]}",
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "4,5"
                  ),
                ),
                Container(
                  // alignment: Alignment.centerLeft,
                  margin: new EdgeInsets.only(top: kDefaultPadding * 0.5),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: new EdgeInsets.only(right: kDefaultPadding * 0.2),
                        padding: new EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.2),
                        decoration: BoxDecoration(
                          color: kSecondaryColor,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          )
                        ),
                        child: Text(
                            "${listGenre[0]['gen_title']}"
                        ),
                      ),
                      Container(
                        margin: new EdgeInsets.only(right: kDefaultPadding * 0.2),
                        padding: new EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.2),
                        decoration: BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.white,
                              width: 1,
                            )
                        ),
                        child: Text(
                            "${listGenre[1]['gen_title']}"
                        ),
                      ),
                      Container(
                        margin: new EdgeInsets.only(right: kDefaultPadding * 0.2),
                        padding: new EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.2),
                        decoration: BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.white,
                              width: 1,
                            )
                        ),
                        child: Text(
                            "${listGenre[2]['gen_title']}"
                        ),
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),

          new ReadMoreDetail(Detail: "${list[0]["mov_deskripsi"]}",),

          new Container(
            child: new ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: listEpisode.length,
              itemBuilder: (BuildContext context, int index){
                return Container(
                  padding: const EdgeInsets.all(8),
                  height: 50,
                  color: kPrimaryColor,
                  child: Row(
                    children: [
                      Text(
                        'Episode ${listEpisode[index]['episode']}'
                      ),

                      Spacer(),

                      TextButton(
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(20)
                        // ),
                        // color: kSecondaryColor,
                        onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PlayerScreen(Episode_id: "${listEpisode[index]['episode_id']}", listEpisode: listEpisode, listGenre: listGenre,)));
                        },
                        child: cekEpisodeSekarang(index,"${list[0]["episode"]}")
                        // child: Text(
                        //   "Play",
                        //   style: TextStyle(color: Colors.white),
                        // ),
                      )
                    ],
                  ),
                );
              },
            ),
          )


        ],
      ),
    );
  }

  cekEpisodeSekarang(int index, String episode){
    String ep1 = listEpisode[index]['episode'];
    String stxt = "Play";
    if(episode == ep1){
      stxt = "Now Playing";
    }
    Text txt = Text(stxt, style: TextStyle(color: Colors.white),);
    return txt;
  }

}

class ReadMoreDetail extends StatefulWidget{
  ReadMoreDetail({@required this.Detail});

  final String Detail;

  @override
  _DataReadMore createState() => new _DataReadMore();
}

class _DataReadMore extends State<ReadMoreDetail>{
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
      padding: new EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding),
      child: secondHalf.isEmpty
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
            onTap: (){
              setState(() {
                flag = !flag;
              });
            },
          )
        ],
      ),
    );
  }

}


class HeaderPlayer extends StatelessWidget{
  const HeaderPlayer({
    Key key, this.size, this.title, this.episode
  }):super(key: key);

  final Size size;
  final String title, episode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: kDefaultPadding+10,
      ),
      height: size.height * 0.1,
      decoration: BoxDecoration(
        color: kPrimaryColor,
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/back_arrow.svg",
              color: Colors.white,
            ),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          Text(
            title + " " + episode,
            style: Theme.of(context).textTheme.headline6.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold
            ),
          )
        ],
      ),
    );
  }
}