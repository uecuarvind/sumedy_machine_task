import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../data/models/task_model.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../bloc/task_state.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListState();
}

class _TaskListState extends State<TaskListScreen> {

  String userId = "";

  @override
  void initState() {
    super.initState();

    final authState = context.read<AuthBloc>().state;
    if (authState is Authenticated) {
      userId = authState.user.uid;
      context.read<TaskBloc>().add(LoadTasks(userId));
    }
  }

  Future<void> _refresh() async {
    context.read<TaskBloc>().add(LoadTasks(userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Tasks"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            icon: const Icon(Icons.person),
          )
        ],
      ),

      body: RefreshIndicator(
        onRefresh: _refresh,
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {

            if (state is TaskLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is TaskLoaded) {
              if (state.tasks.isEmpty) {
                return const Center(child: Text("No Tasks Found"));
              }

              return ListView.builder(
                itemCount: state.tasks.length,
                itemBuilder: (context, index) {
                  final task = state.tasks[index];

                  return ListTile(
                    title: Text(task.title),
                    subtitle: Text(task.description),
                    trailing: Checkbox(
                      value: task.isCompleted,
                      onChanged: (_) {
                        context.read<TaskBloc>().add(
                          UpdateTaskEvent(
                            TaskModel(
                              id: task.id,
                              title: task.title,
                              description: task.description,
                              isCompleted: !task.isCompleted,
                              createdAt: task.createdAt,
                              userId: task.userId,
                            ),
                          ),
                        );
                      },
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/task-detail',
                        arguments: task,
                      );
                    },
                  );
                },
              );
            }

            if (state is TaskError) {
              return Center(child: Text(state.message));
            }

            return const SizedBox();
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-task');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}