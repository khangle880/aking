import 'package:aking/logic/blocs/process_firestore_doc/process_firestore_doc_bloc.dart';
import 'package:aking/logic/blocs/task/get_task/task_bloc.dart';
import 'package:aking/logic/blocs/task/process_task/process_task_bloc.dart';
import 'package:aking/logic/models/task.dart';
import 'package:aking/views/utils/extensions/flush_bar.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:aking/views/widgets/popup_menu.dart';
import 'package:aking/views/widgets/popup_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskDetailsMenuPopup extends StatefulWidget {
  const TaskDetailsMenuPopup({Key? key}) : super(key: key);

  @override
  _TaskDetailsMenuPopupState createState() => _TaskDetailsMenuPopupState();
}

class _TaskDetailsMenuPopupState extends State<TaskDetailsMenuPopup> {
  static const _menuList = ["Add to Project", "Add Member", "Delete Task"];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: CustomPopupMenuButton(
        onPressed: () {},
        menuItems: _menuList
            .map(
              (e) => CustomPopupMenuItem(
                title: Text(
                  e,
                  style: textTheme.subtitle2!.copyWith(fontSize: 17.sp),
                ),
                onPressed: () {
                  if (e == "Delete Task") {
                    final String? currentTaskId =
                        context.read<TaskBloc>().currentTask;
                    if (currentTaskId == null) {
                      ExpandedFlushbar.failureFlushbar(context,
                              message: "Not exist this Task")
                          .show(context);
                    } else {
                      Future.delayed(
                        Duration(milliseconds: 300),
                        () {
                          Navigator.of(context).pop();
                          context
                              .read<ProcessTaskBloc>()
                              .add(DeleteFSDoc<Task>(docId: currentTaskId));
                        },
                      );
                    }
                  }
                },
              ),
            )
            .toList(),
        openWithTap: true,
        parentContext: context,
        useRootNavigator: false,
        menuWidth: 225.w,
        menuItemExtent: 40.w,
        menuOffset: 0.w,
        animateMenuItems: false,
        menuBoxDecoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15.r))),
        duration: Duration(milliseconds: 100),
        blurSize: 0.0,
        blurBackgroundColor: ExpandedColor.fromHex("#000000").withOpacity(0.4),
        enableChildInPopup: false,
        child: Icon(Icons.settings),
      ),
    );
  }
}
