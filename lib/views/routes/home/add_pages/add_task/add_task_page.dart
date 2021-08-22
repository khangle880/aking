import 'package:aking/logic/blocs/task/task_bloc.dart';
import 'package:aking/logic/blocs/tasks_group/tasks_group_bloc.dart';
import 'package:aking/logic/utils/modules/color_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (_) => TasksGroupBloc()
        //todo: change bloc to public user info
        ..add(TasksGroupByDate(
            tasks: (context.read<TaskBloc>().state as TaskLoaded).tasks)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: hexToColor("#F96060"),
          title: Text(
            'New Task',
            style: textTheme.subtitle1!
                .copyWith(color: Colors.white, fontSize: 20.sp),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Column(
              children: <Widget>[
                Container(
                  height: 44.h,
                  color: hexToColor("#F96060"),
                ),
                Spacer(),
                Container(
                  height: 60.h,
                  color: hexToColor("#292E4E"),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 6.h, 16.w, 0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9.w),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(3.h, 3.h),
                      color: Color.fromRGBO(221, 221, 221, 0.5),
                      blurRadius: 3.w,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
