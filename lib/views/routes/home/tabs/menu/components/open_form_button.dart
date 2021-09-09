import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'add_project_form.dart';

class OpenFormButton extends StatelessWidget {
  const OpenFormButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      height: 80.h,
      decoration: BoxDecoration(
        color: ExpandedColor.fromHex("#6074F9"),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: IconButton(
        onPressed: () {
          showDialog(
            context: context,
            useRootNavigator: false,
            builder: (_) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r)),
                child: AddProjectForm(
                  parentContext: context,
                ),
              );
            },
          );
        },
        icon: Icon(
          Icons.add,
          size: 24.w,
          color: ExpandedColor.fromHex("#FFFFFF"),
        ),
      ),
    );
  }
}
