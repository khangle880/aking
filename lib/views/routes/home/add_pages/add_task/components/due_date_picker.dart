import 'package:aking/logic/provider/add_task.dart';
import 'package:aking/logic/utils/modules/color_module.dart';
import 'package:aking/views/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:aking/logic/utils/extensions/datetime_extensions.dart';

class DueDatePicker extends StatefulWidget {
  const DueDatePicker({Key? key}) : super(key: key);

  @override
  _DueDatePickerState createState() => _DueDatePickerState();
}

class _DueDatePickerState extends State<DueDatePicker>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: 66.h,
      color: hexToColor("#F4F4F4"),
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 17.h),
      child: Row(
        children: [
          Text("Due Date",
              style: textTheme.bodyText1!.copyWith(fontSize: 16.sp)),
          SizedBox(width: 8.w),
          AnimatedSize(
            vsync: this,
            duration: Duration(milliseconds: 1500),
            curve: Curves.easeIn,
            child: Container(
              height: 32.h,
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                color: hexToColor("#6074F9"),
              ),
              child: Consumer<AddTaskProvider>(
                builder: (context, value, child) => Center(
                  child: InkWell(
                    onTap: () => _showDatePicker(context),
                    child: Text(
                      value.dueDate == null
                          ? "Any Time"
                          : value.dueDate!.formatOrAroundToday("dd/MM/yyyy"),
                      style: textTheme.bodyText1!.copyWith(
                          fontSize: 14.sp, color: hexToColor("#FFFFFF")),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDatePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (popContext) {
        final textTheme = Theme.of(context).textTheme;
        final datePickerStyle =
            textTheme.bodyText1!.copyWith(fontSize: 13.5.sp);

        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
          child: SizedBox(
              height: 420.h,
              width: 345.w,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.h),
                  SfDateRangePicker(
                    onSelectionChanged: (datePicked) => context
                        .read<AddTaskProvider>()
                        .changeDueDate(datePicked.value as DateTime),
                    initialSelectedDate:
                        context.watch<AddTaskProvider>().dueDate,
                    selectionColor: hexToColor('#6074F9'),
                    headerHeight: 50.h,
                    headerStyle: DateRangePickerHeaderStyle(
                        textAlign: TextAlign.center,
                        textStyle: textTheme.subtitle2),
                    monthViewSettings: DateRangePickerMonthViewSettings(
                      viewHeaderStyle: DateRangePickerViewHeaderStyle(
                        textStyle: textTheme.subtitle2,
                      ),
                      showTrailingAndLeadingDates: true,
                    ),
                    monthCellStyle: DateRangePickerMonthCellStyle(
                      textStyle: datePickerStyle,
                      leadingDatesTextStyle: datePickerStyle.toBlurColor(),
                      todayTextStyle: datePickerStyle,
                    ),
                    yearCellStyle: DateRangePickerYearCellStyle(
                      disabledDatesTextStyle: datePickerStyle,
                      leadingDatesTextStyle: datePickerStyle,
                      textStyle: datePickerStyle,
                      todayTextStyle: datePickerStyle,
                    ),
                  ),
                  SizedBox(height: 35.h),
                  SizedBox(
                    width: 150.w,
                    height: 48.h,
                    child: RoundedButton(
                      text: "Done",
                      press: () => Navigator.of(popContext).pop(),
                      backgroundColor: hexToColor("#F96060"),
                      textColor: hexToColor("#FFFFFF"),
                    ),
                  )
                ],
              )),
        );
      },
    );
  }
}
