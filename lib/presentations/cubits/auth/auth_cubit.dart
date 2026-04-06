import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:rentapp/data/models/user_model.dart';
import 'package:rentapp/data/remote_datasources/auth_remote_datasource.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRemoteDatasource _auth;

  late StreamSubscription<fb.User?> _authSubscription;

  AuthCubit(this._auth) : super(const AuthState()) {
    _authSubscription = _auth.authStateChanges.listen((fbUser) {
      if (fbUser != null) {
        final myUser = UserModel(uid: fbUser.uid, email: fbUser.email);
        emit(state.copyWith(status: AuthStatus.authenticated, user: myUser));
      } else {
        emit(state.copyWith(status: AuthStatus.unauthenticated, user: null));
      }
    });
  }

  Future<void> login(String email, String password) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      await _auth.login(email, password);
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> register(String fullName, String email, String password) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      await _auth.register(fullName, email, password);
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> logout() async {
    try {
      await _auth.logout();
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> getUser() async {
    emit(state.copyWith(status: AuthStatus.loading));

    _auth.getUser().listen(
      (users) {
        emit(state.copyWith(status: AuthStatus.authenticated, users: users));
      },

      onError: (error) {
        emit(
          state.copyWith(
            status: AuthStatus.failure,
            errorMessage: error.toString(),
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
