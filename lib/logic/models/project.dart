import 'package:aking/logic/models/firestore_doc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Project extends FirestoreDoc {
  final String title;
  final String hexColor;
  final DateTime createdDate;
  final String creatorId;
  final List<String> participants;

  const Project({
    required String id,
    required this.title,
    required this.hexColor,
    required this.createdDate,
    required this.creatorId,
    required this.participants,
    required bool status,
  }) : super(id, status);

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json['id'] as String,
        title: json['title'] as String,
        hexColor: json['hexColor'] as String,
        createdDate: DateTime.fromMillisecondsSinceEpoch(
            (json['createdDate'] as Timestamp).seconds * 1000),
        participants: List.from(json['participants'] as List),
        creatorId: json['creatorId'] as String,
        status: json['status'] as bool,
      );

  @override
  List<Object?> get props => [id, title, hexColor];

  @override
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'hexColor': hexColor,
      'createdDate': Timestamp.fromDate(createdDate),
      'creatorId': creatorId,
      'participants': participants,
      'status': status,
    };
  }

  @override
  String toString() =>
      '$id $title $hexColor $createdDate $creatorId $participants $status';
}
