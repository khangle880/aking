import 'package:equatable/equatable.dart';

class PublicUserInfo extends Equatable {
  final String id;
  final String email;
  final String name;
  final String avatarLink;

  const PublicUserInfo._({
    required this.id,
    required this.email,
    required this.name,
    required this.avatarLink,
  });

  factory PublicUserInfo.fromJson(Map<String, dynamic> json) =>
      PublicUserInfo._(
        id: json['id'] as String,
        email: json['email'] as String,
        name: json['name'] as String,
        avatarLink: json['avatarLink'] as String,
      );

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'avatarLink': avatarLink,
    };
  }

  @override
  List<Object?> get props => [id, email, name, avatarLink];

  @override
  String toString() => '$id $name $email $avatarLink';
}
