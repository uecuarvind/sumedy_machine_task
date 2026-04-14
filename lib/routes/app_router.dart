import 'package:flutter/material.dart';
import 'package:machine_test/features/tasks/presentation/screen/add_task_screen.dart';
import 'package:machine_test/features/tasks/presentation/screen/task_detail_screen.dart';
import 'package:machine_test/features/tasks/presentation/screen/task_list_screen.dart';
import '../features/auth/presentation/screen/login_screen.dart';
import '../features/auth/presentation/screen/splash_screen.dart';
import '../features/tasks/presentation/screen/profile_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String tasks = '/tasks';
  static const String addTask = '/add-task';
  static const String taskDetail = '/task-detail';
  static const String profile = '/profile';


  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      // return MaterialPageRoute(builder: (_) => BottomNavScreen());

      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case tasks:
        return MaterialPageRoute(builder: (_) => TaskListScreen());

      case addTask:
        return MaterialPageRoute(builder: (_) => AddTaskScreen());
      case taskDetail:
        return MaterialPageRoute(builder: (_) => TaskDetailScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

  static MaterialPageRoute _errorRoutes(String errorMassage) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(child: Text('No route defined for $errorMassage')),
      ),
    );
  }
}
