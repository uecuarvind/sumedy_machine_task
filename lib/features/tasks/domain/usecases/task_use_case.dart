import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class GetTasksUseCase {
  final TaskRepository repo;
  GetTasksUseCase(this.repo);

  Stream<List<TaskEntity>> call(String userId) {
    return repo.getTasks(userId);
  }
}

class AddTaskUseCase {
  final TaskRepository repo;
  AddTaskUseCase(this.repo);

  Future<void> call(TaskEntity task) => repo.addTask(task);
}

class UpdateTaskUseCase {
  final TaskRepository repo;
  UpdateTaskUseCase(this.repo);

  Future<void> call(TaskEntity task) => repo.updateTask(task);
}

class DeleteTaskUseCase {
  final TaskRepository repo;
  DeleteTaskUseCase(this.repo);

  Future<void> call(String id) => repo.deleteTask(id);
}