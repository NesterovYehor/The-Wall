
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('Users');
  final CollectionReference postCollection = FirebaseFirestore.instance.collection('User Posts');


  Stream<DocumentSnapshot> getUserData() {
    return userCollection.doc(currentUser!.email).snapshots();
  }

  Future<void> editField (String field, BuildContext context) async{
    String newValue = "";
     
    await showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: Colors.grey[900],
      title: Text("Edit " + field, style: TextStyle(color: Colors.white),),
      content: TextField(
        autocorrect: true,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: "Enter new $field",
          hintStyle: TextStyle(color: Colors.grey)
        ),
        onChanged: (value) {
          newValue = value;
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: Text("Cancel", style: TextStyle(color: Colors.white),)
          ),
          TextButton(
          onPressed: () => Navigator.of(context).pop(newValue), 
          child: Text("Save", style: TextStyle(color: Colors.white),)
          ),
      ],
    )
    );

    if (newValue.isNotEmpty){
      await userCollection.doc(currentUser!.email).update({field: newValue});
    }
  }
}




// Stream<UserModel> getUserData() {
//     return FirebaseFirestore.instance
//         .collection('Users')
//         .doc(currentUser!.email)
//         .snapshots()
//         .map((docSnapshot) {
//           if (docSnapshot.exists) {
//             final data = docSnapshot.data() as Map<String, dynamic>;
//             return UserModel.fromFirestore(data);
//           } else {
//             return UserModel(userEmail: "Unkown", userName: "Unkown");
//           }
//         });
//   }

 // Stream<UserModel> getUserData() { // Accept email parameter
  //   return userCollection.doc(currentUser!.email).snapshots().map((docSnapshot) {
  //     return UserModel.fromFirestore(docSnapshot.data() as Map<String, dynamic>);
  //   });
  // }