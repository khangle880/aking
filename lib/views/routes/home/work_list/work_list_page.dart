import 'package:aking/global/constants/assets_path.dart';
import 'package:aking/logic/blocs/authentication/authentication_bloc.dart';
import 'package:aking/logic/blocs/task/task_bloc.dart';
import 'package:aking/logic/blocs/tasks_group/tasks_group_bloc.dart';
import 'package:aking/logic/models/task_list.dart';
import 'package:aking/logic/utils/modules/color_module.dart';
import 'package:aking/views/widgets/popup_menu.dart';
import 'package:aking/views/widgets/popup_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'month_tab_view.dart';
import 'today_tab_view.dart';

class WorkListPage extends StatefulWidget {
  const WorkListPage({Key? key}) : super(key: key);

  @override
  _WorkListPageState createState() => _WorkListPageState();
}

class _WorkListPageState extends State<WorkListPage>
    with SingleTickerProviderStateMixin {
  static const List<Tab> _tabList = [
    Tab(text: "Today"),
    Tab(
      text: "Month",
    ),
  ];
  static const _menuList = {
    OptionTaskStatusFilter.incomplete: "Incomplete Tasks",
    OptionTaskStatusFilter.completed: "Completed Tasks",
    OptionTaskStatusFilter.none: "All Tasks",
  };

  late TabController _tabController;
  late OptionTaskStatusFilter _selectedMenuItem;

  @override
  void initState() {
    super.initState();
    context
        .read<TaskBloc>()
        .add(LoadTasks(context.read<AuthenticationBloc>().uid!));
    _selectedMenuItem = _menuList.entries.last.key;
    _tabController = TabController(length: _tabList.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (_) => TasksGroupBloc(),
      child: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is TaskLoaded) {
            context
                .read<TasksGroupBloc>()
                .add(TasksGroupByDate(tasks: state.tasks.list));
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            backgroundColor: hexToColor("#F96060"),
            elevation: 2,
            iconTheme: IconThemeData(color: hexToColor("#FFFFFF")),
            leading: IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(AuthenticationLoggedOut());
              },
            ),
            actions: (state is TaskLoaded)
                ? <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: CustomPopupMenuButton(
                        onPressed: () {},
                        menuItems: _menuList.entries
                            .map((e) => CustomPopupMenuItem(
                                title: Text(
                                  e.value,
                                  style: textTheme.subtitle2!
                                      .copyWith(fontSize: 17.sp),
                                ),
                                trailingIcon: _selectedMenuItem == e.key
                                    ? Padding(
                                        padding: EdgeInsets.only(bottom: 2.w),
                                        child: SvgPicture.asset(
                                          checkOutlineIcon,
                                          width: 16.w,
                                          color: hexToColor("#7ED321"),
                                        ),
                                      )
                                    : null,
                                onPressed: () {
                                  _handleSelectMenuItem(e.key, context);
                                }))
                            .toList(),
                        openWithTap: true,
                        menuWidth: 225.w,
                        menuItemExtent: 40.w,
                        menuOffset: -8.w,
                        animateMenuItems: false,
                        menuBoxDecoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        duration: Duration(milliseconds: 100),
                        blurSize: 0.0,
                        blurBackgroundColor:
                            hexToColor("#000000").withOpacity(0.4),
                        enableChildInPopup: false,
                        child: SvgPicture.asset(
                          tuneCircleIcon,
                          height: 20.h,
                        ),
                      ),
                    )
                  ]
                : null,
            title: Text(
              'Work List',
              style: textTheme.subtitle1!
                  .copyWith(color: Colors.white, fontSize: 20.sp),
            ),
            centerTitle: true,
            bottom: TabBar(
              tabs: _tabList,
              controller: _tabController,
              indicatorColor: Colors.white,
              indicatorWeight: 3.w,
              indicatorPadding: EdgeInsets.symmetric(horizontal: 50.w),
              labelStyle: textTheme.bodyText1!.copyWith(color: Colors.white),
            ),
            shadowColor: Color.fromRGBO(227, 227, 227, 0.5),
          ),
          body: TabBarView(
            controller: _tabController,
            children: const [
              TodayTabView(),
              MonthTabView(),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSelectMenuItem(
      OptionTaskStatusFilter value, BuildContext context) {
    if (_selectedMenuItem == value) return;
    setState(() {
      _selectedMenuItem = value;
    });
    context.read<TaskBloc>().add(FilterByStatusTasks(value));
  }
}
