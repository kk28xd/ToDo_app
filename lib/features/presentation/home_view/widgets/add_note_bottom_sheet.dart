import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/data/cubits/todo_cubit/task_cubit.dart';
import 'package:todo_app/features/data/cubits/todo_cubit/task_states.dart';
import 'package:todo_app/features/presentation/home_view/widgets/custom_button.dart';
import 'package:todo_app/features/presentation/home_view/widgets/custom_text_field.dart';

import '../../../data/models/task_model.dart';

class AddNoteBottomSheet extends StatefulWidget {
  const AddNoteBottomSheet({super.key});

  @override
  State<AddNoteBottomSheet> createState() => _AddNoteBottomSheetState();
}

class _AddNoteBottomSheetState extends State<AddNoteBottomSheet> {
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> formKey = GlobalKey();
  String? title;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit,TaskStates>(
      listener: (context, state) {
        if (state is AddTaskSuccess) {
          BlocProvider.of<TaskCubit>(context).getAllTasks();
          Navigator.pop(context);
        } else if (state is AddTaskFailure) {
          log('Failed ${state.errorMessage}');
        }
      },
      builder: (context, state) => Padding(
        padding: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: bottomSheetForm(),
      ),
    );
  }

  Form bottomSheetForm() {
    return Form(
      autovalidateMode: autoValidateMode,
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            label: 'Title',
            onSaved: (value) {
              title = value;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          BlocBuilder<TaskCubit, TaskStates>(
            builder: (context, state) => CustomButton(
              label: 'Add',
              on: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  BlocProvider.of<TaskCubit>(context)
                      .insertTask(task: Task(title: title!, isDone: 0));
                } else {
                  autoValidateMode = AutovalidateMode.always;
                  setState(() {});
                }
              },
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
