import 'package:aking/logic/blocs/authentication/authentication_bloc.dart';
import 'package:aking/logic/blocs/process_quick_note/process_quick_note_bloc.dart';
import 'package:aking/logic/blocs/process_state.dart';
import 'package:aking/logic/models/check_list.dart';
import 'package:aking/logic/models/note.dart';
import 'package:aking/logic/models/quick_note.dart';
import 'package:aking/logic/repositories/firestore/quick_note_repository.dart';
import 'package:aking/views/routes/home/tabs/quick_note/components/quick_note_body.dart';
import 'package:aking/views/utils/extensions/flush_bar.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:aking/views/widgets/popup_menu.dart';
import 'package:aking/views/widgets/popup_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuickNoteItem extends StatelessWidget {
  const QuickNoteItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final QuickNote item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) =>
          ProcessQuickNoteBloc(context.read<QuickNoteRepository>()),
      child: BlocConsumer<ProcessQuickNoteBloc, ProcessState>(
        listener: (context, state) {
          if (state is Processing) {
            ExpandedFlushbar.loadingFlushbar(context, message: "Updating")
                .show(context);
          }
          if (state is ProcessFailure) {
            ExpandedFlushbar.failureFlushbar(context,
                    message: state.errorMessage)
                .show(context);
          }
          if (state is Processing) {
            ExpandedFlushbar.successFlushbar(context,
                    message: 'Update Successfully!')
                .show(context);
          }
        },
        builder: (context, state) {
          return CustomPopupMenuButton(
            menuItems: [
              CustomPopupMenuItem(
                  title: Text(
                    "Edit",
                    style: textTheme.subtitle2!.copyWith(fontSize: 15.sp),
                  ),
                  trailingIcon: Icon(Icons.edit, color: Colors.indigoAccent),
                  onPressed: () {}),
              CustomPopupMenuItem(
                  title: Text(
                    "Delete",
                    style: textTheme.subtitle2!.copyWith(fontSize: 15.sp),
                  ),
                  trailingIcon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {}),
            ],
            onPressed: () {},
            menuWidth: 180.w,
            menuItemExtent: 40.w,
            menuOffset: 0.w,
            menuBoxDecoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15.r))),
            duration: Duration(milliseconds: 200),
            blurSize: 0.1,
            blurBackgroundColor:
                ExpandedColor.fromHex("#000000").withOpacity(0.6),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8.h),
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              decoration: BoxDecoration(
                color: ExpandedColor.fromHex("#FFFFFF"),
                borderRadius: BorderRadius.circular(3.r),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(224, 224, 224, 0.5),
                    offset: Offset(5, 5),
                    blurRadius: 9.r,
                  )
                ],
              ),
              child: BodyItem(item: item),
            ),
          );
        },
      ),
    );
  }
}
