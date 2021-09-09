import 'package:aking/global/constants/assets_path.dart';
import 'package:aking/logic/blocs/firestore/firestore_bloc.dart';
import 'package:aking/logic/blocs/task/get_task/task_bloc.dart';
import 'package:aking/logic/cubits/work_list/work_list_cubit.dart';
import 'package:aking/logic/models/project.dart';
import 'package:aking/logic/models/task.dart';
import 'package:aking/logic/utils/extensions/logic_extensions.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:aking/views/widgets/simple_rive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'components/month_tab_view.dart';
import 'components/task_menu_popup.dart';
import 'components/today_tab_view.dart';

class WorkListPage extends StatefulWidget {
  const WorkListPage({Key? key, this.byProjectId}) : super(key: key);

  final String? byProjectId;

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

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabList.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final Project? project = widget.byProjectId == null
        ? null
        : context
            .watch<FirestoreBloc<Project>>()
            .allDoc
            .findById(widget.byProjectId!);

    final textTheme = Theme.of(context).textTheme;
    return ProxyProvider<TaskBloc, WorkListCubit>(
      update: (context, value, previous) {
        final taskBlocState = value.state;
        final List<Task> tasks =
            (taskBlocState is FirestoreLoaded<Task>) ? taskBlocState.list : [];

        if (widget.byProjectId != null) {
          return WorkListCubit(tasks: tasks)
            ..filterByProject(widget.byProjectId!);
        } else {
          return WorkListCubit(tasks: tasks)..groupByDate();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: widget.byProjectId == null
              ? ExpandedColor.fromHex("#F96060")
              : ExpandedColor.fromHex(project!.hexColor),
          elevation: 2,
          iconTheme: IconThemeData(
            color: ExpandedColor.fromHex("#FFFFFF"),
          ),
          actions: const <Widget>[TaskMenuPopup()],
          title: Text(
            project == null ? 'Work List' : project.title,
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
        body: BlocBuilder<TaskBloc, FirestoreState<Task>>(
          builder: (context, state) {
            return TabBarView(
              controller: _tabController,
              children: [
                TodayTabView(
                    tasksByDate: context.watch<WorkListCubit>().tasksByDate),
                MonthTabView(
                    tasksByDate: context.watch<WorkListCubit>().tasksByDate),
              ],
            );
          },
        ),
      ),
    );
  }
}
