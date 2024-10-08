import 'package:flutter/material.dart';

import '../../../../core/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    this.onSaved,
    this.textEditingController,
  });

  final String label;
  final void Function(String?)? onSaved;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      autofocus: true,
      onSaved: onSaved,
      validator: (val) {
        if (val?.isEmpty ?? true) {
          return 'field is required';
        }
        return null;
      },
      //cursorColor: KPrimaryColor,
      decoration: InputDecoration(
          label: Text(label),
          hintStyle: const TextStyle(//color: KPrimaryColor
              ),
          border: myBorder(),
          enabledBorder: myBorder(),
          //focusedBorder: myBorder(KPrimaryColor),
          errorBorder: myBorder(Colors.red),
          errorStyle: const TextStyle(color: Colors.red)),
    );
  }

  OutlineInputBorder myBorder([color]) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color ?? Constants.mainColor),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    );
  }
}
