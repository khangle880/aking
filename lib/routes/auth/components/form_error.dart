import 'package:flutter/material.dart';
import 'package:aking/models/providers/auth_provider.dart';
import 'package:aking/size_config.dart';
import 'package:provider/provider.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: List.generate(
          context.watch<AuthProvider>().listErrors.length,
          (index) => Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red[400],
                size: 24.0,
              ),
              SizedBox(width: getProportionateScreenWidth(10)),
              Text(context.watch<AuthProvider>().listErrors[index]),
            ],
          ),
        ));
  }
}
