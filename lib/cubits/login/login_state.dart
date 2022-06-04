part of 'login_cubit.dart';

class LoginState extends Equatable {
  final Email email;
  final Password password;
  final FormzStatus status;
  final String? errorMessage;
  final auth.User? user;

  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.user,
  });

  factory LoginState.initial() {
    return LoginState(
      email: const Email.pure(),
      password: const Password.pure(),
      status: FormzStatus.pure,
      errorMessage: null,
      user: null,
    );
  }

  @override
  List<Object?> get props => [email, password, status, errorMessage, user];

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    String? errorMessage,
    auth.User? user,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }
}
