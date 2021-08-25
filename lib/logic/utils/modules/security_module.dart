import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String hashPassword(String password) {
  final saltedPassword = dotenv.env['SALTKEY']! + password;
  final bytes = utf8.encode(saltedPassword);
  final hash = sha256.convert(bytes);
  return hash.toString();
}
