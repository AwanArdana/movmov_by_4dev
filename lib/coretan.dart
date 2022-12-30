// import 'package:flutter/material.dart';
//
// class TextFieldContainer extends StatelessWidget{
//   final Size size;
//   final IconData icon;
//   final String hintText;
//
//
//   const TextFieldContainer({Key key, this.size, this.icon, this.hintText}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CoverWithTitle(
//             size: size,
//             title: "${list[0]['mov_title']}",
//             coverId: "${list[0]['mov_cover_id']}",
//             listGenre: listGenre,
//             mov_id: Mov_id,
//           ),
//
//           DetailWithReadMore(Detail: "${list[0]['mov_deskripsi']}",),
//
//           new FutureBuilder<List>(
//             // future: getEpisode(Mov_id),
//             // future: getDataGlobal("getmovepisode.php?id=", Mov_id),
//             future: SQLEksek("SELECT e.episode_id, e.episode from episode e WHERE e.mov_id=" + Mov_id),
//             builder: (context, snapshot){
//               if(snapshot.hasError) print(snapshot.error);
//
//               return snapshot.hasData
//                   ? new ListView.builder(
//                 scrollDirection: Axis.vertical,
//                 shrinkWrap: true,
//                 padding: const EdgeInsets.all(8),
//                 itemCount: snapshot.data.length,
//                 itemBuilder: (BuildContext context, int index){
//
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
//                                   builder: (context) => new PlayerScreen(Episode: "${snapshot.data[index]['episode_id']}", listEpisode: snapshot.data, listGenre: listGenre, mov_id: Mov_id,),
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
//                   : new Center(child: new CircularProgressIndicator(),);
//             },
//           )
//
//           // ListView.builder(
//           //   scrollDirection: Axis.vertical,
//           //   shrinkWrap: true,
//           //   padding: const EdgeInsets.all(8),
//           //   itemCount: list.length,
//           //   itemBuilder: (BuildContext context, int index){
//           //
//           //     return Container(
//           //       padding: const EdgeInsets.all(8),
//           //       height: 50,
//           //       color: kPrimaryColor,
//           //       child: Row(
//           //         children: [
//           //           Text(
//           //               'Episode ${list[index]['episode']}'
//           //           ),
//           //           Spacer(),
//           //
//           //           FlatButton(
//           //
//           //             shape: RoundedRectangleBorder(
//           //               borderRadius: BorderRadius.circular(20)
//           //             ),
//           //             color: kSecondaryColor,
//           //             onPressed: (){
//           //               Navigator.push(
//           //                   context,
//           //                   MaterialPageRoute(
//           //                     builder: (context) => PlayerScreen(Episode_id: "${list[index]['episode_id']}",),
//           //                   )
//           //               );
//           //             },
//           //             child: Text(
//           //               "Play",
//           //               style: TextStyle(color: Colors.white),
//           //             ),
//           //           )
//           //         ],
//           //       ),
//           //     );
//           //   },
//           // ),
//
//
//
//
//         ],
//       ),
//     );
//   }
//
//   String query = "SELECT * FROM akun where username ='"+controllerUsername.text+"' and password = '"+controllerPassword.text+"'";
//   final response = await http.get(Uri.parse(webserviceGetData + query));
//   List list = json.decode(response.body);
//   if (list.isNotEmpty){
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs?.setBool("isLoggedIn", true);
//   Holder.JenisAkun = list[0]["kodeJenisAkun"];
//   Holder.namaAkun = list[0]["username"];
//   new Future.delayed(new Duration(seconds: 1), (){
//   setState(() {
//   saving = false;
//   });
//   Navigator.push(
//   context,
//   MaterialPageRoute(
//   builder: (context) => HomeScreen()
//   )
//   );
//   });
//
//   }else{
//   Fluttertoast.showToast(
//   msg: "Username or Password not Correct",
//   toastLength: Toast.LENGTH_SHORT,
//   );
//
//   // Scaffold.of(context).showSnackBar(new SnackBar(
//   //   content: new Text("Username or Password not Correct"),
//   // ));
//   setState(() {
//   saving = false;
//   });
//
//   // Center(child: new CircularProgressIndicator(),);
//   }
//
// }