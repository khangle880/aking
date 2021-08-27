import 'package:aking/logic/blocs/firestore/firestore_bloc.dart';
import 'package:aking/logic/models/public_user_info.dart';
import 'package:aking/logic/provider/add_task.dart';
import 'package:aking/logic/utils/modules/color_module.dart';
import 'package:aking/views/routes/home/add_pages/add_task/components/detail_panel.dart';
import 'package:aking/views/widgets/network_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:aking/logic/utils/extensions/list_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddMember extends StatefulWidget {
  const AddMember({Key? key}) : super(key: key);

  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 26.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Add Member",
          style: textTheme.bodyText1!.copyWith(fontSize: 16.sp),
        ),
        Consumer<AddTaskProvider>(
          builder: (context, value, child) => SizedBox(
            height: 32.w,
            child: ListView(
              controller: _scrollController,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: _buildListMember(value.members, context),
            ),
          ),
        )
      ]),
    );
  }

  List<Widget> _buildListMember(List<String>? members, BuildContext context) {
    final List<Widget> memberWidgets = [];
    if (members != null) {
      for (final memberId in members) {
        final memberInfo = context
            .read<FirestoreBloc<PublicUserInfo>>()
            .allDoc
            .findById(memberId) as PublicUserInfo?;
        if (memberInfo != null) {
          memberWidgets
            ..add(NetworkAvatar(
              link: memberInfo.avatarLink,
              errorText: memberInfo.name,
              height: 32.h,
              width: 32.w,
            ))
            ..add(SizedBox(width: 5.w));
        }
      }
    }

    memberWidgets.add(
      SizedBox(
        width: 32.w,
        height: 32.h,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.r),
            color: hexToColor("#CCCCCC"),
          ),
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (popContext) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.r)),
                    child: SizedBox(
                      height: 450.w,
                      child: AssigneeListView(),
                    ),
                  );
                },
              ).then((value) {
                Future.delayed(
                    Duration(milliseconds: 100),
                    () => _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 300),
                        ));
                context
                    .read<AddTaskProvider>()
                    .addMember("K2QEkmiYbzTkyELX6ba9JQgODo72");
              });
            },
            child: Icon(Icons.add, color: hexToColor("#FFFFFF")),
          ),
        ),
      ),
    );
    return memberWidgets;
  }
}
