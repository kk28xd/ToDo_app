import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/data/models/task_model.dart';
import '../../../../core/constants.dart';
import '../../../data/cubits/todo_cubit/task_cubit.dart';
import '../../../data/cubits/todo_cubit/task_states.dart';
import 'custom_button.dart';
import 'custom_text_field.dart';

class CustomFloatingActionButton extends StatefulWidget {
  const CustomFloatingActionButton({super.key});

  @override
  State<CustomFloatingActionButton> createState() =>
      _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState
    extends State<CustomFloatingActionButton> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Constants.mainColor,
        shape: const CircleBorder(),
        onPressed: () {
          addTaskDialog(context);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ));
  }

  void addTaskDialog(BuildContext context) {
    AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
    final GlobalKey<FormState> formKey = GlobalKey();
    textEditingController.text = '';
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<TaskCubit, TaskStates>(
              listener: (context, state) {
                if (state is AddTaskSuccess) {
                  BlocProvider.of<TaskCubit>(context).getAllTasks();
                  Navigator.pop(context);
                } else if (state is AddTaskFailure) {
                  log('Failed ${state.errorMessage}');
                }
              },
              builder: (context, state) =>
                  AlertDialog(actionsPadding: EdgeInsets.zero, actions: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                          autovalidateMode: autoValidateMode,
                          key: formKey,
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: CustomTextField(
                                textEditingController: textEditingController,
                                label: 'Title',
                              ),
                            ),
                            BlocBuilder<TaskCubit, TaskStates>(
                              builder: (context, state) => CustomButton(
                                label: 'Add',
                                on: () {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    BlocProvider.of<TaskCubit>(context)
                                        .insertTask(
                                            task: Task(
                                                isDone: 0,
                                                title: textEditingController
                                                    .text));
                                  } else {
                                    autoValidateMode = AutovalidateMode.always;
                                    setState(() {});
                                  }
                                },
                              ),
                            ),
                          ])),
                    ),
                  ]));
        });
  }
}
