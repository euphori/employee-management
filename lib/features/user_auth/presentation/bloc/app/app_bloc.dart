import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/domain/repositories/auth_repo.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepo _authRepo;

  AppBloc({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(const AppState._(status: AppStatus.unauthenticated)) {
    on<AppCheckAuth>((event, emit) async {
      final user = _authRepo.currentUser;

      if (user != null) {
        emit(AppState.authenticated(user));
      } else {
        emit(const AppState.unauthenticated());
      }
    });

    on<AppLogoutRequested>((event, emit) async {
      await _authRepo.logout();
      emit(const AppState.unauthenticated());
    });
  }
}
