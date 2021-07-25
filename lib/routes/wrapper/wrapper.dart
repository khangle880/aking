import 'package:aking/models/services/auth.dart';
import 'package:aking/routes/home/home.dart';
import 'package:aking/routes/walkthrough/walkthrough_page.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthServices>.value(value: AuthServices()),
        StreamProvider<User?>.value(
            value: AuthServices().user, initialData: null)
      ],
      child: Consumer<User?>(
        builder: (context, value, child) {
          if (value != null) {
            return HomePage();
          } else {
            return WalkthroughPage();
          }
        },
      ),
    );
  }
}
