import 'package:flutter/material.dart';

import '../../../../core/constants.dart';
import 'add_note_bottom_sheet.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Constants.mainColor,
        shape: const CircleBorder(),
        onPressed: () {
          // showDialog(context: context, builder: (context) {
          //   return AlertDialog();
          // },);
          showModalBottomSheet(
            isScrollControlled: true,
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            context: context,
            builder: (context) {
              return const AddNoteBottomSheet();
            },
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ));
  }
}
