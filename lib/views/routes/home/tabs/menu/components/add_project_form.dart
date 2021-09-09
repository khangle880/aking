import 'package:aking/global/constants/app_constants.dart';
import 'package:aking/logic/blocs/add_project/add_project_bloc.dart';
import 'package:aking/logic/blocs/process_state.dart';
import 'package:aking/logic/repositories/firestore/project_repository.dart';
import 'package:aking/logic/repositories/user_repository.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:aking/views/widgets/list_color_selection.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddProjectForm extends StatefulWidget {
  const AddProjectForm({
    Key? key,
    required this.parentContext,
  }) : super(key: key);

  final BuildContext parentContext;

  @override
  _AddProjectFormState createState() => _AddProjectFormState();
}

class _AddProjectFormState extends State<AddProjectForm> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      height: 250.h,
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
      child: BlocProvider(
        create: (context) => AddProjectBloc(
          projectRepo: context.read<ProjectRepository>(),
          userRepo: context.read<UserRepository>(),
        ),
        child: BlocBuilder<AddProjectBloc, AddProjectState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Title",
                      style: textTheme.subtitle1,
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        context.read<AddProjectBloc>().add(SubmitForm());
                      },
                      child: BlocConsumer<AddProjectBloc, AddProjectState>(
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
                              text: 'Add Project Successfully!',
                            );
                          }
                        },
                        builder: (context, state) => Text(
                          'Done',
                          style: textTheme.subtitle1!.copyWith(
                              color: ExpandedColor.fromHex("#6074F9")),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  initialValue: state.title,
                  autofocus: true,
                  onChanged: (val) {
                    context
                        .read<AddProjectBloc>()
                        .add(TitleOnChange(title: val));
                  },
                  style: Theme.of(widget.parentContext).textTheme.subtitle2,
                  decoration: InputDecoration().toNoneBorder().copyWith(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                          borderSide:
                              BorderSide(color: Colors.blueGrey.shade100),
                        ),
                      ),
                ),
                SizedBox(height: 16.h),
                Text(
                  "Choose Color",
                  style: textTheme.subtitle1,
                ),
                SizedBox(height: 16.h),
                ListColorSelection(
                  colorSelected: state.themeColor,
                  onSelected: (value) {
                    context
                        .read<AddProjectBloc>()
                        .add(ThemeColorOnChange(themeColor: value));
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
