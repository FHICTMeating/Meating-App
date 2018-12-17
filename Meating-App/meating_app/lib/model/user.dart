import 'package:firebase_database/firebase_database.dart';

class User{
  String key;
  String name;

  User(this.name);

  User.fromSnapshot(DataSnapshot snapshot) 
  : key = snapshot.key,
    name = snapshot.value["name"];

  toJson(){
    return {
      "name": name
    };
  }

}