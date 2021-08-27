import 'package:aking/logic/provider/add_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'detail_panel.dart';
import 'search_textfield_row/search_textfield_row.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({Key? key}) : super(key: key);

  @override
  _AddTaskFormState createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Consumer<AddTaskProvider>(
      builder: (context, value, child) => Column(
        children: <Widget>[
          SizedBox(height: 30.h),
          SearchTextFieldRow(),
          SizedBox(height: 24.h),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 1000),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SizeTransition(
                  sizeFactor: animation, axisAlignment: 3, child: child);
            },
            child: () {
              if (value.forcusingStatus == FocusingStatus.assignee) {
                return AssigneeSuggest();
              }
              if (value.forcusingStatus == FocusingStatus.project) {
                return ProjectSuggest();
              }
              return DetailForm();
            }(),
          ),
        ],
      ),
    );
  }
}
