part of 'auth_cubit.dart';

final class AuthState extends Equatable {
  final bool authenticated;
  final User user;

  const AuthState._(
      {this.authenticated = false, this.user = const User.unknown()});

  const AuthState.unauthenticated() : this._();

  const AuthState.authenticated(User user)
      : this._(authenticated: true, user: user);

  @override
  List<Object> get props => [authenticated, user];
}
