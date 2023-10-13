
// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseFunction {
  late  String email; 
   late  String password;
    late  String name;
     late  String address;

FireBaseFunction(this.email, this.password, this.name, this.address, 

);
toJson(){

  return {
    "email": email,
    "password": password,
    "name": name,
    "address":address
  };
}
 CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
            'emailAddress': email, // John Doe
            'password': password, // Stokes and Sons
          "name": name,
    "address":address
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
}
