import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/features/tasks/presentation/bloc/task_event.dart';
import 'package:machine_test/features/tasks/presentation/bloc/task_state.dart';

import '../../domain/entities/task_entity.dart';
import '../../domain/usecases/task_use_case.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasksUseCase getTasks;
  final AddTaskUseCase addTask;
  final UpdateTaskUseCase updateTask;
  final DeleteTaskUseCase deleteTask;

  StreamSubscription? _taskSub;

  TaskBloc({
    required this.getTasks,
    required this.addTask,
    required this.updateTask,
    required this.deleteTask,
  }) : super(TaskInitial()) {

    on<LoadTasks>(_onLoadTasks);
    on<AddTaskEvent>(_onAddTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
  }

  void _onLoadTasks(
      LoadTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());

    await _taskSub?.cancel();

    _taskSub = getTasks(event.userId).listen((tasks) {
      add(_TaskUpdated(tasks));
    });
  }

  void _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    await addTask(event.task);
  }

  void _onUpdateTask(UpdateTaskEvent event, Emitter<TaskState> emit) async {
    await updateTask(event.task);
  }

  void _onDeleteTask(DeleteTaskEvent event, Emitter<TaskState> emit) async {
    await deleteTask(event.id);
  }

  void _onInternalUpdate(_TaskUpdated event, Emitter<TaskState> emit) {
    emit(TaskLoaded(event.tasks));
  }
}

class _TaskUpdated extends TaskEvent {
  final List<TaskEntity> tasks;
  _TaskUpdated(this.tasks);
}