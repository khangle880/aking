import 'dart:developer';

import 'package:equatable/equatable.dart';

import 'check_list.dart';
import 'note.dart';

abstract class QuickNote extends Equatable {
  final String id;
  final String hexColor;
  final DateTime createdDate;
  const QuickNote({
    required this.id,
    required this.hexColor,
    required this.createdDate,
  });

  factory QuickNote.fromJson(Map<String, dynamic> json) {
    if (json['description'] != null) return Note.fromJson(json);
    if (json['list'] != null) return CheckList.fromJson(json);
    return Note.fromJson(json);
  }

  Map<String, dynamic> toJson();
}
