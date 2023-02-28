import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:movmov/Detail/component/titlewithdetail.dart';
import 'package:movmov/Favorite/component/BodyFavorite.dart';
import 'package:movmov/Player/player_screen.dart';
import 'package:movmov/constants.dart';
import 'package:movmov/fungsi_kirim_web_service.dart';


import '../../Ads/ad_helper.dart';
import 'DetailReadMore.dart';
import 'cover_with_title.dart';
import 'package:http/http.dart' as http;

class BodyDetail extends StatefulWidget{

  final List listMov;
  final String Mov_id;
  final int index;

  const BodyDetail({Key key, this.listMov, this.Mov_id, this.index}) : super(key: key);

  @override
  State<BodyDetail> createState() => _BodyDetailState();
}

class _BodyDetailState extends State<BodyDetail> {
  BannerAd _bannerAd;

  List listEpisode = [];
  bool datakosong = false;

  @override
  void initState() {
    super.initState();
    BannerAd(
        adUnitId: AdHelper.bannerAdUnitId,
        request: AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
            onAdLoaded: (ad){
              setState(() {
                _bannerAd = ad as BannerAd;
                print("banner okeeeeeeee");
              });
            },
            onAdFailedToLoad: (ad, err){
              print("Failed to load a banner ad: ${err.message}");
              ad.dispose();
            }
        )
    ).load();

    getEpisode();
  }

  Future<void> getEpisode() async {
    String query = "SELECT e.episode_id, e.episode from episode e WHERE e.mov_id='" + widget.Mov_id + "'";
    final response = await http.get(Uri.parse(webserviceGetData + query));

    setState(() {
      listEpisode = jsonDecode(response.body);
      if(listEpisode.isNotEmpty){
        datakosong = false;
      }else{
        datakosong = true;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    if(_bannerAd != null)
      _bannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int index = widget.index;
    return SingleChildScrollView(
      child: new Container(
        child: Column(
          children: [
            // Text("okke " + widget.listMov[index]['mov_title'])
            CoverWithTitle(
              size: size,
              rating: widget.listMov[index]['rating'],
              title: widget.listMov[index]['mov_title'],
              mov_id: widget.Mov_id,
              coverId: widget.listMov[index]['mov_cover_id'],
              genres: widget.listMov[index]['all_genres'],
              listEpisode: listEpisode,
            ),

            //Column(
            // //       crossAxisAlignment: CrossAxisAlignment.start,
            // //       children: <Widget>[
            // //         TitleWithDetail(title: "Detail",),
            // //
            // //         new ReadMore(Detail: Detail),
            // //
            // //
            // //       ],
            // //     );
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TitleWithDetail(title: "Detail",),

                new ReadMore(Detail: widget.listMov[index]['mov_deskripsi']),
              ],
            ),

            if(_bannerAd != null)
              Container(
                width: _bannerAd.size.width.toDouble(),
                height: _bannerAd.size.width.toDouble() * 0.3,
                child: AdWidget(ad: _bannerAd,),
              ),

            _ListEpisode(context),

            // new FutureBuilder(
            //   future: SQLEksek("SELECT e.episode_id, e.episode from episode e WHERE e.mov_id='" + widget.Mov_id + "'"),
            //   builder: (context, snapshot){
            //     if(snapshot.hasError) print(snapshot.error);
            //
            //     return snapshot.hasData
            //         ?
            //         :
            //
            //   },
            // )

            ////     return new FutureBuilder(
            // //       //list episode
            // //       future: SQLEksek("SELECT e.episode_id, e.episode from episode e WHERE e.mov_id=" + widget.Mov_id),
            // //       builder: (context, snapshot){
            // //         if (snapshot.hasError) print(snapshot.error);
            // //
            // //         return snapshot.hasData
            // //             ? new Container(


//               DetailWithReadMore(Detail: "${widget.list[0]['mov_deskripsi']}",),
//               //ads disini
//               if(_bannerAd != null)
//                 Container(
//                   width: _bannerAd.size.width.toDouble(),
//                   height: _bannerAd.size.width.toDouble() * 0.3,
//                   child: AdWidget(ad: _bannerAd,),
//                 ),


            // CoverWithTitle(
            //   size: size,
            // )
          ],
        ),
      ),
    );
  }

  Widget _ListEpisode(BuildContext context){
    if(datakosong){
      return Center(child: Text("No Data"),);
    }

    if(listEpisode.isNotEmpty){
      return new ListView.builder(
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
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                              (Set<MaterialState> states){
                            if(states.contains(MaterialState.pressed)) return kSecondaryColor.withOpacity(0.5);
                            return kSecondaryColor;
                          }
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )
                      )
                  ),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(20)
                  // ),
                  // color: kSecondaryColor,
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => new PlayerScreen(Episode: listEpisode[index]['episode'], listEpisode: listEpisode, mov_id: widget.Mov_id, rating: widget.listMov[index]['rating'], genres: widget.listMov[index]['all_genres'],),
                          // builder: (context) => new PlayerScreen(Episode: "${snapshot.data[index]['episode']}", listEpisode: snapshot.data, listGenre: widget.listGenre, mov_id: widget.Mov_id, rating: widget.list[0]['rating'],),
                        )
                    );
                  },
                  child: Text(
                    "Play",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          );
        },
      );
    }else{
      return new Center(child: new CircularProgressIndicator(),);
    }
  }

  Widget _CoverWithTitle(BuildContext context){
    // if(datakosong){
    //
    // }

    if(listEpisode.isNotEmpty){

    }
  }
}


