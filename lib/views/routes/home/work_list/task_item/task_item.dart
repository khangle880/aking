import 'package:aking/logic/models/task.dart';
import 'package:aking/logic/utils/modules/color_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'delete_action.dart';
import 'edit_action.dart';
import 'item_body.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      showAllActionsThreshold: 0.1,
      secondaryActions: const [
        EditAction(),
        DeleteAction(),
      ],
      child: ItemBody(
           task: task),
    );
  }
}






