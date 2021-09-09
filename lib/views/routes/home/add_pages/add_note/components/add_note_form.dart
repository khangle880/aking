import 'package:aking/logic/blocs/add_note/add_note_bloc.dart';
import 'package:aking/logic/blocs/process_state.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:aking/views/widgets/list_color_selection.dart';
import 'package:aking/views/widgets/rounded_button.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AddNoteForm extends StatefulWidget {
  const AddNoteForm({Key? key}) : super(key: key);

  @override
  _AddNoteFormState createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<AddNoteBloc, AddNoteState>(
      builder: (context, state) => Container(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Decription",
              style: textTheme.subtitle1,
            ),
            SizedBox(height: 5.h),
            TextFormField(
              textCapitalization: TextCapitalization.sentences,
              initialValue: state.description,
              onChanged: (val) {
                context
                    .read<AddNoteBloc>()
                    .add(DescriptionOnChange(description: val));
              },
              maxLines: 4,
              style: textTheme.button,
              decoration: InputDecoration().toNoneBorder().copyWith(
                  hintText: 'Your description',
                  hintStyle: textTheme.button!.toBlurColor()),
            ),
            SizedBox(height: 30.h),
            Text(
              "Choose Color",
              style: textTheme.subtitle1,
            ),
            SizedBox(height: 16.h),
            ListColorSelection(
              colorSelected: state.themeColor,
              onSelected: (value) {
                context
                    .read<AddNoteBloc>()
                    .add(ThemeColorOnChange(themeColor: value));
              },
            ),
            SizedBox(height: 40.h),
            BlocConsumer<AddNoteBloc, AddNoteState>(
              listener: (context, state) {
                final submitStatus = state.addStatus;
                if (submitStatus is Processing) {
                  CoolAlert.show(
                    context: context,
                    type: CoolAlertType.loading,
                    barrierDismissible: false,
                  );
                } else if (submitStatus is ProcessFailure) {
                  Navigator.of(context, rootNavigator: true).pop();
                  CoolAlert.show(
                    backgroundColor: ExpandedColor.fromHex("#FFD371"),
                    context: context,
                    barrierDismissible: false,
                    type: CoolAlertType.error,
                    title: 'Oops...',
                    text: submitStatus.errorMessage,
                  );
                } else if (submitStatus is ProcessSuccess) {
                  Navigator.of(context, rootNavigator: true).pop();
                  Navigator.pop(context);
                  CoolAlert.show(
                    context: context,
                    barrierDismissible: false,
                    backgroundColor: ExpandedColor.fromHex("#9DDAC6"),
                    type: CoolAlertType.success,
                    text: 'Add Note Successfully!',
                  );
                }
              },
              builder: (context, state) => RoundedButton(
                onPressed: () {
                  context.read<AddNoteBloc>().add(SubmitForm());
                },
                text: 'Done',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
