import 'package:aking/logic/blocs/task/add_task/add_task_bloc.dart';
import 'package:aking/logic/blocs/firestore/firestore_bloc.dart';
import 'package:aking/logic/models/public_user_info.dart';
import 'package:aking/logic/utils/modules/color_module.dart';
import 'package:aking/views/routes/home/add_pages/add_task/components/detail_panel.dart';
import 'package:aking/views/widgets/network_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:aking/logic/utils/extensions/list_extensions.dart';

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
        SizedBox(height: 10.h),
        BlocBuilder<AddTaskBloc, AddTaskState>(
          builder: (context, state) => SizedBox(
            height: 32.w,
            child: ListView(
              controller: _scrollController,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: _buildListMember(state.members, context),
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
            .watch<FirestoreBloc<PublicUserInfo>>()
            .allDoc
            .findById(memberId) as PublicUserInfo?;
        if (memberInfo != null) {
          memberWidgets
            ..add(NetworkAvatar(
              link: memberInfo.avatarLink,
              placehouderText: memberInfo.name,
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
                useRootNavigator: false,
                builder: (_) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                    child: SuggestMemberDialog(
                      parentContext: context,
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

class SuggestMemberDialog extends StatefulWidget {
  const SuggestMemberDialog({
    Key? key,
    required this.parentContext,
  }) : super(key: key);

  final BuildContext parentContext;

  @override
  _SuggestMemberDialogState createState() => _SuggestMemberDialogState();
}

class _SuggestMemberDialogState extends State<SuggestMemberDialog> {
  String _searchString = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocProvider.value(
        value: BlocProvider.of<FirestoreBloc<PublicUserInfo>>(
            widget.parentContext),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 5.h),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 15.h,
                horizontal: 18.w,
              ),
              child: TextField(
                textInputAction: TextInputAction.search,
                onChanged: (value) {
                  setState(() {
                    _searchString = value;
                  });
                },
                style: Theme.of(widget.parentContext).textTheme.subtitle2,
                decoration: InputDecoration(
                  hintText: "Search",
                  contentPadding: EdgeInsets.zero,
                  prefixIcon: Icon(Icons.search_outlined),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 350.w,
              child: AssigneeListView(
                onSelected: (String id) {
                  widget.parentContext
                      .read<AddTaskBloc>()
                      .add(AddMemberToList(memberId: id));
                  Navigator.pop(widget.parentContext);
                },
                data: _getData(widget.parentContext),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PublicUserInfo> _getData(BuildContext context) {
    final allDoc = context.read<FirestoreBloc<PublicUserInfo>>().allDoc;
    final members = context.read<AddTaskBloc>().state.members ?? [];

    return allDoc
        .findByText(findKey: _searchString)
        .where((element) => !members.contains(element.id))
        .toList();
  }
}
