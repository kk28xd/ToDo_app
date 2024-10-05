import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/constants.dart';
import 'package:todo_app/features/data/cubits/todo_cubit/task_cubit.dart';
import 'package:todo_app/features/presentation/home_view/widgets/add_note_bottom_sheet.dart';
import 'package:todo_app/features/presentation/home_view/widgets/custom_floating_action_button.dart';
import 'package:todo_app/features/presentation/home_view/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const CustomFloatingActionButton(),
      backgroundColor: Constants.secondColor,
      appBar: AppBar(
        backgroundColor: Constants.mainColor,
        centerTitle: true,
        title: const Text(
          'Tasks',
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Expanded(child: HomeViewBody()),
            ],
          ),
        ),
      ),
    );
  }
}
