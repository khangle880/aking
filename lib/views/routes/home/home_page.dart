import 'package:aking/global/constants/app_constants.dart';
import 'package:aking/views/routes/home/tabs/profile/profile_page.dart';
import 'package:aking/views/routes/home/tabs/quick_note/quick_note_page.dart';

import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:aking/views/routes/exception/exception_page.dart';
import 'package:aking/views/routes/home/add_menu.dart';
import 'package:aking/views/routes/home/bottom_app_bar_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'tabs/menu/project_navigator.dart';
import 'tabs/work_list/work_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 100), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () => _showAddMenu(),
        child: Container(
          margin: EdgeInsets.only(top: 15.h),
          height: 56.h,
          width: 56.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
            gradient: ColorConstants.kPrimaryGradientColor,
          ),
          child: Icon(
            Icons.add,
            color: ExpandedColor.fromHex("#FFFFFF"),
          ),
        ),
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
        notchedShape: CircularNotchedRectangle(),
        centerItemText: '',
        height: 70.h,
        iconSize: 22.h,
        backgroundColor: ExpandedColor.fromHex("#292E4E"),
        onTabSelected: _onTapped,
        selectedColor: ExpandedColor.fromHex("#FFFFFF"),
        selectedBarColor: ExpandedColor.fromHex("#F96060"),
        defaultColor: ExpandedColor.fromHex("#8E8E93"),
        textStyle:
            Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12.sp),
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: const <Widget>[
          WorkListPage(),
          ProjectNav(),
          QuickNotePage(),
          ProfilePage(),
        ],
      ),
    );
  }

  void _showAddMenu() {
    showDialog(
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.4),
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
          backgroundColor: Colors.white,
          child: AddMenu(),
        );
      },
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