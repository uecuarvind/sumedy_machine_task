import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test/routes/app_router.dart';

import 'core/navigation/navigation_service.dart';
import 'core/themes/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/tasks/presentation/bloc/task_bloc.dart';
import 'firebase_options.dart';
import 'core/di/injection_container.dart' as di;

// ✅ IMPORT AUTH BLOC
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await di.init(); // ✅ Dependency Injection

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        /// ✅ GLOBAL AUTH BLOC (VERY IMPORTANT)
        BlocProvider(
          create: (_) => di.sl<AuthBloc>()..add(CheckAuthEvent()),
        ),
        BlocProvider(create: (_) => di.sl<TaskBloc>()),

      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 764),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'Sumedy',
            debugShowCheckedModeBanner: false,
            navigatorKey: NavigationService.navigatorKey,
            theme: AppTheme.lightTheme,
            initialRoute: '/',
            onGenerateRoute: AppRoutes.onGenerateRoute,
          );
        },
      ),
    );
  }
}