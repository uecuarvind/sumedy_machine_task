import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_remote_dataSource.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remote;

  TaskRepositoryImpl(this.remote);

  @override
  Stream<List<TaskEntity>> getTasks(String userId) {
    return remote.getTasks(userId);
  }

  @override
  Future<void> addTask(TaskEntity task) async {
    await remote.addTask(task as TaskModel);
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    await remote.updateTask(task as TaskModel);
  }

  @override
  Future<void> deleteTask(String id) async {
    await remote.deleteTask(id);
  }
}