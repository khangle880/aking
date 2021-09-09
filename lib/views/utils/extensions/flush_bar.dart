import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ExpandedFlushbar on Flushbar {
  static Flushbar statusFlushBar(BuildContext context,
      {Duration? duration,
      String? title,
      required String message,
      Widget? icon,
      bool showProgressIndicator = false,
      Color? progressIndicatorBackgroundColor}) {
    return Flushbar(
      backgroundColor: Colors.indigo,
      icon: icon,
      padding: EdgeInsets.symmetric(vertical: 15.h),
      titleText: title == null
          ? null
          : Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: Colors.white),
            ),
      messageText: Text(
        message,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: Colors.white, fontSize: 14.sp),
      ),
      duration: duration ?? Duration(seconds: 4),
      showProgressIndicator: showProgressIndicator,
      // leftBarIndicatorColor: Colors.blue.shade900,
      progressIndicatorValueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
      progressIndicatorBackgroundColor:
          progressIndicatorBackgroundColor ?? Colors.amberAccent,
    );
  }

  static Flushbar loadingFlushbar(BuildContext context,
      {String? title, required String message}) {
    return statusFlushBar(
      context,
      title: title,
      message: message,
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.h,
            width: 20.h,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ],
      ),
      // showProgressIndicator: false,
      duration: Duration(milliseconds: 1000),
    );
  }

  static Flushbar successFlushbar(BuildContext context,
      {String? title, required String message}) {
    return statusFlushBar(
      context,
      title: title,
      message: message,
      icon: Icon(
        Icons.check,
        color: Colors.white,
      ),
      duration: Duration(milliseconds: 2000),
    );
  }

  static Flushbar failureFlushbar(BuildContext context,
      {String? title, required String message}) {
    return statusFlushBar(
      context,
      title: title,
      message: message,
      icon: Icon(
        Icons.error_outline_sharp,
        color: Colors.white,
      ),
      duration: Duration(milliseconds: 2000),
    );
  }
}
