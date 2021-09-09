import 'package:aking/logic/blocs/firestore/firestore_bloc.dart';
import 'package:aking/logic/models/project.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/open_form_button.dart';
import 'components/project_item.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final allProject = context.watch<FirestoreBloc<Project>>().allDoc;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(52.h),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(227, 227, 227, 0.5),
                offset: Offset(0, 2.0),
                blurRadius: 10.r,
              )
            ]),
            child: AppBar(
              elevation: 0,
              backgroundColor: ExpandedColor.fromHex("#FFFFFF"),
              title: Text(
                'Projects',
                style: textTheme.subtitle1!.copyWith(
                    color: ExpandedColor.fromHex("#313131"), fontSize: 20.sp),
              ),
              centerTitle: true,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Wrap(
              runSpacing: 24.h,
              spacing: 13.w,
              children: [
                ...allProject.map((e) => ProjectItem(item: e)).toList(),
                Container(
                  padding: EdgeInsets.only(bottom: 85.h, right: 100.w),
                  child: OpenFormButton(),
                ),
              ],
            ),
          ),
        ));
  }
}
