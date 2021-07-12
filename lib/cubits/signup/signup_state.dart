part of 'signup_cubit.dart';

enum SignupStatus { initial, submitting, success, error }

class SignupState extends Equatable {
  final String email;
  final String password;
  final SignupStatus status;

  bool get isFormValid => email.isNotEmpty && password.isNotEmpty;

  const SignupState({
    required this.email,
    required this.password,
    required this.status,
  });

  factory SignupState.initial() {
    return SignupState(
      email: '',
      password: '',
      status: SignupStatus.initial,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [email, password, status];

  SignupState copyWith({
    String? email,
    String? password,
    SignupStatus? status,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
