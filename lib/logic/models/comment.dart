import 'package:aking/logic/models/firestore_doc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Comment extends FirestoreDoc {
  final String? content;
  final String? imageLink;
  final DateTime createdDate;
  final String creatorId;

  const Comment({
    required String id,
    required this.content,
    required this.imageLink,
    required this.createdDate,
    required this.creatorId,
    required bool status,
  }) : super(id, status);

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json['id'] as String,
        content: json['content'] as String?,
        imageLink: json['imageLink'] as String?,
        createdDate: DateTime.fromMillisecondsSinceEpoch(
            (json['createdDate'] as Timestamp).seconds * 1000),
        creatorId: json['creatorId'] as String,
        status: json['status'] as bool,
      );

  @override
  List<Object?> get props =>
      [id, content, imageLink, createdDate, creatorId, status];

  @override
  Map<String, dynamic> toJson() {
    return {
      if (content != null && content != '') 'content': content,
      if (imageLink != null && imageLink != '') 'imageLink': imageLink,
      'createdDate': Timestamp.fromDate(createdDate),
      'creatorId': creatorId,
      'status': status,
    };
  }

  @override
  String toString() =>
      '$id $content $createdDate $creatorId $status $imageLink';
}
