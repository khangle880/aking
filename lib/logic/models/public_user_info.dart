import 'package:aking/logic/models/firestore_doc.dart';

class PublicUserInfo extends FirestoreDoc {
  final String email;
  final String name;
  final String avatarLink;

  const PublicUserInfo({
    required String id,
    required this.email,
    required this.name,
    required this.avatarLink,
  }) : super(id);

  factory PublicUserInfo.fromJson(Map<String, dynamic> json) => PublicUserInfo(
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
