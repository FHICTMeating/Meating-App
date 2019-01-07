import 'package:firebase_database/firebase_database.dart';

class Question{
  String key;
  String question;
  double awnser;

  Question(this.question, this.awnser);

  Question.withKey(this.question, this.awnser, this.key);

  Question.fromSnapshot(DataSnapshot snapshot) 
  : key = snapshot.key,
    question = snapshot.value["question"],
    awnser = snapshot.value["awnser"];

  toJson(){
    return {
      "question": question,
      "awnser": awnser,
    };
  }

}