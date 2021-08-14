import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String content;
  final DateTime remind;
  final bool isDone;

  const Task._(
      {required this.id,
      required this.content,
      required this.remind,
      required this.isDone});

  factory Task.fromJson(Map<String, dynamic> json) => Task._(
      id: json['id'] as String,
      content: json['content'] as String,
      remind: DateTime.fromMillisecondsSinceEpoch(
          (json['remind'] as Timestamp).seconds * 1000),
      isDone: json['isDone'] as bool);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'remind': Timestamp.fromDate(remind),
      'isDone': isDone,
    };
  }

  @override
  List<Object?> get props => [id, content, remind, isDone];
}
