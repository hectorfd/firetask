import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firetask/ui/general/colors.dart';
import 'package:firetask/ui/widgets/general_widgets.dart';
import 'package:firetask/ui/widgets/item_task_widget.dart';
import 'package:flutter/material.dart';

import '../ui/widgets/textfield_search_widget.dart';

class HomePage extends StatelessWidget {

  CollectionReference tasksReference = FirebaseFirestore.instance.collection("tasks");
  // colecciones de firebase aqui...

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: secondary,
      floatingActionButton: InkWell(
        onTap: (){

        },
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: primary,
            borderRadius: BorderRadius.circular(15)
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, color: Colors.white,),
              Text("Nueva tarea",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 18),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(4, 4),
              ),
            ],
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Bienvenido, Héctor",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: primary,
                    ),
                  ),
                  Text("Mis Tareas",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                      color: primary,
                    ),
                  ),
                  caja10(),
                  TextfieldSearchWidget(),
                ],
              ),
            ),
            ),

          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Todas mis Tareas", style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primary.withOpacity(0.85)
                ),
                ),
                ItemTaskWidget(),
              ],
            ),
          ),
          ],

      ),
      ),
      // body: StreamBuilder(stream: tasksReference.snapshots(),
      //     builder: (BuildContext context, AsyncSnapshot snap){
      //   if(snap.hasData){
      //     QuerySnapshot collection = snap.data;
      //     List<QueryDocumentSnapshot> docs = collection.docs;
      //     List<Map<String, dynamic>> docsMap = docs.map((e)=>e.data() as Map<String, dynamic>).toList();
      //     return ListView.builder(
      //         itemCount: docsMap.length,
      //         itemBuilder: (BuildContext context, int index){
      //           return ListTile(
      //           title:  Text(docsMap[index]["title"]),
      //           );
      //         }
      //     );
      //   }
      //       return Center(child: CircularProgressIndicator(),);
      //     },
      // ),
    );
  }
}