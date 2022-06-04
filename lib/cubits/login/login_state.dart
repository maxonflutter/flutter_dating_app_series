part of 'login_cubit.dart';

class LoginState extends Equatable {
  final Email email;
  final Password password;
  final FormzStatus status;
  final auth.User? user;

  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.user,
  });

  factory LoginState.initial() {
    return LoginState(
      email: const Email.pure(),
      password: const Password.pure(),
      status: FormzStatus.pure,
      user: null,
    );
  }

  @override
  List<Object?> get props => [email, password, status, user];

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    auth.User? user,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}
