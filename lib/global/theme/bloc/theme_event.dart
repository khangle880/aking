part of 'theme_bloc.dart';

// ignore_for_file: public_member_api_docs
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class LightThemeEvent extends ThemeEvent{
  const LightThemeEvent();
}
class DarkThemeEvent extends ThemeEvent{
  const DarkThemeEvent();
}
