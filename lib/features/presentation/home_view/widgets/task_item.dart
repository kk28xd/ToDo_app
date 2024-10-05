import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/data/cubits/todo_cubit/task_cubit.dart';
import 'package:todo_app/features/data/cubits/todo_cubit/task_states.dart';
import 'package:todo_app/features/data/models/task_model.dart';
import '../../../../core/constants.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({super.key, required this.task});

  final Task task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    // Initialize isChecked based on the task's isDone value
    isChecked = widget.task.isDone == 1;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          decoration: ShapeDecoration(
              color: Constants.mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )),
          padding: const EdgeInsets.only(left: 12, bottom: 8, top: 8),
          child: ListTile(
            title: Text(
              widget.task.title,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                decoration: isChecked
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            trailing: Checkbox(
              activeColor: Colors.white,
              checkColor: Colors.black,
              value: isChecked,
              onChanged: (value) {
                isChecked = value!;
                BlocProvider.of<TaskCubit>(context).updateTask(
                    task: Task(
                        isDone: isChecked ? 1 : 0, title: widget.task.title,id: widget.task.id));
                setState(() {});
              },
            ),
          ),
        );
      },
    );
  }
}

// icon: const Icon(Icons.check_box,color: Colors.white,),
// icon: const Icon(
// Icons.check_box_outline_blank,
// color: Colors.white,
// ),

// Checkbox(
// activeColor: Colors.white,
// checkColor: Colors.black,
// value: isChecked,
// onChanged: (value) {
// isChecked = value!;
// setState(() {});
// },
// ),

// trailing: IconButton(
//   onPressed: () {},
//   icon: task.isDone == 1
//       ? const Icon(
//           Icons.check_box,
//           color: Colors.white,
//         )
//       : const Icon(
//           Icons.check_box_outline_blank,
//           color: Colors.white,
//         ),
// ),
