import 'repository.dart';
import 'package:meating_app/model/question.dart';
import 'package:firebase_database/firebase_database.dart';

class QuestionRepository extends Repository<Question>{
  
  DatabaseReference questionreference; 

  QuestionRepository(){
    this.questionreference = FirebaseDatabase.instance.reference().child("question");
  }

  Future<Question> save(var params){
    Question question = new Question(params["question"], params["awnser"]);
    return questionreference.push().set(question.toJson());
  }

  Future<List<Question>> selectAll(){
    return questionreference.once().then((dataSnapshot){
      List<Question> questionList = new List<Question>();
      dataSnapshot.value.forEach((key,v){
        var answer = (v["answer"]/1);
        var question = v["question"];
        questionList.add(new Question.withKey(question, answer, key));
      });
      return questionList;
    });
  }

  Future<Question> update(Question question){
    return questionreference.child(question.key).set(question);
  }
}