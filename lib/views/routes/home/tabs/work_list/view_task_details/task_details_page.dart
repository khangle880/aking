import 'package:aking/logic/blocs/task/process_task/process_task_bloc.dart';
import 'package:aking/views/routes/home/add_pages/add_check_list/components/add_check_list_form.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import 'components/task_details_form.dart';

class TaskDetailsPage extends StatefulWidget {
  const TaskDetailsPage({
    Key? key,
    required this.processTaskBloc,
  }) : super(key: key);
  final ProcessTaskBloc processTaskBloc;

  @override
  _TaskDetailsPageState createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: ExpandedColor.fromHex("#F96060"),
                ),
              ),
              Container(
                height: 60.h,
                color: ExpandedColor.fromHex("#292E4E"),
              ),
            ],
          ),
          BlocProvider.value(
            value: widget.processTaskBloc,
            child: SingleChildScrollView(child: TaskDetailsForm()),
          ),
        ],
      ),
    );
  }
}
