
import 'package:aking/models/blocs/authentication/authentication_bloc.dart';
import 'package:aking/models/blocs/login/login_bloc.dart';
import 'package:aking/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:aking/widgets/rounded_button.dart';
import 'package:aking/size_config.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  late LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChange() {
    _loginBloc.add(LoginEmailChange(email: _emailController.text));
  }

  void _onPasswordChange() {
    _loginBloc.add(LoginPasswordChanged(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _loginBloc.add(LoginWithCredentialsPressed(
        email: _emailController.text, password: _passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
      if (state is LoginFailure) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(state.errorMessage),
                  Icon(Icons.error),
                ],
              ),
              backgroundColor: Theme.of(context).accentColor,
            ),
          );
      }

      if (state is LoginLoading) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text('Logging In...'),
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                ],
              ),
              backgroundColor: Theme.of(context).accentColor,
              duration: Duration(hours: 1),
            ),
          );
      }

      if (state is LoginSuccess) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text('Login Success'),
                  Icon(Icons.check),
                ],
              ),
              backgroundColor: Theme.of(context).accentColor,
              duration: Duration(microseconds: 500),
            ),
          );
        context.read<AuthenticationBloc>().add(
              AuthenticationLoggedIn(),
            );
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pop(context);
        });
      }
    }, builder: (context, state) {
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
              autocorrect: false,
              // ignore: deprecated_member_use
              autovalidate: true,
              validator: (_) {
                return !state.isEmailValid ? 'Invalid Email' : null;
              },
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    decorationColor: Colors.black.withOpacity(0.01),
                  ),
              decoration: InputDecoration(
                hintText: 'Enter The Email',
              ),
            ),
            SizedBox(height: (30) * SizeConfig.screenHeightBase),
            Text(
              'Password',
              style: Theme.of(context).textTheme.headline6,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              // ignore: deprecated_member_use
              autovalidate: true,
              autocorrect: false,
              style: Theme.of(context).textTheme.bodyText1,
              validator: (value) {
                return !state.isPasswordValid ? 'Invalid Password' : null;
              },
              decoration: InputDecoration(
                hintText: 'Enter your password',
              ),
            ),
            SizedBox(height: (10) * SizeConfig.screenHeightBase),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, Routes.forgotPasswordRoute);
                    // context
                    //     .read<AuthenticationBloc>()
                    //     .userRepository
                    //     // .requestResetPassword(_emailController.text);
                    //     .resetPassword("182963", "a123123124");
                    // EmailAuth.sessionName = "Sample";
                    // await EmailAuth.sendOtp(
                    //     receiverMail: _emailController.text);

                    // final String? error = await context
                    //     .read<AuthenticationBloc>()
                    //     .userRepository
                    //     .resetPassword("abc@gmail.com", "a123123321");
                    // if (error == null)
                    //   log("Fuckkkkk");
                    // else
                    //   log(error);
                  },
                  child: Text(
                    "Forgot password",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: (80) * SizeConfig.screenHeightBase,
            ),
            RoundedButton(
              text: 'Log In',
              backgroundColor: hexToColor("#F96060"),
              press: () {
                print(isButtonEnabled(state));
                if (isButtonEnabled(state)) {
                  _onFormSubmitted();
                }
              },
              textColor: hexToColor("#FFFFFF"),
            ),
            // },
            // ),
          ],
        ),
      );
    });
  }
}
