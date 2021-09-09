import 'package:aking/logic/models/firestore_doc.dart';

class PublicUserInfo extends FirestoreDoc {
  final String email;
  final String name;
  final String avatarLink;
  final String description;

  const PublicUserInfo({
    required String id,
    required this.email,
    required this.name,
    required this.avatarLink,
    required bool status,
    required this.description,
  }) : super(id, status);

  factory PublicUserInfo.fromJson(Map<String, dynamic> json) => PublicUserInfo(
        id: json['id'] as String,
        email: json['email'] as String,
        name: json['name'] as String,
        avatarLink: json['avatarLink'] as String,
        status: json['status'] as bool,
        description: json['description'] as String,
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'avatarLink': avatarLink,
      'status': status,
      'description': description,
    };
  }

  @override
  List<Object?> get props => [id, email, name, avatarLink, description];

  @override
  String toString() => '$id $name $email $avatarLink $description';
}
