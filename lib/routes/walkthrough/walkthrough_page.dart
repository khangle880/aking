  // 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'components/walkthrough_body.dart';

class WalkthroughPage extends StatelessWidget {
  const WalkthroughPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: WalkthroughBody(),
    );
  }
}
