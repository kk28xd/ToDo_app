import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/data/cubits/todo_cubit/task_cubit.dart';
import 'package:todo_app/simple_bloc_observer.dart';

import 'features/presentation/home_view/home_view.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeView(),
      ),
    );
  }
}
