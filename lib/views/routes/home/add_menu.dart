import 'package:aking/logic/utils/modules/color_module.dart';
import 'package:aking/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddMenu extends StatefulWidget {
  const AddMenu({Key? key}) : super(key: key);

  @override
  _AddMenuState createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 214.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AddMenuItem(
            text: 'Add Task',
            onPressed: () {
              Navigator.popAndPushNamed(context, Routes.addTaskRoute);
            },
          ),
          Divider(
            thickness: 1.w,
            height: 2.h,
            color: hexToColor("#E4E4E4"),
          ),
          AddMenuItem(
            text: 'Add Quick Note',
            onPressed: () {},
          ),
          Divider(
            thickness: 1.w,
            height: 2.h,
            color: hexToColor("#E4E4E4"),
          ),
          AddMenuItem(
            text: 'Add Check List',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class AddMenuItem extends StatelessWidget {
  const AddMenuItem({Key? key, required this.text, required this.onPressed})
      : super(key: key);
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.grey[300])),
          child: SizedBox(
            width: double.infinity,
            child: Text(text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1),
          )),
    );
  }
}
