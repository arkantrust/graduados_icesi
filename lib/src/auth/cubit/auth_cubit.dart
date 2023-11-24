import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '/src/models/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState.unauthenticated());

  final Map _usersTable = {
    'admin': User(
      id: 'admin',
      email: 'admin',
      password: 'admin',
      name: 'Administrador',
      membership: Membership.premium,
      career: 'Administrador',
      photo:
          'data:image/png;base64,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',
    ),
    'david.dulce@u.icesi.edu.co': User(
        id: const Uuid()
            .v5(Uuid.NAMESPACE_URL, 'www.icesi.edu.co')
            .toLowerCase(),
        email: 'david.dulce@u.icesi.edu.co',
        password: 'password',
        name: 'David Dulce',
        membership: Membership.premium,
        career: 'Ingeniería Telemática',
        photo:
            'https://cdn.pixabay.com/photo/2023/10/18/08/17/rose-8323259_960_720.jpg'),
  };

  void login(String email, String password) {
    User user = _usersTable.putIfAbsent(
      email,
      () => User(
          id: const Uuid()
              .v5(Uuid.NAMESPACE_URL, 'www.icesi.edu.co')
              .toLowerCase(),
          email: email.toLowerCase(),
          password: password,
          name: email
              .split('@')
              .first
              .split('.')
              .map((word) => word.isNotEmpty
                  ? '${word[0].toUpperCase()}${word.substring(1)}'
                  : '')
              .join(' '),
          membership: Membership.free,
          career: 'Ingeniería Telemática',
          photo: 'https://picsum.photos/400'),
    );

    emit(AuthState.authenticated(user));
  }

  void logout() => emit(const AuthState.unauthenticated());
}
