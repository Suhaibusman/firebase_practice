import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/screen/loginpage.dart';
import 'package:firebase_practice/widgets/textfieldwidget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  TextEditingController emailAddress =TextEditingController();
   TextEditingController password =TextEditingController();
   TextEditingController name =TextEditingController();
   TextEditingController userName =TextEditingController();
void addUsers(){
    FirebaseFirestore.instance.collection("users").add(
      {
        "name" : "name.text",
        "password" : "password.text",
    "userName" : "userName.text",
    "emailAddress" : "emailAddress.text"
      }
    ).then((value) => print("Added")).onError((error, stackTrace) => print("error"));
  }

void updateUsernameAndPass(DocumentSnapshot doc){
 final nameController = TextEditingController(text: doc['name']);
      final emailAddressController = TextEditingController(text: doc['emailAddress']);
showDialog(context: context, builder: (context) {
  return AlertDialog(
    title: Text("Update"),
    content : Column(
      mainAxisSize: MainAxisSize.min,
      children: [
          Row(
  children: [
    const Text("Name:") ,
    Expanded(child: CustomTextField(textFieldController: name , )),
  ],
),
Row(
  children: [
    const Text("Email:") ,
    Expanded(child: CustomTextField(textFieldController: emailAddress ,)),
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
  },
  child: const Text("Update"),
)

    ],

  );
},);


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
                          IconButton(onPressed: (){}, icon: const Icon(Icons.delete)),
                          
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
            addUsers();
          }, child: const Icon(Icons.add),)
        ],
      ),
    );
  }
}
