import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movmov/Admin/component/InputEpisode.dart';
import 'package:movmov/Favorite/favorite_screen.dart';
import 'package:movmov/History/history_screen.dart';
import 'package:movmov/Setting/SettingScreen.dart';
import 'package:movmov/constants.dart';
import 'component/body.dart';
import 'component/NavDrawer.dart';

class HomeScreen extends StatefulWidget{

  AppBar buildAppBar(){
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon:new SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: (){},
      ),
    );
  }

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen>{

  //BottomNavigationBar
  int _selectedIndex = 0;
  PageController controllerPage = PageController();

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
    controllerPage.jumpToPage(index);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // drawer: NavDrawer(),
      // appBar: buildAppBar(),
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        title: Text(''),
        // automaticallyImplyLeading: false,
        automaticallyImplyLeading: false,
      ),
      // body: Body(),
      body: PageView(
        scrollDirection: Axis.horizontal,

        controller: controllerPage,
        children: <Widget>[
          Body(),
          FavoriteScreen(),
          HistoryScreen(),
          SettingScreen(),
        ],
        onPageChanged: (page){
          setState(() {
            _selectedIndex = page;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting'
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kSecondaryColor,
        unselectedItemColor: Colors.white,
        selectedIconTheme: IconThemeData(color: kSecondaryColor),
        onTap: _onItemTapped,
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