import 'package:aking/logic/blocs/profile/profile_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DescriptionTextField extends StatelessWidget {
  const DescriptionTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: ListTile(
        trailing: Icon(Icons.flutter_dash),
        contentPadding: EdgeInsets.zero,
        title: TextFormField(
          textCapitalization: TextCapitalization.sentences,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          style: textTheme.subtitle1,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 10.h,
            ),
            hintText:
                context.watch<ProfileBloc>().state.userInfo.description != ""
                    ? context.watch<ProfileBloc>().state.userInfo.description
                    : "Your Description",
            hintStyle: textTheme.bodyText1!.toBlurColor(),
            enabledBorder: OutlineInputBorder(
              gapPadding: 10,
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              gapPadding: 10,
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
          initialValue: context.watch<ProfileBloc>().state.description,
          onChanged: (value) => context
              .read<ProfileBloc>()
              .add(DescriptionOnChange(description: value)),
        ),
      ),
    );
  }
}
