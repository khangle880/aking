import 'package:aking/logic/blocs/firestore/firestore_bloc.dart';
import 'package:aking/logic/blocs/process_firestore_doc/process_firestore_doc_bloc.dart';
import 'package:aking/logic/blocs/process_state.dart';
import 'package:aking/logic/models/comment.dart';
import 'package:aking/logic/models/public_user_info.dart';
import 'package:aking/logic/repositories/firestore/comment_repository.dart';
import 'package:aking/views/utils/extensions/flush_bar.dart';
import 'package:aking/views/widgets/network_avatar.dart';
import 'package:aking/views/widgets/popup_menu.dart';
import 'package:aking/views/widgets/popup_menu_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:aking/logic/utils/extensions/logic_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

class ShowComment extends StatelessWidget {
  const ShowComment({
    Key? key,
    required this.allComment,
  }) : super(key: key);
  final List<Comment> allComment;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) =>
          ProcessFSDocBloc<Comment>(context.read<CommentRepository>()),
      child: BlocConsumer<ProcessFSDocBloc<Comment>, ProcessState>(
        listener: (context, state) {
          if (state is Processing) {
            ExpandedFlushbar.loadingFlushbar(context, message: "Loading...")
                .show(context);
          }
          if (state is ProcessFailure) {
            ExpandedFlushbar.failureFlushbar(context,
                    message: state.errorMessage)
                .show(context);
          }
          if (state is ProcessSuccess) {
            ExpandedFlushbar.successFlushbar(context, message: 'Successfully!')
                .show(context);
          }
        },
        builder: (context, state) {
          return Wrap(
            children: [
              ...allComment.map(
                (e) {
                  final userInfo = context
                          .read<FirestoreBloc<PublicUserInfo>>()
                          .allDoc
                          .findById(e.creatorId) ??
                      PublicUserInfo(
                        id: "",
                        email: "Not Found",
                        name: "Not Found",
                        avatarLink: "",
                        status: false,
                        description: "Not Found",
                      );
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          NetworkAvatar(
                            link: userInfo.avatarLink,
                            width: 32.h,
                            height: 32.h,
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userInfo.name,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.subtitle1,
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                timeago.format(e.createdDate).toString(),
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.bodyText1!
                                    .copyWith(fontSize: 14.sp)
                                    .toBlurColor(),
                              ),
                            ],
                          ),
                          Spacer(),
                          CustomPopupMenuButton(
                            menuItems: [
                              CustomPopupMenuItem(
                                title: Text(
                                  "Delete",
                                  style: textTheme.subtitle2!
                                      .copyWith(fontSize: 15.sp),
                                ),
                                trailingIcon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  context
                                      .read<ProcessFSDocBloc<Comment>>()
                                      .add(DeleteFSDoc<Comment>(docId: e.id));
                                },
                              ),
                            ],
                            onPressed: () {},
                            openWithTap: true,
                            menuWidth: 165.w,
                            menuItemExtent: 40.w,
                            menuOffset: 8.w,
                            menuBoxDecoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.r))),
                            duration: Duration(milliseconds: 200),
                            blurSize: 0.1,
                            blurBackgroundColor:
                                ExpandedColor.fromHex("#000000")
                                    .withOpacity(0.6),
                            child: Icon(Icons.more_horiz),
                          )
                        ],
                      ),
                      SizedBox(height: 9.h),
                      if (e.content != null && e.content != "")
                        Text(
                          e.content!,
                          style: textTheme.button,
                        ),
                      if (e.imageLink != null && e.imageLink != "") ...[
                        SizedBox(height: 9.h),
                        CachedNetworkImage(
                          imageUrl: e.imageLink!,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ],
                      if ((e.content == null || e.content == "") &&
                          (e.imageLink == null || e.imageLink == ""))
                        Text(
                          "No comment",
                          style: textTheme.button,
                        ),
                      SizedBox(height: 24.h),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
