import 'package:equatable/equatable.dart';

class QuickNote extends Equatable {
  final String id;
  final String description;
  final String hexColor;

  const QuickNote._({
    required this.id,
    required this.description,
    required this.hexColor,
  });

  factory QuickNote.fromJson(Map<String, dynamic> json) => QuickNote._(
        id: json['id'] as String,
        description: json['description'] as String,
        hexColor: json['hexColor'] as String,
      );

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'hexColor': hexColor,
    };
  }

  @override
  List<Object?> get props => [id, description, hexColor];

  @override
 String toString() => '$id $description $hexColor';
}
