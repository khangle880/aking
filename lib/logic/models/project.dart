import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final String id;
  final String name;
  final String hexColor;

  const Project({
    required this.id,
    required this.name,
    required this.hexColor,
  });

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
