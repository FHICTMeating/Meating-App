import 'dart:io' show Platform;
import 'package:firebase_core/firebase_core.dart';

abstract class Repository<T> {
  FirebaseApp app;
  
  var kaas;
  Repository(){
    this.kaas = "kaas";
  }

  Future init() async{
   return FirebaseApp.configure(
      name: 'db2',
      options: Platform.isIOS
          ? const FirebaseOptions(
              googleAppID: '1:182815347842:ios:a0030deccf728cb7',
              databaseURL: 'https://meating-app-48b2e.firebaseio.com',
              gcmSenderID: '182815347842',
            )
          : const FirebaseOptions(
              googleAppID: '1:182815347842:android:a0030deccf728cb7',
              apiKey: 'AIzaSyCOWCfxNLpKHWjdBH0fB3WdfQ7Bb33pTjQ',
              databaseURL: 'https://meating-app-48b2e.firebaseio.com',
            ),
    );
  } 

  Future<T> save(var params);
  Future<List<T>> selectAll();
  Future<T> update(T object);
}