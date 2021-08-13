import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'Dog.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), 'dogdb'),
    version: 1,
    onCreate: (db,version){
      String sql = 'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)';
      db.execute(sql);
    }
  );

  Future<void>  insertDog(Dog  dog) async{
    final db = await database;
   int position = await db.insert('dogs', dog.toMap(),
      nullColumnHack: null,
      conflictAlgorithm: ConflictAlgorithm.replace
    );

   print('inserted.dog');
  }



  Future<List<Dog>> getDogs() async {

    final db = await database;
    List<Map<String, dynamic>> mapRows  =  await db.query('dogs');
   return List.generate(mapRows.length, (rowPosition){
      var dog= Dog(
        id: mapRows[rowPosition]['id'],
        name: mapRows[rowPosition]['name'],
        age: mapRows[rowPosition]['age']
      );

      print(dog.toString());
      return dog;
    });
  }



  void deleteDog(int id) async{
    final db = await database;
    db.delete('dogs',
    where: 'id = ?',   whereArgs: [id]);
  }


  Future<int> updateDog(Dog dog)  async {
    final db = await database;
    int noDogRowsAffect = await db.update('dogs', dog.toMap(),
    where: 'id =?',
    whereArgs: [dog.id] );
    return noDogRowsAffect;
  }


  var pomerian = Dog(
      id: 0, name: 'pomerian puppy', age: 2);


  insertDog(pomerian);



}