import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repositories/auth/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository _authRepository;

  SignupCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(SignupState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: SignupStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: SignupStatus.initial));
  }

  Future<void> signUpWithCredentials() async {
    if (!state.isFormValid || state.status == SignupStatus.submitting) return;
    emit(state.copyWith(status: SignupStatus.submitting));
    try {
      var user = await _authRepository.signUp(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(status: SignupStatus.success, user: user));
    } catch (_) {}
  }
}
