import 'dart:ui';

import 'package:aking/logic/blocs/firestore/firestore_bloc.dart';
import 'package:aking/logic/blocs/task/get_task/task_bloc.dart';
import 'package:aking/logic/models/task.dart';
import 'package:aking/views/routes/home/tabs/work_list/view_task_details/components/task_detail_body.dart';
import 'package:aking/views/routes/home/tabs/work_list/view_task_details/components/task_details_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskDetailsForm extends StatefulWidget {
  const TaskDetailsForm({Key? key}) : super(key: key);

  @override
  _TaskDetailsFormState createState() => _TaskDetailsFormState();
}

class _TaskDetailsFormState extends State<TaskDetailsForm> {
  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(),
          child: Container(
            color: Colors.black.withOpacity(0.4),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 66.h, 16.w, 30.h),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              color: Colors.white,
            ),
            child: BlocBuilder<TaskBloc, FirestoreState<Task>>(
              builder: (context, state) {
                return Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close)),
                        Spacer(),
                        TaskDetailsMenuPopup(),
                      ],
                    ),
                    TaskDetailsBody(),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
