import 'package:flutter/material.dart';

class ExceptionPage extends StatelessWidget {
  const ExceptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exception'),
      ),
      body: Center(
        child: Text("Oh no, something went wrong!",
            style: Theme.of(context).textTheme.subtitle1),
      ),
    );
  }
}
