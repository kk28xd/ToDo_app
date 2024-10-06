import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/features/data/cubits/todo_cubit/task_cubit.dart';
import 'package:todo_app/features/data/cubits/todo_cubit/task_states.dart';
import 'package:todo_app/features/data/models/task_model.dart';
import 'package:todo_app/features/presentation/home_view/widgets/custom_button.dart';
import 'package:todo_app/features/presentation/home_view/widgets/custom_text_field.dart';
import 'package:todo_app/features/presentation/home_view/widgets/task_item.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskStates>(builder: (context, state) {
      List<Task> tasks = BlocProvider.of<TaskCubit>(context).tasks ?? [];
      return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Slidable(
              key: ValueKey<Task>(tasks[index]),
              startActionPane: ActionPane(
                motion: const StretchMotion(),
                children: [
                  SlidableAction(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    onPressed: (context) {
                      BlocProvider.of<TaskCubit>(context)
                          .deleteTask(task: tasks[index]);
                      tasks.removeAt(index);
                      setState(() {});
                    },
                    foregroundColor: const Color(0xffFC3D38),
                    icon: Icons.delete,
                    label: 'Delete',
                    padding: const EdgeInsets.all(4),
                  ),
                  SlidableAction(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    onPressed: (context) {
                      textEditingController.text = tasks[index].title;
                      updateTitleDialog(context, tasks[index], index);
                    },
                    foregroundColor: const Color(0xff0BAEC6),
                    icon: Icons.edit_note,
                    label: 'Edit',
                    padding: const EdgeInsets.all(4),
                  ),
                ],
              ),
              child: TaskItem(
                task: tasks[index],
              ),
            ),
          );
        },
      );
    });
  }

  void updateTitleDialog(BuildContext context, Task task, int index) {
    AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
    final GlobalKey<FormState> formKey = GlobalKey();
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<TaskCubit, TaskStates>(
              listener: (context, state) {
                if (state is UpdateTaskSuccess) {
                  BlocProvider.of<TaskCubit>(context).getAllTasks();
                  Navigator.pop(context);
                } else if (state is UpdateTaskFailure) {
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
                                label: 'Update',
                                on: () {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    BlocProvider.of<TaskCubit>(context)
                                        .updateTask(
                                            task: Task(
                                                isDone: task.isDone,
                                                title:
                                                    textEditingController.text,
                                                id: task.id));
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
