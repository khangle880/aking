import 'package:aking/logic/blocs/add_check_list/add_check_list_bloc.dart';
import 'package:aking/logic/blocs/process_state.dart';
import 'package:aking/logic/models/animated_list_modal.dart';
import 'package:aking/logic/models/check_list.dart';
import 'package:aking/logic/repositories/firestore/quick_note_repository.dart';
import 'package:aking/logic/repositories/user_repository.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:aking/views/widgets/list_color_selection.dart';
import 'package:aking/views/widgets/rounded_button.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddCheckListForm extends StatefulWidget {
  const AddCheckListForm({Key? key}) : super(key: key);

  @override
  _AddCheckListFormState createState() => _AddCheckListFormState();
}

class _AddCheckListFormState extends State<AddCheckListForm> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late AnimatedListModel<CheckItem> _animatedListModel;

  @override
  void initState() {
    super.initState();
    _animatedListModel = AnimatedListModel<CheckItem>(
        listKey: _listKey,
        removedItemBuilder: _buildRemovedItem,
        initialItems: const [
          CheckItem(description: "List Item 1", isDone: false),
          CheckItem(description: "List Item 2", isDone: false),
        ]);
  }

  Widget _buildRemovedItem(
      BuildContext context, CheckItem item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Row(
        children: [
          SizedBox(
            width: 20.h,
            height: 20.h,
            child: Checkbox(
              value: item.isDone,
              onChanged: (value) {},
            ),
          ),
          SizedBox(width: 14.w),
          SizedBox(
            width: 210.w,
            child: TextFormField(
              initialValue: item.description,
              style: Theme.of(context).textTheme.button,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (val) {},
              decoration: InputDecoration().toNoneBorder(),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete, size: 25.w, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return BlocBuilder<AddCheckListBloc, AddCheckListState>(
      builder: (context, state) {
        final item = state.animatedListModel[index];
        return SizeTransition(
          sizeFactor: animation,
          child: Row(
            children: [
              SizedBox(
                width: 20.h,
                height: 20.h,
                child: Checkbox(
                  value: item.isDone,
                  onChanged: (value) {
                    context.read<AddCheckListBloc>().add(
                        UpdateCheckItem(index: index, isDone: !item.isDone));
                  },
                ),
              ),
              SizedBox(width: 14.w),
              SizedBox(
                width: 210.w,
                child: TextFormField(
                  initialValue: item.description,
                  style: Theme.of(context).textTheme.button,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (val) {
                    context.read<AddCheckListBloc>().add(UpdateCheckItem(
                        index: index, description: item.description));
                  },
                  decoration: InputDecoration().toNoneBorder().copyWith(
                      hintText: 'List Item ${index + 1}',
                      hintStyle:
                          Theme.of(context).textTheme.button!.toBlurColor()),
                ),
              ),
              IconButton(
                onPressed: () {
                  context
                      .read<AddCheckListBloc>()
                      .add(RemoveCheckItem(index: index));
                },
                icon: Icon(Icons.delete, size: 25.w, color: Colors.grey),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider<AddCheckListBloc>(
      create: (_) => AddCheckListBloc(
        quickNoteRepository: context.read<QuickNoteRepository>(),
        userRepo: context.read<UserRepository>(),
        animatedListModel: _animatedListModel,
      ),
      child: BlocBuilder<AddCheckListBloc, AddCheckListState>(
        builder: (context, state) => Container(
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Title",
                style: textTheme.subtitle1,
              ),
              SizedBox(height: 5.h),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 80.h,
                ),
                child: TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  initialValue: state.title,
                  onChanged: (val) {
                    context
                        .read<AddCheckListBloc>()
                        .add(TitleOnChange(title: val));
                  },
                  maxLines: null,
                  style: textTheme.button,
                  decoration: InputDecoration().toNoneBorder().copyWith(
                      hintText: 'Your Title',
                      hintStyle: textTheme.button!.toBlurColor()),
                ),
              ),
              SizedBox(height: 20.h),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 20.h,
                  minWidth: double.infinity,
                  maxHeight: 300.h,
                ),
                child: AnimatedList(
                  key: _listKey,
                  initialItemCount: state.animatedListModel.length,
                  itemBuilder: _buildItem,
                  shrinkWrap: true,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero, alignment: Alignment.centerLeft),
                onPressed: () {
                  context.read<AddCheckListBloc>().add(
                        AddCheckItem(
                          index: state.animatedListModel.length,
                          isDone: false,
                          description:
                              "List Item ${state.animatedListModel.length + 1}",
                        ),
                      );
                },
                child: Text(
                  "+ Add new item",
                  style: textTheme.subtitle1!.copyWith(fontSize: 16.sp),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "Choose Color",
                style: textTheme.subtitle1,
              ),
              SizedBox(height: 16.h),
              ListColorSelection(
                colorSelected: state.themeColor,
                onSelected: (value) {
                  context
                      .read<AddCheckListBloc>()
                      .add(ThemeColorOnChange(themeColor: value));
                },
              ),
              SizedBox(height: 40.h),
              BlocConsumer<AddCheckListBloc, AddCheckListState>(
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
                      text: 'Add CheckList Successfully!',
                    );
                  }
                },
                builder: (context, state) => RoundedButton(
                  onPressed: () {
                    context.read<AddCheckListBloc>().add(SubmitForm());
                  },
                  text: 'Done',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
