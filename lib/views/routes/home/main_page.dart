import 'package:aking/global/constants/assets_path.dart';
import 'package:aking/routing/app_routes.dart';
import 'package:aking/routing/routes.dart';
import 'package:aking/views/widgets/simple_rive_widget.dart';
import 'package:flutter/material.dart';
import 'package:aking/logic/blocs/firestore/firestore_bloc.dart';
import 'package:aking/logic/blocs/task/task_bloc.dart';
import 'package:aking/logic/models/project.dart';
import 'package:aking/logic/models/public_user_info.dart';
import 'package:aking/logic/models/quick_note.dart';
import 'package:aking/logic/models/task.dart';
import 'package:aking/logic/repositories/firestore/project_repository.dart';
import 'package:aking/logic/repositories/firestore/public_user_info_repository.dart';
import 'package:aking/logic/repositories/firestore/quick_note_repository.dart';
import 'package:aking/logic/repositories/firestore/task_repository.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _statusList = List.generate(4, (index) => false);
  void changeStatusLoading(int index) {
    setState(() {
      _statusList[index] = false;
    });
  }

  void changeStatusLoaded(int index) {
    setState(() {
      _statusList[index] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskBloc>(
          create: (_) => TaskBloc(taskRepository: TaskRepository())
            ..add(LoadFirestore<Task>(widget.uid)),
          lazy: false,
        ),
        BlocProvider<FirestoreBloc<PublicUserInfo>>(
          create: (_) =>
              FirestoreBloc<PublicUserInfo>(PublicUserInfoRepository())
                ..add(LoadFirestore<PublicUserInfo>(widget.uid)),
          lazy: false,
        ),
        BlocProvider<FirestoreBloc<Project>>(
          create: (_) => FirestoreBloc<Project>(ProjectRepository())
            ..add(LoadFirestore<Project>(widget.uid)),
          lazy: false,
        ),
        BlocProvider<FirestoreBloc<QuickNote>>(
          create: (_) => FirestoreBloc<QuickNote>(QuickNoteRepository())
            ..add(LoadFirestore<QuickNote>(widget.uid)),
          lazy: false,
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<TaskBloc, FirestoreState<Task>>(
            listener: (context, state) {
              if (state is FirestoreLoaded<Task>) {
                changeStatusLoaded(0);
              } else {
                changeStatusLoading(0);
              }
            },
          ),
          BlocListener<FirestoreBloc<Project>, FirestoreState<Project>>(
            listener: (context, state) {
              if (state is FirestoreLoaded<Project>) {
                changeStatusLoaded(1);
              } else {
                changeStatusLoading(1);
              }
            },
          ),
          BlocListener<FirestoreBloc<PublicUserInfo>,
              FirestoreState<PublicUserInfo>>(
            listener: (context, state) {
              if (state is FirestoreLoaded<PublicUserInfo>) {
                changeStatusLoaded(2);
              } else {
                changeStatusLoading(2);
              }
            },
          ),
          BlocListener<FirestoreBloc<QuickNote>, FirestoreState<QuickNote>>(
            listener: (context, state) {
              if (state is FirestoreLoaded<QuickNote>) {
                changeStatusLoaded(3);
              } else {
                changeStatusLoading(3);
              }
            },
          ),
        ],
        child: _statusList.contains(false)
            ? Center(
                child: SimpleRiveWidget(
                  rivePath: loader1Rive,
                  simpleAnimation: loader1SimpleAnimation,
                  width: 90.w,
                  height: 90.h,
                ),
              )
            : Navigator(
                key: AppRoutes.mainNav,
                initialRoute: MainRouteNames.initHomeRoute,
                onGenerateRoute: AppRoutes.onGenerateMainRoute,
              ),
      ),
    );
  }
}
