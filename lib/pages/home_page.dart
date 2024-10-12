import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  CollectionReference tasksReference = FirebaseFirestore.instance.collection("tasks");
  // colecciones de firebase aqui...
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              tasksReference.get().then((QuerySnapshot value){
                // QuerySnapshot collection = value;
                // List<QueryDocumentSnapshot> docs = collection.docs;
                QuerySnapshot collection = value;
                collection.docs.forEach((QueryDocumentSnapshot element){
                  Map<String, dynamic> myMap = element.data() as Map<String, dynamic>;
                  print(myMap["title"]);
                });
              });
            },
                child: Text("obtener data"),
            ),

            ElevatedButton(onPressed: (){
              tasksReference.add({
                "title": "dormir",
                "description":"Para recuperar fuerzas",
                "status": false,
              },
              ).then((value){
                print(value);
              });
            },
                child: Text("agregar"),
            ),
          ],
        ),
      ),
    );
  }
}