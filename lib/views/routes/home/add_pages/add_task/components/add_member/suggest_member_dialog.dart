import 'package:aking/logic/blocs/task/add_task/add_task_bloc.dart';
import 'package:aking/logic/blocs/firestore/firestore_bloc.dart';
import 'package:aking/logic/models/public_user_info.dart';
import 'package:aking/views/routes/home/add_pages/add_task/components/detail_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:aking/logic/utils/extensions/list_extensions.dart';

class SuggestMemberDialog extends StatefulWidget {
  const SuggestMemberDialog({
    Key? key,
    required this.parentContext,
    required this.listMemberKey,
  }) : super(key: key);

  final BuildContext parentContext;
  final GlobalKey<AnimatedListState> listMemberKey;

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
                onSelected: (String userInfo) {
                  widget.parentContext
                      .read<AddTaskBloc>()
                      .add(AddMemberToList(memberId: userInfo));
                  widget.listMemberKey.currentState!.insertItem(
                      (widget.parentContext.read<AddTaskBloc>().state.members ??
                              [])
                          .length);
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
