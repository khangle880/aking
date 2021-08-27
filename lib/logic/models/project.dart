import 'package:aking/logic/models/firestore_doc.dart';

class Project extends FirestoreDoc {
  final String name;
  final String hexColor;

  const Project({
    required String id,
    required this.name,
    required this.hexColor,
  }) : super(id);

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json['id'] as String,
        name: json['name'] as String,
        hexColor: json['hexColor'] as String,
      );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'hexColor': hexColor,
    };
  }

  @override
  List<Object?> get props => [id, name, hexColor];

  @override
  String toString() => '$id $name $hexColor';
}
