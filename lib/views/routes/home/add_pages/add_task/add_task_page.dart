import 'package:aking/logic/provider/add_task.dart';
import 'package:aking/logic/utils/modules/color_module.dart';
import 'package:aking/views/routes/home/add_pages/add_task/components/add_task_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return Scaffold(
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
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
            child: Container(
              height: 700.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9.r),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(3.h, 3.h),
                    color: Color.fromRGBO(221, 221, 221, 0.5),
                    blurRadius: 3.w,
                  )
                ],
              ),
              child: ChangeNotifierProvider<AddTaskProvider>(
                  create: (_) => AddTaskProvider(), child: AddTaskForm()),
            ),
          )
        ],
      ),
    );
  }
}
