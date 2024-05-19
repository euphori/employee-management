import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/domain/repositories/auth_repo.dart';
import 'package:hotel/domain/repositories/user_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;
  final UserRepo _userRepo;

  AuthCubit({required AuthRepo authRepo, required UserRepo userRepo})
      : _authRepo = authRepo,
        _userRepo = userRepo,
        super(AuthInitial());

  Future<void> onLogin({required String email, required String password}) async {
    emit(AuthLoading());

    try {
      await _authRepo.login(email: email, password: password);
      await _userRepo.fetchData(userId: _authRepo.currentUser!.uid);

      emit(AuthSuccess());
    } on LoginException catch (e) {
      emit(AuthFailed(message: e.message));
    }
  }

  Future<void> onSignUp({required String email, required String password, required String username}) async {
    emit(AuthLoading());

    try {
      await _authRepo.register(email: email, password: password, username: username);
      await _userRepo.setBudget(userId: _authRepo.currentUser!.uid);

      emit(AuthSuccess());
    } on RegisterException catch (e) {
      emit(AuthFailed(message: e.message));
    }
  }
}
