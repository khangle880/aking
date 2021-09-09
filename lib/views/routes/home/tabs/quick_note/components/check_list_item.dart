import 'package:aking/logic/blocs/authentication/authentication_bloc.dart';
import 'package:aking/logic/blocs/process_quick_note/process_quick_note_bloc.dart';
import 'package:aking/logic/models/check_list.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckListItem extends StatelessWidget {
  const CheckListItem({Key? key, required this.item}) : super(key: key);
  final CheckList item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 121.w,
          height: 3.h,
          color: ExpandedColor.fromHex(item.hexColor),
        ),
        SizedBox(height: 13.h),
        Text(
          item.title,
          style: textTheme.subtitle1!.copyWith(fontSize: 16.sp, height: 2),
        ),
        SizedBox(height: 8.h),
        ...item.list.map(
          (e) => TextButton(
            onPressed: () {
              context.read<ProcessQuickNoteBloc>().add(
                    UpdateCLItemCompleteStatus(
                      completeStatus: !e.isDone,
                      checkItem: e,
                      checkList: item,
                      uid: context.read<AuthenticationBloc>().uid!,
                    ),
                  );
            },
            child: Row(
              children: [
                SizedBox(
                  height: 12.w,
                  width: 12.w,
                  child: Checkbox(
                    value: e.isDone,
                    onChanged: (value) {
                      context.read<ProcessQuickNoteBloc>().add(
                            UpdateCLItemCompleteStatus(
                              completeStatus: !e.isDone,
                              checkItem: e,
                              checkList: item,
                              uid: context.read<AuthenticationBloc>().uid!,
                            ),
                          );
                    },
                    checkColor: ExpandedColor.fromHex("#979797"),
                    activeColor: ExpandedColor.fromHex("#979797"),
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  e.description,
                  style: e.isDone
                      ? textTheme.button!
                          .copyWith(decoration: TextDecoration.lineThrough)
                      : textTheme.button,
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
