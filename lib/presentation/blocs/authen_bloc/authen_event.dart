abstract class AuthEvent {}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested(this.email, this.password);
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String phone;
  final String country;

  SignUpRequested(this.email, this.password, this.name, this.phone, this.country);
}

class SignOutRequested extends AuthEvent {}