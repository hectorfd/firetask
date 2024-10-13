import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firetask/models/task_model.dart';

class MyServiceFirestore {
  

  final CollectionReference collection;

  MyServiceFirestore({required String collection})
      : collection = FirebaseFirestore.instance.collection(collection);

  Future<String> addTask(TaskModel taskModel) async {
    try {
      final newDocument = collection.doc(); 
      await newDocument.set(taskModel.toJson());
      return newDocument.id; 
    } catch (e) {
      throw Exception('Error al agregar la tarea: $e'); 
    }
  }

  Future<void> finishedTask(String taskId) async {
    try {
      await collection.doc(taskId).update({
        "status": false
      });
    } catch (e) {
      throw Exception('Error al marcar la tarea como finalizada: $e');
    }
  }
}

