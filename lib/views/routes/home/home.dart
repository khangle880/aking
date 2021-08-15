import 'package:aking/logic/blocs/authentication/authentication_bloc.dart';
import 'package:aking/logic/blocs/task/task_bloc.dart';
import 'package:aking/logic/repositories/task/task_repository.dart';
import 'package:aking/logic/utils/modules/color_module.dart';
import 'package:aking/views/routes/exception/exception_page.dart';
import 'package:aking/views/routes/home/bottom_app_bar_navigation.dart';
import 'package:aking/views/routes/home/work_list/work_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tabSelected = 0;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTapped(int index) {
    setState(() {
      _tabSelected = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 100), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: EdgeInsets.only(top: 25.h),
        width: 50.w,
        child: FloatingActionButton(
            onPressed: () {},
            tooltip: "Add Button",
            elevation: 4.0,
            backgroundColor: hexToColor("#F96060"),
            child: Center(child: Icon(Icons.add))),
      ),
      bottomNavigationBar: FABBottomAppBar(
        items: [
          FABBottomAppBarItem(
              iconData: Icons.check_circle_rounded, text: 'My task'),
          FABBottomAppBarItem(iconData: Icons.grid_view_rounded, text: 'Menu'),
          FABBottomAppBarItem(
              iconData: Icons.event_note_outlined, text: 'Quick'),
          FABBottomAppBarItem(iconData: Icons.person, text: 'Profile'),
        ],
        centerItemText: '',
        height: 60.h,
        iconSize: 22.h,
        backgroundColor: hexToColor("#292E4E"),
        onTabSelected: _onTapped,
        selectedColor: hexToColor("#FFFFFF"),
        defaultColor: hexToColor("#8E8E93"),
        textStyle:
            Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12.sp),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<TaskBloc>(
              create: (_) => TaskBloc(taskRepository: TaskRepository())),
        ],
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: const <Widget>[
            WorkListPage(),
            ExceptionPage(),
            ExceptionPage(),
            ExceptionPage(),
          ],
        ),
      ),
    );
  }
}


// appBar: AppBar(
//         title: Text('Home'),
//         actions: <Widget>[
//           
//         ],
//       ),
//       body: Column(
//         children: <Widget>[
//           Center(
//             child: Text("Hello, ${user.email}"),
//           ),
//           TextButton(
//               onPressed: () {
//                 context
//                     .read<AuthenticationBloc>()
//                     .userRepository
//                     .updatePassword("a123123321", "a123123123");
//               },
//               child: Icon(Icons.add)),
//         ],
//       ),