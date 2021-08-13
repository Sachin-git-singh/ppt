import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'Dog.dart';
import 'DogDao.dart';


var dogDao = new DogDao();
var database;
void main(){
  database = dogDao.openDb();
  runApp(new GetList());
}

class GetList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "List in Flutter",
      home: new Scaffold(
        appBar: new AppBar(
          title: Text("List Of Dogs"),
        ),
        body: RandomFruits(),
      ),
    );
  }
}
class RandomFruits extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RandomFruitsState();
  }
}
class RandomFruitsState extends State<RandomFruits>  {
  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold (
        body: FutureBuilder<List>(
          future: dogDao.getDogs(),
          initialData: [],
          builder: (context, snapshot) {
            return snapshot.hasData ?
            new ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, i) {
                return _buildRow(snapshot.data![i]);
              },
            )
                : Center(
              child: CircularProgressIndicator(),
            );
          },
        )
    );
  }
  Widget _buildRow(Dog fruit) {
    return new ListTile(
      title : new Text(fruit.name  + "                    " + fruit.id
          .toString() + "                    " + fruit.age.toString(), style: _biggerFont),

      //: new Text(fruit.age.toString()  , style: _biggerFont),
      // horizontalTitleGap: 20.0,
      // subtitle : new Text(fruit.name  , style: _biggerFont),
      // horizontalTitleGap: 20.0,
      // subtitle : new Text(fruit.age  , style: _biggerFont),
    );
  }
}