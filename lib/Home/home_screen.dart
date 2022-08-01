import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'component/body.dart';
import 'component/NavDrawer.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      // appBar: buildAppBar(),
      appBar: AppBar(
        elevation: 0,
        title: Text(''),
      ),
      body: Body(),
    );
  }

  AppBar buildAppBar(){
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon:new SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: (){},
      ),
    );
  }
}

// class _HomeState extends State<Home> {
//   Future<List> getData() async {
//     final response = await http.get(Uri.parse("https://awanapp.000webhostapp.com/getmovdata.php"));
//     return json.decode(response.body);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text("MOV MOV"),
//       ),
//       floatingActionButton: new FloatingActionButton(
//         child: new Icon(Icons.add),
//         onPressed: ()=>Navigator.of(context).push(
//             new MaterialPageRoute(
//               builder: (BuildContext context)=> new AddData(),
//             )
//         ),
//       ),
//       body: new FutureBuilder<List>(
//         future: getData(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) print(snapshot.error);
//
//           return snapshot.hasData
//               ? new ItemList(
//             list: snapshot.data,
//           )
//               : new Center(
//             child: new CircularProgressIndicator(),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class ItemList extends StatelessWidget {
//   final List list;
//   ItemList({this.list});
//
//   @override
//   Widget build(BuildContext context) {
//     return new ListView.builder(
//       itemCount: list == null ? 0 : list.length,
//       itemBuilder: (context, i) {
//         return new Container(
//           padding: const EdgeInsets.all(10.0),
//           child: new GestureDetector(
//             onTap: ()=>Navigator.of(context).push(
//                 new MaterialPageRoute(
//                     builder: (BuildContext context)=> new Detail(list:list , index: i,)
//                 )
//             ),
//             child: new Card(
//
//               child: new ListTile(
//                 title: new Text(list[i]['mov_title']),
//                 leading: new Image.network("https://drive.google.com/uc?export=view&id=10LnmkYfOvvpyXEt7YAEt9Gmmpw5OKJRH"),
//                 subtitle: new Text("Year : ${list[i]['mov_year']}"),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }