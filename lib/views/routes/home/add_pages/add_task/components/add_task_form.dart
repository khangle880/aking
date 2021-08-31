import 'package:aking/logic/blocs/task/add_task/add_task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => context
          .read<AddTaskBloc>()
          .add(FocusingStatusOnChange(focusingStatus: FocusingStatus.none)),
      child: BlocBuilder<AddTaskBloc, AddTaskState>(
        builder: (context, state) => Column(
          children: <Widget>[
            SizedBox(height: 30.h),
            SearchTextFieldRow(),
            SizedBox(height: 24.h),
            // AnimatedSwitcher(
            //   duration: const Duration(milliseconds: 950),
            //   transitionBuilder: (Widget child, Animation<double> animation) {
            //     return SizeTransition(
            //         sizeFactor: animation, axisAlignment: 3, child: child);
            //   },
            //   child:
            () {
              if (state.focusingStatus == FocusingStatus.assignee) {
                return const AssigneeSuggest();
              }
              if (state.focusingStatus == FocusingStatus.project) {
                return const ProjectSuggest();
              }
              return const DetailForm();
            }(),
            // ),
          ],
        ),
      ),
    );
  }
}
