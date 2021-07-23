import 'package:aking/routes/home/home.dart';
import 'package:aking/routes/walkthrough/walkthrough_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();
    if (user != null) {
      return HomePage();
    } else {
      return WalkthroughScreen();
    }
  }
}
