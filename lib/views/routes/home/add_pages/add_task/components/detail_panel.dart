import 'dart:developer';

import 'package:aking/global/constants/assets_path.dart';
import 'package:aking/logic/blocs/task/add_task/add_task_bloc.dart';
import 'package:aking/logic/blocs/process_state.dart';
import 'package:aking/logic/blocs/firestore/firestore_bloc.dart';
import 'package:aking/logic/models/project.dart';
import 'package:aking/logic/models/public_user_info.dart';
import 'package:aking/views/routes/home/add_pages/add_task/components/add_member/add_member.dart';
import 'package:aking/views/routes/home/add_pages/add_task/components/due_date_picker.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:aking/views/widgets/network_avatar.dart';
import 'package:aking/views/widgets/rounded_button.dart';
import 'package:aking/views/widgets/empty_view.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aking/logic/utils/extensions/logic_extensions.dart';

import 'description_container.dart';

class DetailPanel extends StatelessWidget {
  const DetailPanel({Key? key, required this.child, this.backgroundColor})
      : super(key: key);
  final Widget child;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 598.h,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(9.r),
                bottomRight: Radius.circular(9.r)),
            color: backgroundColor,
          ),
          child: child),
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
            color: ExpandedColor.fromHex("#F4F4F4"),
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Center(
              child: TextFormField(
                textCapitalization: TextCapitalization.sentences,
                style: textTheme.subtitle1,
                initialValue: context.read<AddTaskBloc>().state.title,
                decoration: InputDecoration(
                        hintText: "Title", hintStyle: textTheme.subtitle1)
                    .toNoneBorder(),
                onTap: () => context.read<AddTaskBloc>().add(
                      FocusingStatusOnChange(
                          focusingStatus: FocusingStatus.none),
                    ),
                onChanged: (value) => context
                    .read<AddTaskBloc>()
                    .add(TitleOnChange(title: value)),
              ),
            ),
          ),
          DescriptionContainer(),
          DueDatePicker(),
          AddMember(),
          SizedBox(height: 44.h),
          _buildAddTaskButton()
        ],
      ),
    );
  }

  Container _buildAddTaskButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: BlocConsumer<AddTaskBloc, AddTaskState>(
        listener: (context, state) {
          final submitStatus = state.addStatus;
          if (submitStatus is Processing) {
            CoolAlert.show(
              context: context,
              type: CoolAlertType.loading,
              barrierDismissible: false,
            );
          } else if (submitStatus is ProcessFailure) {
            Navigator.of(context, rootNavigator: true).pop();
            CoolAlert.show(
              backgroundColor: ExpandedColor.fromHex("#FFD371"),
              context: context,
              barrierDismissible: false,
              type: CoolAlertType.error,
              title: 'Oops...',
              text: submitStatus.errorMessage,
            );
          } else if (submitStatus is ProcessSuccess) {
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.pop(context);
            CoolAlert.show(
              context: context,
              barrierDismissible: false,
              backgroundColor: ExpandedColor.fromHex("#9DDAC6"),
              type: CoolAlertType.success,
              text: 'Add Task Successfully!',
            );
          }
        },
        builder: (context, state) => RoundedButton(
            text: "Add Task",
            onPressed: () {
              context.read<AddTaskBloc>().add(SubmitForm());
            },
            ),
      ),
    );
  }
}

class AssigneeSuggest extends StatelessWidget {
  const AssigneeSuggest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DetailPanel(
      backgroundColor: ExpandedColor.fromHex("#F4F4F4"),
      child: AssigneeListView(
        data: context.watch<FirestoreBloc<PublicUserInfo>>().allDoc.findByText(
            findKey: context.watch<AddTaskBloc>().state.assigneeSearchString),
        onSelected: (String id) => context.read<AddTaskBloc>()
          ..add(AssigneeIdOnChange(assigneeId: id))
          ..add(FocusingStatusOnChange(focusingStatus: FocusingStatus.none)),
      ),
    );
  }
}

class AssigneeListView extends StatelessWidget {
  const AssigneeListView({
    Key? key,
    required this.onSelected,
    required this.data,
  }) : super(key: key);

  final Function(String id) onSelected;
  final List<PublicUserInfo> data;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return data.isEmpty
        ? EmptyView()
        : ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () => onSelected(data[index].id),
              child: ListTile(
                leading: NetworkAvatar(
                  link: data[index].avatarLink,
                  height: 44.h,
                  width: 44.h,
                ),
                title: Text(data[index].email,
                    style: textTheme.subtitle1!.copyWith(fontSize: 16.sp)),
                subtitle: Text(
                  data[index].email,
                  style: textTheme.bodyText1!.copyWith(fontSize: 14.sp),
                ),
              ),
            ),
          );
  }
}

class ProjectSuggest extends StatelessWidget {
  const ProjectSuggest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DetailPanel(
      backgroundColor: ExpandedColor.fromHex("#F4F4F4"),
      child: ProjectListView(
        data: context.watch<FirestoreBloc<Project>>().allDoc.findByText(
            findKey: context.watch<AddTaskBloc>().state.projectSearchString),
        onSelected: (String id) => context.read<AddTaskBloc>()
          ..add(ProjectIdOnChange(projectId: id))
          ..add(FocusingStatusOnChange(focusingStatus: FocusingStatus.none)),
      ),
    );
  }
}

class ProjectListView extends StatelessWidget {
  const ProjectListView({
    Key? key,
    required this.data,
    required this.onSelected,
  }) : super(key: key);

  final List<Project> data;
  final Function(String id) onSelected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return data.isEmpty
        ? EmptyView()
        : ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () => onSelected(data[index].id),
              child: ListTile(
                leading: SvgPicture.asset(AssetPathConstants.tagIcon),
                title: Text(data[index].title,
                    style: textTheme.button),
              ),
            ),
          );
  }
}
