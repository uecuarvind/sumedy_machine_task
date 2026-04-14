import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task_model.dart';

class TaskRemoteDataSource {
  final FirebaseFirestore firestore;

  TaskRemoteDataSource(this.firestore);

  CollectionReference get _taskRef =>
      firestore.collection('tasks');

  Stream<List<TaskModel>> getTasks(String userId) {
    return _taskRef
        .where('user_id', isEqualTo: userId)
        .orderBy('created_at', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => TaskModel.fromJson(
        doc.data() as Map<String, dynamic>, doc.id))
        .toList());
  }

  Future<void> addTask(TaskModel task) async {
    await _taskRef.add(task.toJson());
  }

  Future<void> updateTask(TaskModel task) async {
    await _taskRef.doc(task.id).update(task.toJson());
  }

  Future<void> deleteTask(String id) async {
    await _taskRef.doc(id).delete();
  }
}