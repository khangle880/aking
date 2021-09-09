import 'dart:developer';

import 'package:aking/logic/blocs/authentication/authentication_bloc.dart';
import 'package:aking/logic/blocs/firestore/firestore_bloc.dart';
import 'package:aking/logic/blocs/process_state.dart';
import 'package:aking/logic/blocs/profile/profile_bloc.dart';
import 'package:aking/logic/models/public_user_info.dart';
import 'package:aking/logic/repositories/firestore/public_user_info_repository.dart';
import 'package:aking/views/utils/extensions/flush_bar.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'components/task_counter.dart';
import 'components/work_list_counter.dart';
import 'components/work_list_statistic.dart';
import 'components/user_info_tile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (_) => ProfileBloc(
          publicUserInfoBloc: context.read<FirestoreBloc<PublicUserInfo>>(),
          uid: context.watch<AuthenticationBloc>().uid!,
          publicUserInfoRepository: context.read<PublicUserInfoRepository>()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(52.h),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(227, 227, 227, 0.5),
                offset: Offset(0, 2.0),
                blurRadius: 10.r,
              )
            ]),
            child: AppBar(
              actions: [
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(AuthenticationLoggedOut());
                  },
                ),
              ],
              elevation: 0,
              backgroundColor: ExpandedColor.fromHex("#FFFFFF"),
              title: Text(
                'Profiles',
                style: textTheme.subtitle1!.copyWith(
                    color: ExpandedColor.fromHex("#313131"), fontSize: 20.sp),
              ),
              centerTitle: true,
            ),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(
            vertical: 24.h,
            horizontal: 16.w,
          ),
          children: [
            BlocListener<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state.imageSourceSheetIsVisible) {
                  _showImageSourceBottomSheet(context);
                }
                final formStatus = state.formStatus;
                if (formStatus is Processing) {
                  ExpandedFlushbar.loadingFlushbar(context, message: "Updating")
                      .show(context);
                }
                if (formStatus is ProcessFailure) {
                  ExpandedFlushbar.failureFlushbar(context,
                          message: formStatus.errorMessage)
                      .show(context);
                }
                if (formStatus is ProcessSuccess) {
                  log("here");
                  ExpandedFlushbar.successFlushbar(context,
                          message: 'Update Successfully!')
                      .show(context);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                decoration: BoxDecoration(
                  color: ExpandedColor.fromHex("#FFFFFF"),
                  borderRadius: BorderRadius.circular(3.r),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(224, 224, 224, 0.5),
                      offset: Offset(0, 2),
                      blurRadius: 10.r,
                    )
                  ],
                ),
                child: Column(
                  children: const [
                    UserInfoTile(),
                    // SizedBox(height: 25.h),
                    TaskCounter(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.h),
            WorkListCounter(),
            SizedBox(height: 30.h),
            WorkListStatistic(),
          ],
        ),
      ),
    );
  }

  void _showImageSourceBottomSheet(BuildContext context) {
    showBottomSheet(
      context: context,
      builder: (_) => Container(
        color: Colors.grey.shade200,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                context
                    .read<ProfileBloc>()
                    .add(ShowImagePicker(imageSource: ImageSource.camera));
              },
              child: SizedBox(
                width: 180.w,
                height: 120.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt,
                      size: 35,
                    ),
                    Text(
                      'Camera',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                context
                    .read<ProfileBloc>()
                    .add(ShowImagePicker(imageSource: ImageSource.gallery));
              },
              child: SizedBox(
                width: 180.w,
                height: 120.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.collections,
                      size: 35,
                    ),
                    Text(
                      'Gallery',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
