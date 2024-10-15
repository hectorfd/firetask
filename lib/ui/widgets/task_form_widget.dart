import 'package:firebase_auth/firebase_auth.dart';
import 'package:firetask/models/task_model.dart';
import 'package:firetask/services/my_service_firestore.dart';
import 'package:firetask/ui/widgets/textfield_normal_widget.dart';
import 'package:flutter/material.dart';

import '../general/colors.dart';
import 'button_normal_widget.dart';
import 'general_widgets.dart';

class TaskFormWidget extends StatefulWidget {
  @override
  State<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  final formKey = GlobalKey<FormState>();
  MyServiceFirestore taskService = MyServiceFirestore(collection: "tasks");

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  String categorySelected = "Personal";

  showSelecDate() async {
    DateTime? datetime = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
      cancelText: "Cancelar",
      confirmText: "Aceptar",
      helpText: "Seleccionar fecha",
      builder: (BuildContext context, Widget? widget) {
        return Theme(
          data: ThemeData.light().copyWith(
            dialogBackgroundColor: Colors.white,
            dialogTheme: DialogTheme(
              elevation: 0,
              backgroundColor: secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            colorScheme: ColorScheme.light(
              primary: primary,
            ),
          ), 
          child: widget!,
        );
      }
    );
    
    if(datetime != null) {
      _dateController.text = datetime.toString().substring(0,10);
      setState(() {});
    }
  }

  registerTask() {
    if (formKey.currentState!.validate()) {
      TaskModel taskModel = TaskModel(
        title: _titleController.text,
        description: _descriptionController.text,
        date: _dateController.text,
        category: categorySelected,
        status: true,
      );

      final BuildContext currentContext = context;


      String userId = FirebaseAuth.instance.currentUser!.uid;


      taskService.addTask(taskModel, userId).then((value) {
        if (value.isNotEmpty) {
          Navigator.pop(currentContext);

          _titleController.clear();
          _descriptionController.clear();
          _dateController.clear();

          showSnackBarSuccess(currentContext, "La tarea ha sido registrada con éxito");
        }
      }).catchError((e) {
        print(e);
        showSnackBarError(currentContext, "Error, inténtelo de nuevo");
        Navigator.pop(currentContext);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          bottomLeft: Radius.circular(22),
        ),
      ),
      padding: const EdgeInsets.all(5),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Agregar Tarea",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            caja6(),
            TextfieldNormalWidget(
              hintText: "Titulo",
              icon: Icons.text_fields,
              controller: _titleController,
            ),
            caja6(),
            TextfieldNormalWidget(
              hintText: "Descripción",
              icon: Icons.description,
              controller: _descriptionController,
            ),
            caja10(),
            Text("Categoria: "),
            Wrap(
              spacing: 10,
              children: [
                FilterChip(
                  selected: categorySelected == "Personal",
                  backgroundColor: secondary,
                  label: Text("Personal"),
                  selectedColor: categoryColor[categorySelected],
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(
                    color: categorySelected == "Personal" ? Colors.white : primary,
                  ),
                  onSelected: (bool value) {
                    setState(() {
                      categorySelected = "Personal";
                    });
                  },
                ),
                FilterChip(
                  selected: categorySelected == "Trabajo",
                  backgroundColor: secondary,
                  label: Text("Trabajo"),
                  selectedColor: categoryColor[categorySelected],
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(
                    color: categorySelected == "Trabajo" ? Colors.white : primary,
                  ),
                  onSelected: (bool value) {
                    setState(() {
                      categorySelected = "Trabajo";
                    });
                  },
                ),
                FilterChip(
                  selected: categorySelected == "Otro",
                  backgroundColor: secondary,
                  label: Text("Otro"),
                  selectedColor: categoryColor[categorySelected],
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(
                    color: categorySelected == "Otro" ? Colors.white : primary,
                  ),
                  onSelected: (bool value) {
                    setState(() {
                      categorySelected = "Otro";
                    });
                  },
                ),
              ],
            ),
            caja10(),
            TextfieldNormalWidget(
              hintText: "Fecha",
              icon: Icons.date_range,
              onTap: () {
                showSelecDate();
              },
              controller: _dateController,
            ),
            ButtonNormalWidget(onPressed: () {
              registerTask();
            }),
          ],
        ),
      ),
    );
  }
}
