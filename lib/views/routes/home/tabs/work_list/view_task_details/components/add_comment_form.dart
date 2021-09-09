import 'package:aking/global/constants/assets_path.dart';
import 'package:aking/logic/blocs/add_comment/add_comment_bloc.dart';
import 'package:aking/logic/blocs/process_state.dart';
import 'package:aking/logic/repositories/firestore/comment_repository.dart';
import 'package:aking/logic/repositories/user_repository.dart';
import 'package:aking/views/utils/extensions/flush_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddCommentForm extends StatelessWidget {
  const AddCommentForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider<AddCommentBloc>(
      create: (_) => AddCommentBloc(
        commentRepository: context.read<CommentRepository>(),
        userRepo: context.read<UserRepository>(),
      ),
      child: BlocConsumer<AddCommentBloc, AddCommentState>(
        listener: (context, state) {
          final addStatus = state.addStatus;
          if (addStatus is Processing) {
            ExpandedFlushbar.loadingFlushbar(context, message: "Loading...")
                .show(context);
          }
          if (addStatus is ProcessFailure) {
            ExpandedFlushbar.failureFlushbar(context,
                    message: addStatus.errorMessage)
                .show(context);
          }
          if (addStatus is ProcessSuccess) {
            ExpandedFlushbar.successFlushbar(context,
                    message: 'Add Comment Successfully!')
                .show(context);
          }
        },
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              border: Border.all(
                color: ExpandedColor.fromHex("#EAEAEA"),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: 3,
                    initialValue: context.read<AddCommentBloc>().state.content,
                    decoration: InputDecoration(
                      hintText: "Write a comment",
                      hintStyle: textTheme.button!.copyWith(
                        color: ExpandedColor.fromHex("#D8D8D8"),
                      ),
                    ).toNoneBorder(),
                    onChanged: (value) {
                      context.read<AddCommentBloc>().add(
                            ContentOnChange(content: value),
                          );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  color: ExpandedColor.fromHex("#F8F8F8"),
                  height: 48.h,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          context.read<AddCommentBloc>().add(ShowImagePicker());
                        },
                        child: SvgPicture.asset(AssetPathConstants.imageIcon),
                      ),
                      SizedBox(width: 20.w),
                      SvgPicture.asset(AssetPathConstants.attachIcon),
                      SizedBox(width: 20.w),
                      if (state.imagePath != "")
                        SizedBox(
                          height: 30.h,
                          child: CachedNetworkImage(
                            imageUrl: state.imagePath,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          context.read<AddCommentBloc>().add(SendComment());
                        },
                        child: Text(
                          'Send',
                          style: textTheme.subtitle1!.copyWith(
                              color: ExpandedColor.fromHex("#6074F9")),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
