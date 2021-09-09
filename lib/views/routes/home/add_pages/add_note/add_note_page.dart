import 'package:aking/logic/blocs/add_note/add_note_bloc.dart';
import 'package:aking/logic/repositories/firestore/quick_note_repository.dart';
import 'package:aking/logic/repositories/user_repository.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/add_note_form.dart';


class AddNotePage extends StatefulWidget {
  const AddNotePage({Key? key}) : super(key: key);

  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ExpandedColor.fromHex("#F96060"),
        title: Text(
          'Add Note',
          style: textTheme.subtitle1!
              .copyWith(color: Colors.white, fontSize: 20.sp),
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Container(
                height: 44.h,
                color: ExpandedColor.fromHex("#F96060"),
              ),
              Spacer(),
              Container(
                height: 60.h,
                color: ExpandedColor.fromHex("#292E4E"),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
            child: Container(
              // height: 700.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9.r),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(3.h, 3.h),
                    color: Color.fromRGBO(221, 221, 221, 0.5),
                    blurRadius: 3.w,
                  )
                ],
              ),
              child: BlocProvider<AddNoteBloc>(
                  create: (_) => AddNoteBloc(
                      quickNoteRepository: context.read<QuickNoteRepository>(),
                      userRepo: context.read<UserRepository>()),
                  child: AddNoteForm()),
            ),
          )
        ],
      ),
    );
  }
}

