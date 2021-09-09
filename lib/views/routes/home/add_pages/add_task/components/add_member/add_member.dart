import 'package:aking/logic/blocs/task/add_task/add_task_bloc.dart';
import 'package:aking/logic/blocs/firestore/firestore_bloc.dart';
import 'package:aking/logic/models/public_user_info.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:aking/views/widgets/network_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:aking/logic/utils/extensions/list_extensions.dart';

import 'suggest_member_dialog.dart';

class AddMember extends StatefulWidget {
  const AddMember({Key? key}) : super(key: key);

  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 26.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add Member",
            style: textTheme.button,
          ),
          SizedBox(height: 10.h),
          BlocBuilder<AddTaskBloc, AddTaskState>(
            builder: (context, state) => SizedBox(
              height: 37.h,
              child: AnimatedList(
                controller: _scrollController,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                key: _listKey,
                initialItemCount: (state.members ?? []).length + 1,
                itemBuilder: _buildItem,
                // children: _buildListMember(state.members, context),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    final members = context.watch<AddTaskBloc>().state.members ?? [];
    final membersLength = members.length;

    if (membersLength > index) {
      final memberInfo = context
          .watch<FirestoreBloc<PublicUserInfo>>()
          .allDoc
          .findById(members[index]);
      return InkWell(
        onTap: () {
          context.read<AddTaskBloc>().add(RemoveMemberToList(
              memberId: memberInfo != null ? memberInfo.id : ''));
          _listKey.currentState!.removeItem(
            index,
            (BuildContext context, Animation<double> animation) {
              return _buildMemberItem(animation, memberInfo);
            },
          );
        },
        child: _buildMemberItem(animation, memberInfo),
      );
    } else {
      return Padding(padding: EdgeInsets.all(2.5.h), child: _buildAddButon());
    }
  }

  Widget _buildMemberItem(
      Animation<double> animation, PublicUserInfo? memberInfo) {
    return ScaleTransition(
      scale: animation,
      child: Padding(
        padding: EdgeInsets.all(2.5.h),
        child: memberInfo == null
            ? NetworkAvatar(
                link: "",
                placehouderText: "",
                height: 32.h,
                width: 32.h,
              )
            : NetworkAvatar(
                link: memberInfo.avatarLink,
                placehouderText: memberInfo.name,
                height: 32.h,
                width: 32.h,
              ),
      ),
    );
  }

  Widget _buildAddButon() {
    return SizedBox(
      width: 32.w,
      height: 32.h,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          color: ExpandedColor.fromHex("#CCCCCC"),
        ),
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              useRootNavigator: false,
              builder: (_) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r)),
                  child: SuggestMemberDialog(
                    parentContext: context,
                    listMemberKey: _listKey,
                  ),
                );
              },
            ).then((value) {
              Future.delayed(
                  Duration(milliseconds: 200),
                  () => _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 300),
                      ));
            });
          },
          child: Icon(Icons.add, color: ExpandedColor.fromHex("#FFFFFF")),
        ),
      ),
    );
  }
}

// List<Widget> _buildListMember(List<String>? members, BuildContext context) {
  //   final List<Widget> memberWidgets = [];
  //   if (members != null) {
  //     for (final memberId in members) {
  //       final memberInfo = context
  //           .watch<FirestoreBloc<PublicUserInfo>>()
  //           .allDoc
  //           .findById(memberId) as PublicUserInfo?;
  //       if (memberInfo != null) {
  //         memberWidgets
  //           ..add(NetworkAvatar(
  //             link: memberInfo.avatarLink,
  //             placehouderText: memberInfo.name,
  //             height: 32.h,
  //             width: 32.w,
  //           ))
  //           ..add(SizedBox(width: 5.w));
  //       }
  //     }
  //   }

  //   memberWidgets.add(_buildAddButon());
  //   return memberWidgets;
  // }