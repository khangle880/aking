import 'package:aking/routing/app_routes.dart';
import 'package:aking/routing/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:aking/size_config.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'global/theme/bloc/theme_bloc.dart';
import 'models/blocs/authentication/authentication_bloc.dart';
import 'models/blocs/simple_bloc_observer.dart';
import 'models/repositories/user_repository.dart';

Future main() async {
  /// Ensure Initialized
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  await dotenv.load();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserRepository _userRepository = UserRepository();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: () => LayoutBuilder(builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => ThemeBloc()),
              BlocProvider(
                create: (context) => AuthenticationBloc(
                  userRepository: _userRepository,
                )..add(AuthenticationStarted()),
              )
            ],
            child: BlocBuilder<ThemeBloc, ThemeData>(
              builder: (context, theme) => _buildWithTheme(theme),
            ),
          );
        });
      }),
    );
  }

  MaterialApp _buildWithTheme(ThemeData theme) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Todo List",
      theme: theme,
      initialRoute: Routes.splashRoute,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
