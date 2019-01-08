import 'repository.dart';
import 'package:meating_app/model/user.dart';
import 'package:firebase_database/firebase_database.dart';


class UserRepository extends Repository<User>{
  
  FirebaseDatabase database;
  DatabaseReference userreference; 

  UserRepository() : super();

  Future init(){
    return super.init().then((app){
      this.database = FirebaseDatabase(app:app);
      this.userreference = this.database.reference().child("user");
    });
  }

  Future<User> save(var params){
    User user = new User(params["name"], 0);
    return userreference.push().set(user.toJson());
  }

  Future<List<User>> selectAll(){
    return userreference.once().then((dataSnapshot){
      List<User> userList = new List<User>();
      dataSnapshot.value.forEach((key,v){
        var name = v["name"];
        var score = v["score"];
        userList.add(new User.withKey(name, score, key));
      });
      return userList;
    });
  }

  Future<User> update(User user){
    return userreference.child(user.key).set(user);
  }
}