import 'package:aking/logic/models/check_list.dart';
import 'package:aking/logic/models/note.dart';
import 'package:aking/logic/models/quick_note.dart';
import 'package:aking/views/routes/home/tabs/quick_note/components/check_list_item.dart';
import 'package:aking/views/routes/home/tabs/quick_note/components/note_item.dart';
import 'package:flutter/material.dart';

class BodyItem extends StatelessWidget {
  const BodyItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final QuickNote item;

  @override
  Widget build(BuildContext context) {
    return item is Note
        ? NoteItem(item: item as Note)
        : CheckListItem(item: item as CheckList);
  }
}
