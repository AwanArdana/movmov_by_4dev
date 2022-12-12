import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:movmov/Detail/component/titlewithdetail.dart';
import 'package:movmov/Player/player_screen.dart';
import 'package:movmov/constants.dart';
import 'package:movmov/fungsi_kirim_web_service.dart';


import '../../Ads/ad_helper.dart';
import 'DetailReadMore.dart';
import 'cover_with_title.dart';

class BodyDetail extends StatelessWidget{
  BodyDetail({Key key, this.list, this.Mov_id}) : super(key: key);

  final List list;
  final String Mov_id;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // HeaderDetail(size: size),
            new FutureBuilder<List>(
              //list genres
              future: SQLEksek("SELECT gen_title FROM genres g, movie_genres mg WHERE g.gen_id=mg.gen_id and mg.mov_id=" + Mov_id),
              builder: (context, snapshot){
                if(snapshot.hasError) print(snapshot.error);

                return snapshot.hasData
                    ? new Detail(list: list, size: size, Mov_id: Mov_id, listGenre: snapshot.data,)
                    :  new Center(child: new CircularProgressIndicator(),);
                    // : Detail(list: list, size: size, Mov_id: Mov_id,listGenre: [],);
              },
            ),

          ],
        ),
      ),
    );
  }

}

class Detail extends StatefulWidget{

  const Detail({
    Key key, this.list, this.size, this.Mov_id, this.listGenre,
  }): super(key: key);

  final List list;
  final List listGenre;
  final Size size;
  final String Mov_id;

  // Future<List> getEpisode() async{
  //   final response = await http.get(Uri.parse("https://awanapp.000webhostapp.com/getmovepisode.php?id=" + Mov_id));
  //   return json.decode(response.body);
  // }

  // Future<InitializationStatus> _initGoogleMobileAds() {
  //   return MobileAds.instance.initialize();
  // }

  // @override
  // Widget build(BuildContext context) {
  //
  // }

  @override
  _Detail createState() => _Detail();

}

class _Detail extends State<Detail>{
  // TODO: Add _bannerAd
  BannerAd _bannerAd;

  @override
  void initState(){
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

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      //list episode
      future: SQLEksek("SELECT e.episode_id, e.episode from episode e WHERE e.mov_id=" + widget.Mov_id),
      builder: (context, snapshot){
        if (snapshot.hasError) print(snapshot.error);

        return snapshot.hasData
            ? new Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CoverWithTitle(
                size: widget.size,
                title: "${widget.list[0]['mov_title']}",
                coverId: "${widget.list[0]['mov_cover_id']}",
                listGenre: widget.listGenre,
                mov_id: widget.Mov_id,
                listEpisode: snapshot.data,
                rating: widget.list[0]['rating'],
              ),

              DetailWithReadMore(Detail: "${widget.list[0]['mov_deskripsi']}",),
              //ads disini
              if(_bannerAd != null)
                Container(
                  width: _bannerAd.size.width.toDouble(),
                  height: _bannerAd.size.width.toDouble() * 0.3,
                  child: AdWidget(ad: _bannerAd,),
                ),

              new ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    padding: const EdgeInsets.all(8),
                    height: 50,
                    color: kPrimaryColor,
                    child: Row(
                      children: [
                        Text(
                            'Episode ${snapshot.data[index]['episode']}'
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
                                  builder: (context) => new PlayerScreen(Episode: "${snapshot.data[index]['episode']}", listEpisode: snapshot.data, listGenre: widget.listGenre, mov_id: widget.Mov_id, rating: widget.list[0]['rating'],),
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
              )
            ],
          ),
        )
            : new Center(child: new CircularProgressIndicator(),);
      },
    );
  }

}

class DetailWithReadMore extends StatelessWidget{
  const DetailWithReadMore({
    Key key, this.Detail,
  }) : super(key: key);

  final String Detail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleWithDetail(title: "Detail",),

        new ReadMore(Detail: Detail),


      ],
    );
  }

}






