import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NormalTextField extends StatelessWidget {
  const NormalTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.validator,
      this.keyboardType})
      : super(key: key);

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      style: Theme.of(context).textTheme.bodyText2!.copyWith(
            decorationColor: Colors.black.withOpacity(0.01),
          ),
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
