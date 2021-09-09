import 'package:equatable/equatable.dart';

abstract class FirestoreDoc extends Equatable {
  final String id;
  final bool status;
  // ignore: avoid_positional_boolean_parameters
  const FirestoreDoc(this.id, this.status);

  FirestoreDoc.fromJson(Map<String, dynamic> json)
      : id = json["id"] as String,
        status = json["status"] as bool {
    print(json);
  }

  Map<String, dynamic> toJson();
}
