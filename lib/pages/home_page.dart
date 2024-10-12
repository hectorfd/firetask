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
            //para visualizar
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
            // para agregar
            ElevatedButton(onPressed: (){
              tasksReference.add({
                "title": "dormir mas",
                "description":"Para recuperar mas fuerzas",
                "status": false,
              },
              ).then((value){
                print(value);

              }).catchError((e){
                print("Ocurrio un error en el registro");
              }).whenComplete((){
                print("Se completó el Registro");
              });
            },
                child: Text("agregar"),
            ),
            // para actualizar un documento
            ElevatedButton(onPressed: (){
              tasksReference
                  .doc("kqoQyM7vScLKU9MJVozU")
                  .update({
                    "title": "amor",
                    "description":"Por la programción",
                    "status": false,
                  })
                  .catchError(
                  (e){
                      print(e);
                  },
              ).whenComplete((){
                print("Actualización completada");
              });
            },
                child: Text("actualizar"),
            ),

            // para eliminar un documento
            ElevatedButton(onPressed: (){
              tasksReference
                  .doc("kqoQyM7vScLKU9MJVozU")
                  .delete()
                  .catchError(
                    (e){
                  print(e);
                },
              ).whenComplete((){
                print("Eliminación completada");
              });
            },
              child: Text("Eliminar"),
            ),

            // boton personalizado
            ElevatedButton(onPressed: (){
              tasksReference
                  .doc("t0001").set({
                    "title": "ayudar a tablechi",
                    "description":"Po que ta triste",
                    "status": false,
                  }).catchError((e){
                    print(e);
              }).whenComplete((){
                print("creacion personalizada completada");
              });

            },
              child: Text("creacion personalizada"),
            ),
          ],
        ),
      ),
    );
  }
}