import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'ListScreen.dart';
import 'DogDao.dart';
import 'Dog.dart';

var dogDao = new DogDao();
var database;

void main() async {
  database = dogDao.openDb();
  runApp(MaterialApp(
    home: MyApp(),
  ));

}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  TextEditingController dogname = TextEditingController();
  TextEditingController DogAge = TextEditingController();
  TextEditingController DogId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dog App'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Insert Dog Data',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Add',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: dogname,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Dog Name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: DogId,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Dog Id',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: DogAge,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Dog Age',
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Add'),
                      onPressed: () {
                        onClickLogin(dogname.text,DogId.text,DogAge.text);
                      },
                    )),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Get List'),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>GetList(),
                        ));
                      },
                    )),
              ],
            )));
  }

  void onClickLogin(String name1, String id1, String age1) {
    int Myid = int.parse(id1);
    int Myage = int.parse(age1);
    var dog = Dog(id: Myid, name: name1, age: Myage);
    Future<int> res = dogDao.insertDog(dog);
    if(res!=-1){
      print("Failed");
    }
  }

}