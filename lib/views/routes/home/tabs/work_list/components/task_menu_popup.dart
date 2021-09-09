import 'package:aking/global/constants/assets_path.dart';
import 'package:aking/logic/blocs/firestore/firestore_bloc.dart';
import 'package:aking/logic/blocs/task/get_task/task_bloc.dart';
import 'package:aking/logic/models/task.dart';
import 'package:aking/logic/utils/extensions/logic_extensions.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:aking/views/widgets/popup_menu.dart';
import 'package:aking/views/widgets/popup_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class TaskMenuPopup extends StatefulWidget {
  const TaskMenuPopup({Key? key}) : super(key: key);

  @override
  _TaskMenuPopupState createState() => _TaskMenuPopupState();
}

class _TaskMenuPopupState extends State<TaskMenuPopup> {
  static const _menuList = {
    OptionTaskStatusFilter.incomplete: "Incomplete Tasks",
    OptionTaskStatusFilter.completed: "Completed Tasks",
    OptionTaskStatusFilter.none: "All Tasks",
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: BlocBuilder<TaskBloc, FirestoreState<Task>>(
        builder: (context, state) {
          final _selectedMenuItem = state is TaskFiltered
              ? state.optionFilter
              : _menuList.entries.last.key;
          return CustomPopupMenuButton(
            onPressed: () {},
            menuItems: _menuList.entries
                .map(
                  (e) => CustomPopupMenuItem(
                    title: Text(
                      e.value,
                      style: textTheme.subtitle2!.copyWith(fontSize: 17.sp),
                    ),
                    trailingIcon: _selectedMenuItem == e.key
                        ? Padding(
                            padding: EdgeInsets.only(bottom: 2.w),
                            child: SvgPicture.asset(
                              AssetPathConstants.checkOutlineIcon,
                              width: 16.w,
                              color: ExpandedColor.fromHex("#7ED321"),
                            ),
                          )
                        : null,
                    onPressed: () {
                      if (_selectedMenuItem != e.key) {
                        // Navigator.of(context, rootNavigator: true).pop();
                        Future.delayed(
                          Duration(milliseconds: 400),
                          () => context.read<TaskBloc>().add(
                                FilterByStatusTasks(e.key),
                              ),
                        );
                      }
                    },
                  ),
                )
                .toList(),
            openWithTap: true,
            menuWidth: 225.w,
            menuItemExtent: 40.w,
            menuOffset: -8.w,
            animateMenuItems: false,
            menuBoxDecoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15.r))),
            duration: Duration(milliseconds: 100),
            blurSize: 0.0,
            blurBackgroundColor:
                ExpandedColor.fromHex("#000000").withOpacity(0.4),
            enableChildInPopup: false,
            child: SvgPicture.asset(
              AssetPathConstants.tuneCircleIcon,
              height: 20.h,
            ),
          );
        },
      ),
    );
  }
}
