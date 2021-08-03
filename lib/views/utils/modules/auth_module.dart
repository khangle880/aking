import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, List<Widget> children,
    {Duration? duration}) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
        backgroundColor: Theme.of(context).accentColor,
        duration: duration ?? Duration(milliseconds: 4000),
      ),
    );
}
