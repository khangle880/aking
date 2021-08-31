import 'package:aking/logic/utils/modules/color_module.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

extension ExpandedFlushbar on Flushbar {
  static Flushbar statusFlushBar(BuildContext context,
      {Duration? duration,
      Text? titleText,
      Text? messageText,
      Widget? icon,
      bool showProgressIndicator = false,
      Color? progressIndicatorBackgroundColor}) {
    return Flushbar(
      backgroundColor: Colors.black87,
      icon: icon,
      message: "Flushbar showing",
      titleText: titleText,
      messageText: messageText,
      duration: duration ?? Duration(seconds: 4),
      showProgressIndicator: showProgressIndicator,
      progressIndicatorBackgroundColor:
          progressIndicatorBackgroundColor ?? Colors.amberAccent,
    );
  }

  static Flushbar loadingFlushbar(BuildContext context, String textMessage) {
    return statusFlushBar(
      context,
      titleText: Text(
        textMessage,
        style: Theme.of(context)
            .textTheme
            .subtitle2!
            .copyWith(color: Colors.white),
      ),
      showProgressIndicator: true,
      duration: Duration(milliseconds: 1000),
    );
  }

  static Flushbar successFlushbar(BuildContext context, String textMessage) {
    return statusFlushBar(
      context,
      titleText: Text(
        textMessage,
        style: Theme.of(context)
            .textTheme
            .subtitle2!
            .copyWith(color: Colors.white),
      ),
      icon: Icon(
        Icons.check,
        color: Colors.white,
      ),
      duration: Duration(milliseconds: 1000),
    );
  }

  static Flushbar failureFlushbar(BuildContext context, String textMessage) {
    return statusFlushBar(
      context,
      titleText: Text(
        textMessage,
        style: Theme.of(context)
            .textTheme
            .subtitle2!
            .copyWith(color: Colors.white),
      ),
      icon: Icon(
        Icons.error_outline_sharp,
        color: Colors.white,
      ),
      duration: Duration(milliseconds: 1000),
    );
  }
}
