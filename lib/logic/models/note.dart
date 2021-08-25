import 'package:aking/logic/models/quick_note.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Note extends QuickNote {
  final String description;

  const Note({
    required String id,
    required this.description,
    required String hexColor,
    required DateTime createdDate,
  }) : super(id: id, hexColor: hexColor, createdDate: createdDate);

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json['id'] as String,
        description: json['description'] as String,
        hexColor: json['hexColor'] as String,
        createdDate: DateTime.fromMillisecondsSinceEpoch(
            (json['createdDate'] as Timestamp).seconds * 1000),
      );

  @override
  List<Object?> get props => [id, description, hexColor];

  @override
  Map<String, dynamic> toJson() {
    return {
      'createdDate': Timestamp.fromDate(createdDate),
      'description': description,
      'hexColor': hexColor
    };
  }

  @override
  String toString() => '$id $createdDate $hexColor';
}
