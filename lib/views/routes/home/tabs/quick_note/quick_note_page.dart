import 'package:aking/global/constants/assets_path.dart';
import 'package:aking/logic/blocs/firestore/firestore_bloc.dart';
import 'package:aking/logic/models/quick_note.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:aking/views/widgets/simple_rive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/quick_note_item.dart';

class QuickNotePage extends StatefulWidget {
  const QuickNotePage({Key? key}) : super(key: key);

  @override
  _QuickNotePageState createState() => _QuickNotePageState();
}

class _QuickNotePageState extends State<QuickNotePage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
              'Quick Notes',
              style: textTheme.subtitle1!.copyWith(
                  color: ExpandedColor.fromHex("#313131"), fontSize: 20.sp),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: BlocBuilder<FirestoreBloc<QuickNote>, FirestoreState<QuickNote>>(
        builder: (context, state) {
          if (state is FirestoreLoaded<QuickNote>) {
            final list = state.list;
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return QuickNoteItem(item: list[index]);
                },
              ),
            );
          } else {
            return Center(
              child: SimpleRiveWidget(
                rivePath: AssetPathConstants.splashRive,
                simpleAnimation: AssetPathConstants.splashSimpleAnimation,
                width: 149.w,
                height: 149.w,
              ),
            );
          }
        },
      ),
    );
  }
}
