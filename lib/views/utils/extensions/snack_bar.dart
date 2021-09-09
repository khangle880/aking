import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ExpandedSnackBar on SnackBar {
  static SnackBar statusSnackBar(BuildContext context, List<Widget> children,
      {Duration? duration}) {
    return SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Theme.of(context).primaryColorDark,
      duration: duration ?? Duration(milliseconds: 4000),
    );
  }

  static SnackBar loadingSnackBar(BuildContext context, String textMessage) {
    return statusSnackBar(
      context,
      <Widget>[
        Text(
          textMessage,
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(color: Colors.white),
        ),
        SizedBox(
          height: 20.h,
          width: 20.h,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
      ],
      duration: Duration(hours: 1),
    );
  }

  static SnackBar successSnackBar(BuildContext context, String textMessage) {
    return statusSnackBar(
      context,
      <Widget>[
        Text(
          textMessage,
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(color: Colors.white),
        ),
        Icon(
          Icons.check,
          color: Colors.white,
        ),
      ],
      duration: Duration(milliseconds: 1000),
    );
  }

  static SnackBar failureSnackBar(BuildContext context, String textMessage) {
    return statusSnackBar(context, <Widget>[
      Text(
        textMessage,
        style: Theme.of(context)
            .textTheme
            .subtitle2!
            .copyWith(color: Colors.white),
      ),
      Icon(
        Icons.error_outline_sharp,
        color: Colors.white,
      ),
    ]);
  }
}
