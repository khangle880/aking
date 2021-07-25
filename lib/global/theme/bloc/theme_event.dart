part of 'theme_bloc.dart';

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
