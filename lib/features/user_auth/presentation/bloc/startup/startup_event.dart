part of 'startup_bloc.dart';

@immutable
sealed class StartupEvent {}

final class NavigateToHome extends StartupEvent {}

final class NavigateToLogin extends StartupEvent {}
