part of 'app_bloc.dart';

sealed class AppEvent {}

final class AppCheckAuth extends AppEvent {}

final class AppLogoutRequested extends AppEvent {}
