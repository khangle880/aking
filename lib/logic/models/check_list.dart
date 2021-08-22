import 'package:equatable/equatable.dart';
// todo : make variable for check list
class CheckList extends Equatable {
  final String id;
  final String name;
  final String hexColor;

  const CheckList._({
    required this.id,
    required this.name,
    required this.hexColor,
  });

  factory CheckList.fromJson(Map<String, dynamic> json) => CheckList._(
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
