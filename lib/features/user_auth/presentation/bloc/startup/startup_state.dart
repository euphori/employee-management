part of 'startup_bloc.dart';

@immutable
abstract class StartupState {}

class StartupInitial extends StartupState {}

class StartupHome extends StartupState {}

class StartupLogin extends StartupState {}
