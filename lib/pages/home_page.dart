import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firetask/models/task_model.dart';
import 'package:firetask/ui/general/colors.dart';
import 'package:firetask/ui/widgets/button_normal_widget.dart';
import 'package:firetask/ui/widgets/general_widgets.dart';
import 'package:firetask/ui/widgets/item_task_widget.dart';
import 'package:firetask/ui/widgets/task_form_widget.dart';
import 'package:firetask/utils/task_search_delegate.dart';
import 'package:flutter/material.dart';

import '../ui/widgets/textfield_normal_widget.dart';

class HomePage extends StatelessWidget {
  List<TaskModel> tasksGeneral = [];

  final TextEditingController _searchController = TextEditingController();

  CollectionReference tasksReference = FirebaseFirestore.instance.collection("tasks");
  // colecciones de firebase aqui...

  showTaskForm(BuildContext context){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context){
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: TaskFormWidget(),
          );
        },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: secondary,
      floatingActionButton: InkWell(
        onTap: (){
          showTaskForm(context);
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
                  TextfieldNormalWidget(
                      controller: _searchController,
                      icon: Icons.search,
                      hintText: "Buscar tarea...",
                      onTap: () async {
                        await showSearch(
                            context: context,
                            delegate: TaskSearchDelegate(tasks: tasksGeneral));
                      },
                    ),
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

                StreamBuilder(
                    stream: tasksReference.snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snap){
                      if(snap.hasData){
                        List<TaskModel> tasks = [];
                        QuerySnapshot collection = snap.data;
                        // collection.docs.forEach((element){
                        //   Map<String, dynamic> myMap = element.data() as Map<String, dynamic>;
                        //   tasks.add(TaskModel.fromJson(myMap));
                        // });
                        tasks = collection.docs.map((e){
                          TaskModel task = TaskModel.fromJson(e.data() as Map<String, dynamic>);
                          task.id = e.id;
                          return task;
                        }).toList();
                        tasksGeneral.clear();
                        tasksGeneral = tasks;

                        return ListView.builder(
                            itemCount: tasks.length,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (BuildContext context, int index){
                              return ItemTaskWidget(taskModel: tasks[index],);
                            }
                        );
                      }
                      return loadingWidget();
                    },
                ),
              ],
            ),
          ),
          ],

      ),
      ),
      
    );
  }
}