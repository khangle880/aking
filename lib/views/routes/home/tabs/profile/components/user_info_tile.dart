import 'package:aking/logic/blocs/profile/profile_bloc.dart';
import 'package:aking/views/routes/home/tabs/profile/components/change_avatar_button.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:aking/views/widgets/network_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'descr_text_field.dart';
import 'name_text_field.dart';

class UserInfoTile extends StatelessWidget {
  const UserInfoTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            textColor: Colors.black,
            trailing: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            title: Row(
              children: <Widget>[
                SizedBox(width: 1.w),
                NetworkAvatar(
                  link: state.userInfo.avatarLink,
                  width: 64.h,
                  height: 64.h,
                ),
                SizedBox(width: 10.w),
                SizedBox(
                  width: 180.w,
                  child: ListTile(
                    title: Text(
                      state.userInfo.name,
                      style: textTheme.subtitle1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      state.userInfo.email,
                      style: textTheme.button!.toBlurColor(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            ),
            childrenPadding: EdgeInsets.symmetric(horizontal: 10.w),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  ChangeAvatarButton(),
                  Spacer(),
                  NameTextField(),
                ],
              ),
              DescriptionTextField(),
              SizedBox(
                width: 150.w,
                child: TextButton(
                  onPressed: () {
                    context.read<ProfileBloc>().add(SaveProfile());
                  },
                  child: Text(
                    "Save Info",
                    textAlign: TextAlign.center,
                    style: textTheme.subtitle1!.copyWith(
                      fontSize: 16.sp,
                      color: ExpandedColor.fromHex("#F96969"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
