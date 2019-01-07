import 'package:firebase_database/firebase_database.dart';

class User{
  String key;
  int score;
  String name;

  User(this.name, this.score);

  User.withKey(this.name, this.score, this.key);

  User.fromSnapshot(DataSnapshot snapshot) 
  : key = snapshot.key,
    name = snapshot.value["name"],
    score = snapshot.value["score"];

  toJson(){
    return {
      "name": name,
      "score": score
    };
  }

}