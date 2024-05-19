part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoadingData extends UserState {}

final class UserLoadedData extends UserState {}

final class UserErrorData extends UserState {
  final String message;

  UserErrorData({required this.message});
}
