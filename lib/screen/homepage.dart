// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/screen/loginpage.dart';
import 'package:firebase_practice/widgets/textfieldwidget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userId = "users/id";
  final Stream<QuerySnapshot> usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  TextEditingController emailAddress =TextEditingController();
   TextEditingController password =TextEditingController();
   TextEditingController name =TextEditingController();
   TextEditingController userName =TextEditingController();
Future<void> addTask(String userId) async {
  final userDocRef = FirebaseFirestore.instance.collection("user").doc(userId);
  final userDocSnapshot = await userDocRef.get();

  if (userDocSnapshot.exists) {
    // The user document exists, so you can add a task to it.
    final tasksCollection = userDocRef.collection("tasks");
    final taskData = {
      "name": "name.text",
      "password": "password.text",
      "userName": "userName.text",
      "emailAddress": "emailAddress.text",
    };

    tasksCollection.add(taskData).then((value) {
      print("Task added for user: $userId");
    }).catchError((error) {
      print("Error adding task: $error");
    });
  } else {
    print("User document with ID $userId does not exist.");
  }
}

void updateUsernameAndPass(DocumentSnapshot doc) {
  final nameController = TextEditingController(text: doc['name']);
  final emailAddressController = TextEditingController(text: doc['emailAddress']);
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Update"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text("Name:"),
                Expanded(child: CustomTextField(textFieldController: nameController)),
              ],
            ),
            Row(
              children: [
                const Text("Email:"),
                Expanded(child: CustomTextField(textFieldController: emailAddressController)),
              ],
            )
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              // Update the document in Firestore
              FirebaseFirestore.instance.collection('users').doc(doc.id).update({
                'name': nameController.text,
                'emailAddress': emailAddressController.text,
                // Update other fields as well
              }).then((value) {
                print("Document updated");
                Navigator.pop(context); // Close the dialog
              }).catchError((error) {
                print("Error updating document: $error");
              });
              setState(() {});
            },
            child: const Text("Update"),
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              // Implement your image pick logic here
            },
            child: const Text("Pick Image"),
          ),
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: const Text("Sign out"),
          ),
          StreamBuilder(
            stream: usersStream,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot doc = snapshot.data!.docs[index];
                      return ListTile(
                        title: Text(doc['name']),
                        subtitle: Text(doc['emailAddress']),
                      trailing:  Row(
                       mainAxisSize: MainAxisSize.min,
                        children: [
                           IconButton(onPressed: (){
                            name.text=doc['name'];
                             emailAddress.text=doc['emailAddress'];
                          updateUsernameAndPass(doc);
                           }, icon: const Icon(Icons.edit)),
                          IconButton(onPressed: (){
                             FirebaseFirestore.instance.collection('users').doc(doc.id).delete().then((value) => ScaffoldMessenger.of(context).showSnackBar(
   SnackBar(
    content: Text("${doc['name']} deleted Successfully"),
    duration: const Duration(seconds: 2), // Adjust the duration as needed
  ),
));
                          }, icon: const Icon(Icons.delete)),
                          
                        ],
                      ),
                      );
                    },
                  ),
                );
              } else {
                return const Text("No data available");
              }
            },
          ),
          FloatingActionButton(onPressed: (){
            addTask(userId);
          }, child: const Icon(Icons.add),)
        ],
      ),
    );
  }
}
