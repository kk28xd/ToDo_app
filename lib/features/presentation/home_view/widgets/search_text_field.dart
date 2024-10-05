import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/data/cubits/todo_cubit/task_cubit.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: const Icon(Icons.search),
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.all(0),
        border: myBorder(),
        enabledBorder: myBorder(),
        focusedBorder: myBorder(),
      ),
      onChanged: (value) {
        BlocProvider.of<TaskCubit>(context).updateSearchText(value);
      },
    );
  }
  OutlineInputBorder myBorder([color]) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color ?? Colors.white),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      gapPadding: 0,
    );
  }
}
