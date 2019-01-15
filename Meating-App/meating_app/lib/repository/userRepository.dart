import 'repository.dart';
import 'dart:async';
import 'package:meating_app/model/user.dart';
import 'package:firebase_database/firebase_database.dart';


class UserRepository extends Repository<User>{
  
  DatabaseReference userreference; 

  UserRepository() {
    this.userreference = FirebaseDatabase.instance.reference().child("user");
  }

  Future<User> save(var params){
    var completer = new Completer<User>();
    User user = new User(params["name"].toString(), 0.toInt());
    DatabaseReference userChildReference = userreference.push();
    user.key = userChildReference.key;
    userChildReference.set(user.toJson());
    completer.complete(user);
    return completer.future;
  }

  Future<List<User>> selectAll(){
    return userreference.once().then((dataSnapshot){
      List<User> userList = new List<User>(); 
      dataSnapshot.value.forEach((key,v){
        var name = v["name"];
        var score = v["score"];
        userList.add(new User.withKey(name, score, key));
      });
      userList.sort((a, b) => a.score.compareTo(b.score));
      userList = userList.reversed.toList();
      int top = userList.length < 10 ? userList.length - 1 : 9;
      userList.setRange(0, top, userList);
      return userList;
    });
  }

  Future<User> update(User user){
    var completer = new Completer<User>();
    completer.complete(user);
    userreference.child(user.key).set(user.toJson());
    return completer.future;
  }
}