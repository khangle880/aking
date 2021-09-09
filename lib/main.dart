import 'package:aking/logic/blocs/simple_bloc_observer.dart';
import 'package:aking/logic/models/quick_note.dart';
import 'package:aking/logic/repositories/firestore/project_repository.dart';
import 'package:aking/logic/repositories/firestore/public_user_info_repository.dart';
import 'package:aking/logic/repositories/firestore/quick_note_repository.dart';
import 'package:aking/logic/repositories/firestore/task_repository.dart';
import 'package:aking/logic/repositories/user_repository.dart';
import 'package:aking/routing/app_routes.dart';
import 'package:aking/routing/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'global/theme/bloc/theme_bloc.dart';
import 'logic/blocs/authentication/authentication_bloc.dart';

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
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => MultiRepositoryProvider(
        providers: [
          RepositoryProvider<UserRepository>(
            create: (context) => UserRepository(),
          ),
          RepositoryProvider<TaskRepository>(
            create: (context) => TaskRepository(),
          ),
          RepositoryProvider<PublicUserInfoRepository>(
            create: (context) => PublicUserInfoRepository(),
          ),
          RepositoryProvider<ProjectRepository>(
            create: (context) => ProjectRepository(),
          ),
          RepositoryProvider<QuickNoteRepository>(
            create: (context) => QuickNoteRepository(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ThemeBloc()),
            BlocProvider(
              create: (context) => AuthenticationBloc(
                userRepository: context.read<UserRepository>(),
              )..add(AuthenticationStarted()),
            )
          ],
          child: BlocBuilder<ThemeBloc, ThemeData>(
            builder: (context, theme) => _buildWithTheme(theme),
          ),
        ),
      ),
    );
  }

  MaterialApp _buildWithTheme(ThemeData theme) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Todo List",
      theme: theme,
      navigatorKey: AppRoutes.appNav,
      initialRoute: AppRouteNames.splashRoute,
      onGenerateRoute: AppRoutes.onGenerateAppRoute,
    );
  }
}
