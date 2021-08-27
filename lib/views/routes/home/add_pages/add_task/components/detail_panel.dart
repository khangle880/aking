import 'package:aking/global/constants/assets_path.dart';
import 'package:aking/logic/provider/add_task.dart';
import 'package:aking/logic/utils/modules/color_module.dart';
import 'package:aking/views/routes/home/add_pages/add_task/components/add_member.dart';
import 'package:aking/views/routes/home/add_pages/add_task/components/due_date_picker.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:aking/views/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'description_container.dart';

class DetailPanel extends StatelessWidget {
  const DetailPanel({Key? key, required this.child, this.backgroundColor})
      : super(key: key);
  final Widget child;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 565.h,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => context
            .read<AddTaskProvider>()
            .changeForcusingStatus(FocusingStatus.none),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(9.r),
                  bottomRight: Radius.circular(9.r)),
              color: backgroundColor,
            ),
            child: child),
      ),
    );
  }
}

class DetailForm extends StatelessWidget {
  const DetailForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DetailPanel(
      child: ListView(
        children: [
          Container(
            height: 66.h,
            color: hexToColor("#F4F4F4"),
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Center(
              child: TextField(
                style: textTheme.subtitle1,
                autofocus: true,
                decoration: InputDecoration(
                        hintText: "Title", hintStyle: textTheme.subtitle1)
                    .toNoneBorder(),
                onTap: () => context
                    .read<AddTaskProvider>()
                    .changeForcusingStatus(FocusingStatus.none),
              ),
            ),
          ),
          DescriptionContainer(),
          DueDatePicker(),
          AddMember(),
          SizedBox(height: 44.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: RoundedButton(
                text: "Add Task",
                press: () {
                  //TODO: handle add Task
                },
                backgroundColor: hexToColor("#F96060"),
                textColor: hexToColor("#FFFFFF")),
          )
        ],
      ),
    );
  }
}

class AssigneeSuggest extends StatelessWidget {
  const AssigneeSuggest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DetailPanel(
      backgroundColor: hexToColor("#F4F4F4"),
      child: AssigneeListView(),
    );
  }
}

class AssigneeListView extends StatelessWidget {
  const AssigneeListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView();
  }
}

class ProjectSuggest extends StatelessWidget {
  const ProjectSuggest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DetailPanel(
      backgroundColor: hexToColor("#F4F4F4"),
      child: ProjectListView(),
    );
  }
}

class ProjectListView extends StatelessWidget {
  const ProjectListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView();
  }
}
