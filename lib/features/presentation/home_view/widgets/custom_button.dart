import 'package:flutter/material.dart';
import 'package:todo_app/core/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.label,
      required this.on,
      this.isLoading = false});

  final String label;
  final void Function() on;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(16),
      onPressed: on,
      minWidth: double.infinity,
      color: Constants.mainColor,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Constants.mainColor)),
      child: isLoading
          ? const SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                color: Colors.white,
              ))
          : Text(
              label,
              style: const TextStyle(color: Colors.white,fontSize: 22),
            ),
    );
  }
}
