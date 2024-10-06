import 'package:flutter/material.dart';
import 'package:todo_app/core/constants.dart';
import 'package:todo_app/features/presentation/home_view/widgets/custom_floating_action_button.dart';
import 'package:todo_app/features/presentation/home_view/widgets/home_view_body.dart';
import 'package:todo_app/features/presentation/home_view/widgets/search_text_field.dart';

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
              SizedBox(height: 12,),
              SearchTextField(),
              SizedBox(height: 8,),
              Expanded(child: HomeViewBody()),
            ],
          ),
        ),
      ),
    );
  }
}
