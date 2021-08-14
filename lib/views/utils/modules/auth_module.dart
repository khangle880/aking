import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void _showSnackBar(BuildContext context, List<Widget> children,
    {Duration? duration}) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
        backgroundColor: Theme.of(context).primaryColorDark,
        duration: duration ?? Duration(milliseconds: 4000),
      ),
    );
}

void showLoadingSnackBar(BuildContext context, String textMessage) {
  _showSnackBar(
    context,
    <Widget>[
      Text(
        textMessage,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
      ),
      SizedBox(
        height: 20.w,
        width: 20.h,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      )
    ],
    duration: Duration(hours: 1),
  );
}

void showSuccessSnackBar(BuildContext context, String textMessage) {
  _showSnackBar(
    context,
    <Widget>[
      Text(
        textMessage,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
      ),
      Icon(
        Icons.check,
        color: Colors.white,
      ),
    ],
    duration: Duration(microseconds: 500),
  );
}

void showFailureSnackBar(BuildContext context, String textMessage) {
  _showSnackBar(context, <Widget>[
    Text(
      textMessage,
      style: Theme.of(context).textTheme.subtitle2,
    ),
    Icon(
      Icons.error_outline_sharp,
      color: Colors.white,
    ),
  ]);
}
