import 'package:flutter/material.dart';

class InputEpisode extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Input Episode'),
      ),
      body: BodyIndutEpisode(),
    );
  }

}

class BodyIndutEpisode extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("yessss"),
    );
  }

}