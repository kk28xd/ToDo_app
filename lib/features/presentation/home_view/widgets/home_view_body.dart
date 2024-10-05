import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/features/data/cubits/todo_cubit/task_cubit.dart';
import 'package:todo_app/features/data/cubits/todo_cubit/task_states.dart';
import 'package:todo_app/features/data/models/task_model.dart';
import 'package:todo_app/features/presentation/home_view/widgets/task_item.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
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
                dismissible: DismissiblePane(
                  onDismissed: () {
                    BlocProvider.of<TaskCubit>(context)
                        .deleteTask(task: tasks[index]);
                    tasks.removeAt(index);
                    setState(() {});
                  },
                ),
                children: [
                  SlidableAction(
                    borderRadius: BorderRadius.circular(8),
                    onPressed: (context) {},
                    backgroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
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
}
