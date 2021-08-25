import 'package:aking/global/constants/assets_path.dart';
import 'package:aking/logic/blocs/firestore/firestore_bloc.dart';
import 'package:aking/logic/models/public_user_info.dart';
import 'package:aking/logic/provider/add_task.dart';
import 'package:aking/logic/utils/modules/color_module.dart';
import 'package:aking/views/routes/home/add_pages/add_task/components/project_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'assignee_textfield.dart';
import 'search_textfield_row.dart';

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
      builder: (context, value, child) => ListView(
        children: <Widget>[SizedBox(height: 20), SearchTextFieldRow()],
      ),
    );
  }
}
