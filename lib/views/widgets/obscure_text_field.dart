import 'package:flutter/material.dart';

class ObscureTextField extends StatefulWidget {
  const ObscureTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.validator})
      : super(key: key);

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;

  @override
  _ObscureTextFieldState createState() => _ObscureTextFieldState();
}

class _ObscureTextFieldState extends State<ObscureTextField> {
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: Theme.of(context).textTheme.bodyText2,
      validator: widget.validator,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(_obscureText
              ? Icons.remove_red_eye_outlined
              : Icons.remove_red_eye_rounded),
          onPressed: _toggle,
        ),
        hintText: widget.hintText,
      ),
    );
  }
}
