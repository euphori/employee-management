part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

final class AppState {
  final AppStatus status;
  final User? user;

  const AppState._({
    required this.status,
    this.user,
  });

  const AppState.authenticated(User user) : this._(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);
}
