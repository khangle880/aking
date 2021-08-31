import 'package:aking/views/routes/home/add_pages/add_task/components/search_textfield_row/project_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'assignee_textfield.dart';

class SearchTextFieldRow extends StatelessWidget {
  const SearchTextFieldRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.subtitle1;
    return Row(
      children: <Widget>[
        SizedBox(width: 25.w),
        Text(
          'For',
          style: titleStyle,
        ),
        SizedBox(width: 8.w),
        AssigneeTextField(),
        SizedBox(width: 12.w),
        Text(
          'In',
          style: titleStyle,
        ),
        SizedBox(width: 8.w),
        ProjectTextField(),
      ],
    );
  }
}
