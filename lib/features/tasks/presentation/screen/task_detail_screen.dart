import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/task_model.dart';
import '../../domain/entities/task_entity.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final task = ModalRoute.of(context)!.settings.arguments as TaskEntity;

    return Scaffold(
      appBar: AppBar(title: const Text("Task Detail")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(task.title, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text(task.description),

            const SizedBox(height: 20),

            Row(
              children: [
                const Text("Completed"),
                Checkbox(
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
              ],
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                context.read<TaskBloc>().add(DeleteTaskEvent(task.id));
                Navigator.pop(context);
              },
              child: const Text("Delete Task"),
            )
          ],
        ),
      ),
    );
  }
}