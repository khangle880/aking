import 'package:aking/logic/blocs/profile/profile_bloc.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangeAvatarButton extends StatelessWidget {
  const ChangeAvatarButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: 72.w,
      child: TextButton(
        onPressed: () {
          context.read<ProfileBloc>().add(RequestChangeAvatar());
        },
        child: Text(
          "Change Avatar",
          textAlign: TextAlign.center,
          style: textTheme.subtitle1!.copyWith(
            fontSize: 16.sp,
            color: ExpandedColor.fromHex("#6074F9"),
          ),
        ),
      ),
    );
  }
}
