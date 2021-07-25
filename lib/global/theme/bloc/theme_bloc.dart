import 'dart:async';

import 'package:aking/global/theme/app_theme.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_event.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeData> {
  ThemeBloc() : super(AppTheme.light());

  @override
  Stream<ThemeData> mapEventToState(ThemeEvent event) async* {
    if (event is LightThemeEvent) yield AppTheme.light();
    if (event is DarkThemeEvent) yield AppTheme.dark();
  }

  @override
  ThemeData? fromJson(Map<String, dynamic> json) {
    try {
      if (json['light'] as bool) return AppTheme.light();
      return AppTheme.dark();
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, bool>? toJson(ThemeData state) {
    try {
      return {'light': state == AppTheme.light()};
    } catch (_) {
      return null;
    }
  }
}
