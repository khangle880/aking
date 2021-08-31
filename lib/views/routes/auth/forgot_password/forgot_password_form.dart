import 'package:aking/logic/utils/modules/color_module.dart';
import 'package:aking/routing/app_routes.dart';
import 'package:aking/routing/routes.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aking/logic/blocs/reset_password/reset_password_bloc.dart';
import 'package:aking/logic/utils/validator/auth_validators.dart';
import 'package:aking/views/widgets/rounded_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? input) {
    if (input != null && AuthValidators.isValidEmail(input)) {
      return null;
    } else {
      return "Invalid email";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Username',
            style: Theme.of(context).textTheme.headline6,
          ),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: _validateEmail,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  decorationColor: Colors.black.withOpacity(0.01),
                ),
            decoration: InputDecoration(
              hintText: 'Enter The Email',
            ),
          ),
          SizedBox(height: 30.h),
          RoundedButton(
            text: 'Send Request',
            backgroundColor: hexToColor("#F96060"),
            press: () {
              if (_formKey.currentState!.validate()) {
                context
                    .read<ResetPasswordBloc>()
                    .add(ResetPassSendRequest(email: _emailController.text));
              }
            },
            textColor: hexToColor("#FFFFFF"),
          ),
          BlocListener<ResetPasswordBloc, ResetPasswordState>(
            listener: (context, state) {
              if (state is ResetPasswordLoading) {
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(ExpandedSnackBar.loadingSnackBar(
                    context,
                    "Sending otp...",
                  ));
              }

              if (state is ResetPasswordRequestFailure) {
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(ExpandedSnackBar.failureSnackBar(
                    context,
                    "OTP was not sent failure",
                  ));
              }

              if (state is ResetPasswordRequestSuccess) {
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(ExpandedSnackBar.successSnackBar(
                    context,
                    "OTP sent successfully !",
                  ));
                Future.delayed(const Duration(milliseconds: 2000), () {
                  AppRoutes.appNav.currentState!.pushNamed(
                    AppRouteNames.resetPasswordRoute,
                    arguments: context.read<ResetPasswordBloc>(),
                  );
                });
              }
            },
            child: Container(),
          ),
        ],
      ),
    );
  }
}
