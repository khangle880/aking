import 'package:aking/logic/models/firestore_doc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Task extends FirestoreDoc {
  final String assignedToId;
  final DateTime createdDate;
  final String creatorId;
  final String? description;
  final DateTime? dueDate;
  final bool isDone;
  final List<String>? members;
  final List<String> participants;
  final String projectId;
  final String title;
  final bool status;

  const Task({
    required String id,
    required this.title,
    required this.dueDate,
    required this.isDone,
    required this.assignedToId,
    required this.createdDate,
    required this.creatorId,
    required this.description,
    required this.members,
    required this.participants,
    required this.projectId,
    required this.status,
  }) : super(id);

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'] as String,
        dueDate: json['dueDate'] != null
            ? DateTime.fromMillisecondsSinceEpoch(
                (json['dueDate'] as Timestamp).seconds * 1000)
            : null,
        createdDate: DateTime.fromMillisecondsSinceEpoch(
            (json['createdDate'] as Timestamp).seconds * 1000),
        title: json['title'] as String,
        description: json['description'] as String?,
        projectId: json['projectId'] as String,
        assignedToId: json['assignedToId'] as String,
        members:
            json['members'] != null ? List.from(json['members'] as List) : null,
        participants: List.from(json['participants'] as List),
        isDone: json['isDone'] as bool,
        creatorId: json['creatorId'] as String,
        status: json['status'] as bool,
      );

  Map<String, dynamic> toJson() {
    return {
      'createdDate': Timestamp.fromDate(createdDate),
      'title': title,
      'creatorId': creatorId,
      'assignedToId': assignedToId,
      'projectId': projectId,
      'isDone': isDone,
      'participants': participants,
      'status': status,
      if (dueDate != null) 'dueDate': Timestamp.fromDate(dueDate!),
      if (description != null) 'description': description,
      if (members != null) 'members': members,
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        isDone,
        assignedToId,
        createdDate,
        creatorId,
        participants,
        projectId,
      ];

  @override
  String toString() =>
      '$id $title $isDone $assignedToId $createdDate $creatorId $participants $projectId';
}
