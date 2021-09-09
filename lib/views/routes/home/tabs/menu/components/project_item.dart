import 'package:aking/logic/blocs/process_firestore_doc/process_firestore_doc_bloc.dart';
import 'package:aking/logic/blocs/process_state.dart';
import 'package:aking/logic/blocs/task/get_task/task_bloc.dart';
import 'package:aking/logic/models/project.dart';
import 'package:aking/logic/repositories/firestore/project_repository.dart';
import 'package:aking/views/utils/extensions/flush_bar.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:aking/views/widgets/popup_menu.dart';
import 'package:aking/views/widgets/popup_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectItem extends StatefulWidget {
  const ProjectItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Project item;
  @override
  _ProjectItemState createState() => _ProjectItemState();
}

class _ProjectItemState extends State<ProjectItem> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final numberOfTask = context
        .watch<TaskBloc>()
        .allDoc
        .where((element) => element.projectId == widget.item.id)
        .length;

    return BlocProvider<ProcessFSDocBloc<Project>>(
      create: (_) =>
          ProcessFSDocBloc<Project>(context.read<ProjectRepository>()),
      child: BlocConsumer<ProcessFSDocBloc<Project>, ProcessState>(
        listener: (context, state) {
          if (state is Processing) {
            ExpandedFlushbar.loadingFlushbar(context, message: "Deleting")
                .show(context);
          }
          if (state is ProcessFailure) {
            ExpandedFlushbar.failureFlushbar(context,
                    message: state.errorMessage)
                .show(context);
          }
          if (state is Processing) {
            ExpandedFlushbar.successFlushbar(context,
                    message: 'Delete Project Successfully!')
                .show(context);
          }
        },
        builder: (context, state) => CustomPopupMenuButton(
          menuItems: [
            CustomPopupMenuItem(
                title: Text(
                  "Open",
                  style: textTheme.subtitle2!.copyWith(fontSize: 15.sp),
                ),
                trailingIcon:
                    Icon(Icons.open_in_new, color: Colors.indigoAccent),
                onPressed: () {
                  Navigator.pushNamed(context, '/details',
                      arguments: widget.item.id);
                }),
            CustomPopupMenuItem(
                title: Text(
                  "Delete",
                  style: textTheme.subtitle2!.copyWith(fontSize: 15.sp),
                ),
                trailingIcon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  context
                      .read<ProcessFSDocBloc<Project>>()
                      .add(DeleteFSDoc<Project>(docId: widget.item.id));
                }),
          ],
          onPressed: () {},
          menuWidth: 165.w,
          menuItemExtent: 40.w,
          menuOffset: 8.w,
          menuBoxDecoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.r))),
          duration: Duration(milliseconds: 200),
          blurSize: 0.1,
          blurBackgroundColor:
              ExpandedColor.fromHex("#000000").withOpacity(0.6),
          child: Container(
            height: 180.h,
            width: 165.w,
            padding: EdgeInsets.all(24.h),
            decoration: BoxDecoration(
              color: ExpandedColor.fromHex("#FFFFFF"),
              borderRadius: BorderRadius.circular(5.r),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(227, 227, 227, 0.5),
                  offset: Offset(0, 2.0),
                  blurRadius: 10.r,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 26.h,
                  height: 26.h,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: ExpandedColor.fromHex(widget.item.hexColor)
                              .withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(6.h),
                        decoration: BoxDecoration(
                          color: ExpandedColor.fromHex(widget.item.hexColor),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 46.h),
                Text(
                  widget.item.title,
                  style: textTheme.subtitle1,
                ),
                SizedBox(height: 16.h),
                Text(
                  "$numberOfTask ${numberOfTask < 2 ? 'Task' : 'Tasks'}",
                  style: textTheme.button,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