// class DetailWithReadMore extends StatelessWidget{
//   const DetailWithReadMore({
//     Key key, this.Detail,
//   }) : super(key: key);
//
//   final String Detail;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         TitleWithDetail(title: "Detail",),
//
//         new ReadMore(Detail: Detail),
//
//
//       ],
//     );
//   }
//
// }

// class Detail extends StatefulWidget{
//
//   const Detail({
//     Key key, this.list, this.size, this.Mov_id, this.listGenre,
//   }): super(key: key);
//
//   final List list;
//   final List listGenre;
//   final Size size;
//   final String Mov_id;
//
//   // Future<List> getEpisode() async{
//   //   final response = await http.get(Uri.parse("https://awanapp.000webhostapp.com/getmovepisode.php?id=" + Mov_id));
//   //   return json.decode(response.body);
//   // }
//
//   // Future<InitializationStatus> _initGoogleMobileAds() {
//   //   return MobileAds.instance.initialize();
//   // }
//
//   // @override
//   // Widget build(BuildContext context) {
//   //
//   // }
//
//   @override
//   _Detail createState() => _Detail();
//
// }
//
// class _Detail extends State<Detail>{
//   // TODO: Add _bannerAd
//   BannerAd _bannerAd;
//
//   @override
//   void initState(){
//     BannerAd(
//         adUnitId: AdHelper.bannerAdUnitId,
//         request: AdRequest(),
//         size: AdSize.banner,
//         listener: BannerAdListener(
//             onAdLoaded: (ad){
//               setState(() {
//                 _bannerAd = ad as BannerAd;
//               });
//             },
//             onAdFailedToLoad: (ad, err){
//               print("Failed to load a banner ad: ${err.message}");
//               ad.dispose();
//             }
//         )
//     ).load();
//   }
//
//   @override
//   void dispose(){
//     // TODO: Dispose a BannerAd object
//     _bannerAd.dispose();
//
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new FutureBuilder(
//       //list episode
//       future: SQLEksek("SELECT e.episode_id, e.episode from episode e WHERE e.mov_id=" + widget.Mov_id),
//       builder: (context, snapshot){
//         if (snapshot.hasError) print(snapshot.error);
//
//         return snapshot.hasData
//             ? new Container(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               CoverWithTitle(
//                 size: widget.size,
//                 title: "${widget.list[0]['mov_title']}",
//                 coverId: "${widget.list[0]['mov_cover_id']}",
//                 listGenre: widget.listGenre,
//                 mov_id: widget.Mov_id,
//                 listEpisode: snapshot.data,
//                 rating: widget.list[0]['rating'],
//               ),
//
//               DetailWithReadMore(Detail: "${widget.list[0]['mov_deskripsi']}",),
//               //ads disini
//               if(_bannerAd != null)
//                 Container(
//                   width: _bannerAd.size.width.toDouble(),
//                   height: _bannerAd.size.width.toDouble() * 0.3,
//                   child: AdWidget(ad: _bannerAd,),
//                 ),
//
//               new ListView.builder(
//                 scrollDirection: Axis.vertical,
//                 shrinkWrap: true,
//                 padding: const EdgeInsets.all(8),
//                 itemCount: snapshot.data.length,
//                 itemBuilder: (BuildContext context, int index){
//                   return Container(
//                     padding: const EdgeInsets.all(8),
//                     height: 50,
//                     color: kPrimaryColor,
//                     child: Row(
//                       children: [
//                         Text(
//                             'Episode ${snapshot.data[index]['episode']}'
//                         ),
//                         Spacer(),
//
//                         TextButton(
//                           style: ButtonStyle(
//                               backgroundColor: MaterialStateProperty.resolveWith(
//                                       (Set<MaterialState> states){
//                                     if(states.contains(MaterialState.pressed)) return kSecondaryColor.withOpacity(0.5);
//                                     return kSecondaryColor;
//                                   }
//                               ),
//                               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                                   RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20),
//                                   )
//                               )
//                           ),
//                           // shape: RoundedRectangleBorder(
//                           //   borderRadius: BorderRadius.circular(20)
//                           // ),
//                           // color: kSecondaryColor,
//                           onPressed: (){
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => new PlayerScreen(Episode: "${snapshot.data[index]['episode']}", listEpisode: snapshot.data, listGenre: widget.listGenre, mov_id: widget.Mov_id, rating: widget.list[0]['rating'],),
//                                 )
//                             );
//                           },
//                           child: Text(
//                             "Play",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         )
//                       ],
//                     ),
//                   );
//                 },
//               )
//             ],
//           ),
//         )
//             : new Center(child: new CircularProgressIndicator(),);
//       },
//     );
//   }
//
// }
//
// class DetailWithReadMore extends StatelessWidget{
//   const DetailWithReadMore({
//     Key key, this.Detail,
//   }) : super(key: key);
//
//   final String Detail;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         TitleWithDetail(title: "Detail",),
//
//         new ReadMore(Detail: Detail),
//
//
//       ],
//     );
//   }
//
// }






