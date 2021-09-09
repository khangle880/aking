import 'package:aking/global/constants/assets_path.dart';
import 'package:aking/logic/blocs/firestore/firestore_bloc.dart';
import 'package:aking/logic/blocs/task/process_task/process_task_bloc.dart';
import 'package:aking/logic/models/comment.dart';
import 'package:aking/logic/models/public_user_info.dart';
import 'package:aking/logic/models/task.dart';
import 'package:aking/logic/repositories/firestore/comment_repository.dart';
import 'package:aking/views/utils/extensions/flush_bar.dart';
import 'package:aking/views/widgets/network_avatar.dart';
import 'package:aking/views/widgets/rounded_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:aking/logic/utils/extensions/logic_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'add_comment_form.dart';
import 'show_comments.dart';

class MoreDetailBody extends StatefulWidget {
  const MoreDetailBody({
    Key? key,
    required this.task,
  }) : super(key: key);
  final Task task;

  @override
  _MoreDetailBodyState createState() => _MoreDetailBodyState();
}

class _MoreDetailBodyState extends State<MoreDetailBody> {
  bool showMore = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Wrap(
      children: [
        if (showMore) _buildCommentList(),
        RoundedButton(
          text: "Complete Task",
          onPressed: () {
            if (widget.task.isDone) {
              ExpandedFlushbar.failureFlushbar(context, message: "Task is done")
                  .show(context);
            } else {
              Navigator.of(context).pop();
              Future.delayed(
                Duration(milliseconds: 200),
                () {
                  context.read<ProcessTaskBloc>().add(UpdateCompleteStatus(
                      completeStatus: true, id: widget.task.id));
                },
              );
            }
          },
          backgroundColor: ExpandedColor.fromHex("#6074F9"),
        ),
        SizedBox(height: 16.h, width: double.infinity),
        if (!showMore)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            child: TextButton(
              onPressed: () {
                setState(() {
                  showMore = true;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Comment",
                    style: textTheme.subtitle1!.copyWith(fontSize: 17.sp),
                  ),
                  SizedBox(width: 10.w),
                  SvgPicture.asset(AssetPathConstants.seeMoreIcon),
                ],
              ),
            ),
          ),
        SizedBox(height: 20.h, width: double.infinity),
      ],
    );
  }

  Widget _buildCommentList() {
    return RepositoryProvider(
      create: (context) => CommentRepository(id: widget.task.id),
      child: BlocProvider<FirestoreBloc<Comment>>(
        create: (context) =>
            FirestoreBloc<Comment>(context.read<CommentRepository>())
              ..add(LoadFirestore("")),
        child: BlocBuilder<FirestoreBloc<Comment>, FirestoreState<Comment>>(
          builder: (context, state) {
            if (state is FirestoreLoaded<Comment>) {
              final textTheme = Theme.of(context).textTheme;
              return Wrap(
                children: [
                  AddCommentForm(),
                  SizedBox(height: 36.h, width: double.infinity),
                  ShowComment(allComment: state.list),
                  SizedBox(height: 12.h, width: double.infinity),
                ],
              );
            } else {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                    ],
                  ),
                  SizedBox(height: 24.h, width: double.infinity),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}


