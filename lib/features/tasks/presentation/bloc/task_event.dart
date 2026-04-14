import '../../domain/entities/task_entity.dart';

abstract class TaskEvent {}

class LoadTasks extends TaskEvent {
  final String userId;
  LoadTasks(this.userId);
}

class AddTaskEvent extends TaskEvent {
  final TaskEntity task;
  AddTaskEvent(this.task);
}

class UpdateTaskEvent extends TaskEvent {
  final TaskEntity task;
  UpdateTaskEvent(this.task);
}

class DeleteTaskEvent extends TaskEvent {
  final String id;
  DeleteTaskEvent(this.id);
}