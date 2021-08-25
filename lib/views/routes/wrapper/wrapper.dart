import 'package:aking/logic/blocs/authentication/authentication_bloc.dart';
import 'package:aking/views/routes/home/main_page.dart';
import 'package:aking/views/routes/walkthrough/walkthrough_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is AuthenticationFailure) {
        return WalkthroughPage();
      }

      if (state is AuthenticationSuccess) {
        // return HomePage(user: state.firebaseUser);
        return MainPage(uid: state.firebaseUser.uid);
      }

      return Scaffold(
        body: Center(child: Text("Loading")),
      );
    });
  }
}
