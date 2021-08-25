import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:aking/logic/models/quick_note.dart';

class CheckList extends QuickNote {
  final String title;
  final List<CheckItem> list;

  const CheckList({
    required String id,
    required this.title,
    required this.list,
    required String hexColor,
    required DateTime createdDate,
  }) : super(id: id, hexColor: hexColor, createdDate: createdDate);

  factory CheckList.fromJson(Map<String, dynamic> json) => CheckList(
        id: json['id'] as String,
        title: json['title'] as String,
        hexColor: json['hexColor'] as String,
        createdDate: DateTime.fromMillisecondsSinceEpoch(
            (json['createdDate'] as Timestamp).seconds * 1000),
        list: (json['list'] as List)
            .map((item) => CheckItem.fromJson(item as Map<String, dynamic>))
            .toList(),
      );

  @override
  List<Object?> get props => [id, title, hexColor];

  @override
  Map<String, dynamic> toJson() {
    return {
      'createdDate': Timestamp.fromDate(createdDate),
      'title': title,
      'hexColor': hexColor,
      'list': list.map((item) => item.toJson()).toList(),
    };
  }

  @override
  String toString() => '$id $createdDate $hexColor $list';
}

class CheckItem extends Equatable {
  final String description;
  final bool isDone;
  const CheckItem({
    required this.description,
    required this.isDone,
  });

  factory CheckItem.fromJson(Map<String, dynamic> json) {
    return CheckItem(
      description: json['description'] as String,
      isDone: json['isDone'] as bool,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'isDone': isDone,
    };
  }

  @override
  List<Object?> get props => [description, isDone];

  @override
  String toString() => '$description $isDone';
}
