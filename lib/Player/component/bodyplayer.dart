import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:movmov/Ads/ad_helper.dart';
import 'package:movmov/Player/player_screen.dart';
import 'package:movmov/constants.dart';
import 'package:movmov/fungsiUmum.dart';
import 'package:movmov/fungsi_kirim_web_service.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';

class BodyPlayer extends StatefulWidget{
  BodyPlayer({Key key, this.list, this.listEpisode, this.ep, this.mov_id, this.ep_id, this.rating, this.genres}):super(key: key);

  final List list;
  final String ep;
  final List listEpisode;
  final String genres;
  final String mov_id;
  final String ep_id;
  final String rating;

  // Future<List> getGenres() async{
  //   final response = await http.get(Uri.parse("https://awanapp.000webhostapp.com/getmovgenre.php?id=" + ep_id));
  //   return json.decode(response.body);
  // }
  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  @override
  _BodyPlayer createState() => _BodyPlayer();


}

class _BodyPlayer extends State<BodyPlayer>{
  InAppWebViewGroupOptions _options = InAppWebViewGroupOptions(
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      )
  );
  InAppWebViewController webView;

  String Url = "https://drive.google.com/file/d/18bcKYHpxizSFvdwT4fBlSG_PNridmpnc/preview";
  // String Url = list[0]["mov_cloud_link"];
  bool status = true;

  BannerAd _bannerAd;

  var split;
  List splitgenre = [];

  cekEpisodeSekarang(int index, String episode){
    String ep1 = widget.listEpisode[index]['episode'];
    String stxt = "Play";
    if(episode == ep1){
      stxt = "Now Playing";
    }
    Text txt = Text(stxt, style: TextStyle(color: Colors.white),);
    return txt;
  }

  @override
  void initState(){

    split = widget.genres.split(",");
    splitgenre = widget.genres.split(",");

    BannerAd(
        adUnitId: AdHelper.bannerAdUnitId,
        request: AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
            onAdLoaded: (ad){
              setState(() {
                _bannerAd = ad as BannerAd;
              });
            },
            onAdFailedToLoad: (ad, err){
              print("Failed to load a banner ad: ${err.message}");
              ad.dispose();
            }
        )
    ).load();
  }

  @override
  void dispose(){
    // TODO: Dispose a BannerAd object
    _bannerAd.dispose();

    super.dispose();
  }

  Future<void> SaveHistory() async {
    try{
      //  movID/episode/akun 000001/0001/00001
      String historyID = makeNewCode(widget.mov_id, 6) + "/" + makeNewCode(widget.ep_id, 4) + "/" + makeNewCode(Holder.id_akun, 5);
      var now = new DateTime.now();
      var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
      String formattedDate = formatter.format(now);

      String qSelect = "SELECT * FROM history WHERE history_id = '"+historyID+"'";
      final response = await http.get(Uri.parse(webserviceGetData + qSelect));
      List list = json.decode(response.body);
      if(list.isNotEmpty){
        String qUpdateHistory = "UPDATE history SET tglNonton = '"+formattedDate+"' WHERE history_id = '"+historyID+"'";
        print(qUpdateHistory);
        SQLEksekInsert(qUpdateHistory);
      }else{
        String qInsertHistory = "INSERT INTO history (history_id, mov_id, episode_id, akun_id, tglNonton) "
            "VALUES ('"+historyID+"','"+widget.mov_id+"','"+widget.ep_id+"', '"+Holder.id_akun+"', '"+formattedDate+"')";
        print(qInsertHistory);
        SQLEksekInsert(qInsertHistory);
      }

      // String qWatchTime = "UPDATE movie SET watch_time = watch_time + 1 WHERE mov_id = " . $mov_id . "";
      String qWatchTime = "UPDATE movie SET watch_time = watch_time + 1 WHERE mov_id ='" + widget.mov_id + "'";
      SQLEksekInsert(qWatchTime);


    }on Exception catch(e){
      print("" + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          HeaderPlayer(
            size: size,
            title: "${widget.list[0]["mov_title"]}",
            episode: "${widget.list[0]["episode"]}",
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
            child: Column(
              children: [
                Expanded(
                  child: InAppWebView(
                    initialUrlRequest: URLRequest(
                      // url: Uri.parse(Url)
                      // url: Uri.parse("https://drive.google.com/file/d/"+"${list[0]["mov_cloud_link"]}"+"/preview")
                        url: Uri.parse("https://mega.nz/embed/"+ "${widget.list[0]["mov_cloud_link"]}")
                    ),
                    initialOptions: _options,

                    onWebViewCreated: (InAppWebViewController controller){
                      webView = controller;
                    },
                    onLoadStart: (InAppWebViewController controller, Url){
                      status = false;
                      print("mainkan");
                      if(Holder.JenisAkun != "2"){
                        SaveHistory();
                      }
                    },
                    onLoadStop: (InAppWebViewController controller, Url){
                      status = true;
                    },
                    onEnterFullscreen: (controller) async {
                      print("miring");
                      // DeviceOrientation.landscapeRight;
                      // await SystemChrome.setPreferredOrientations([
                      // DeviceOrientation.landscapeRight
                      // ]);
                      await SystemChrome.setPreferredOrientations([
                        DeviceOrientation.landscapeRight,
                        DeviceOrientation.landscapeLeft,
                      ]);
                    },
                    // onEnterFullscreen: (InAppWebViewController controller){
                    //   webView = controller;
                    //   print("Miring");
                    //   DeviceOrientation.landscapeRight;
                    // },
                    // onEnterFullscreen: (webV){
                    //   DeviceOrientation.landscapeRight;
                    // },
                  ),
                ),
              ],
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
                    "${widget.list[0]["mov_title"]}",
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
                      widget.rating
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: kDefaultPadding * 0.5),
                  child: Row(
                    children: [
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
                          // "${widget.listGenre[0]['gen_title']}"
                            splitgenre[0].toString()
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
                          // "${widget.listGenre[0]['gen_title']}"
                            splitgenre[1].toString()
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
                          // "${widget.listGenre[0]['gen_title']}"
                            splitgenre[2].toString()
                        ),
                      ),
                    ],
                  ),
                )

                // Container(
                //   // alignment: Alignment.centerLeft,
                //   margin: new EdgeInsets.only(top: kDefaultPadding * 0.5),
                //   child: Row(
                //     children: <Widget>[
                //       // Text(widget.genres)
                //       new ListView.builder(
                //         scrollDirection: Axis.horizontal,
                //         shrinkWrap: true,
                //         primary: false,
                //         itemCount: splitgenre.length,
                //         itemBuilder: (BuildContext context, int index){
                //           return Container(
                //             margin: new EdgeInsets.only(right: kDefaultPadding * 0.2),
                //             padding: new EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.2),
                //             decoration: BoxDecoration(
                //                 color: kSecondaryColor,
                //                 borderRadius: BorderRadius.circular(5),
                //                 border: Border.all(
                //                   color: Colors.white,
                //                   width: 1,
                //                 )
                //             ),
                //             child: Text(
                //               // "${widget.listGenre[0]['gen_title']}"
                //                 splitgenre[index].toString()
                //             ),
                //           );
                //         },
                //       )
                //       // Container(
                //       //   margin: new EdgeInsets.only(right: kDefaultPadding * 0.2),
                //       //   padding: new EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.2),
                //       //   decoration: BoxDecoration(
                //       //       color: kSecondaryColor,
                //       //       borderRadius: BorderRadius.circular(5),
                //       //       border: Border.all(
                //       //         color: Colors.white,
                //       //         width: 1,
                //       //       )
                //       //   ),
                //       //   child: Text(
                //       //       // "${widget.listGenre[0]['gen_title']}"
                //       //     split[0].toString()
                //       //   ),
                //       // ),
                //       // Container(
                //       //   margin: new EdgeInsets.only(right: kDefaultPadding * 0.2),
                //       //   padding: new EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.2),
                //       //   decoration: BoxDecoration(
                //       //       color: kSecondaryColor,
                //       //       borderRadius: BorderRadius.circular(5),
                //       //       border: Border.all(
                //       //         color: Colors.white,
                //       //         width: 1,
                //       //       )
                //       //   ),
                //       //   child: Text(
                //       //       "${widget.listGenre[1]['gen_title']}"
                //       //   ),
                //       // ),
                //       // Container(
                //       //   margin: new EdgeInsets.only(right: kDefaultPadding * 0.2),
                //       //   padding: new EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.2),
                //       //   decoration: BoxDecoration(
                //       //       color: kSecondaryColor,
                //       //       borderRadius: BorderRadius.circular(5),
                //       //       border: Border.all(
                //       //         color: Colors.white,
                //       //         width: 1,
                //       //       )
                //       //   ),
                //       //   child: Text(
                //       //       "${widget.listGenre[2]['gen_title']}"
                //       //   ),
                //       // ),
                //
                //     ],
                //   ),
                // )
              ],
            ),
          ),

          new ReadMoreDetail(Detail: "${widget.list[0]["mov_deskripsi"]}",),

          //ads disini
          if(_bannerAd != null)
            Container(
              width: _bannerAd.size.width.toDouble(),
              height: _bannerAd.size.width.toDouble() * 0.3,
              child: AdWidget(ad: _bannerAd,),
            ),

          new Container(
            child: new ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: widget.listEpisode.length,
              itemBuilder: (BuildContext context, int index){
                return Container(
                  padding: const EdgeInsets.all(8),
                  height: 50,
                  color: kPrimaryColor,
                  child: Row(
                    children: [
                      Text(
                          'Episode ${widget.listEpisode[index]['episode']}'
                      ),

                      Spacer(),

                      TextButton(
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(20)
                        // ),
                        // color: kSecondaryColor,
                          onPressed: (){
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => PlayerScreen(Episode: widget.listEpisode[index]['episode'], listEpisode: widget.listEpisode, genres: widget.genres, mov_id: widget.mov_id, rating: widget.rating,))
                            );
                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PlayerScreen(Episode: "${widget.listEpisode[index]['episode']}", listEpisode: widget.listEpisode, listGenre: widget.listGenre, mov_id: widget.mov_id, rating: widget.rating,)));
                          },
                          child: cekEpisodeSekarang(index,"${widget.list[0]["episode"]}")
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