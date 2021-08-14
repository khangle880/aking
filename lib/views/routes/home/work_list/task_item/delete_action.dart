import 'package:aking/logic/utils/modules/color_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DeleteAction extends StatelessWidget {
  const DeleteAction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(5.w, 5.w),
            color: Color.fromRGBO(224, 224, 224, 0.5),
            blurRadius: 9.w,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 3.w),
        child: IconSlideAction(
          color: Colors.white,
          iconWidget: Icon(Icons.delete_outline, color: hexToColor("#F96060")),
          onTap: () {},
        ),
      ),
    );
  }
}
