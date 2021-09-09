import 'package:aking/views/routes/exception/exception_page.dart';
import 'package:aking/views/routes/home/tabs/work_list/work_list_page.dart';
import 'package:flutter/material.dart';

import 'project_page.dart';

class ProjectNav extends StatelessWidget {
  const ProjectNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext context) => ProjectPage();
            break;
          case '/details':
            if (settings.arguments == null) {
              debugPrint("Miss bloc value, can't to route");
              builder = (_) => ExceptionPage();
            } else {
              builder = (_) =>
                  WorkListPage(byProjectId: settings.arguments! as String);
            }
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(
          builder: builder,
          settings: settings,
        );
      },
    );
  }
}
