import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/src/auth/cubit/auth_cubit.dart';
import '/src/views/home_view.dart';
import '/src/app.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const String route = '/login';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'images/icesi-front.jpeg',
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.height * 0.5,
            child: LoginForm(),
          ),
        )
      ],
    );
  }
}

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final TextEditingController email = TextEditingController(),
      password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      elevation: 20,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            // Logo
            Image.asset(
              'images/logo-black.jpeg',
              color: palette.onSurface,
              fit: BoxFit.contain,
              width: 200,
              height: 100,
            ),
            const SizedBox(height: 15),

            TextFormField(
              controller: email,
              decoration: const InputDecoration(
                labelText: 'Email',
                icon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 16),

            _PasswordInput(controller: password),

            const SizedBox(height: 8),

            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => _login(context),
              child: const Text('Iniciar sesión'),
            ),

            const SizedBox(height: 40),

            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SelectableText(
                  '¿No tienes una cuenta aún? ',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Regístrate',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _login(BuildContext context) {
    context.read<AuthCubit>().login(email.text, password.text);
    email.dispose();
    password.dispose();
    context.go(HomeView.route);
  }
}

class _PasswordInput extends StatefulWidget {
  final TextEditingController controller;

  const _PasswordInput({required this.controller});

  @override
  State<_PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  bool hide = true;
  Icon icon = const Icon(Icons.visibility_off);
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: hide,
      decoration: InputDecoration(
        icon: const Icon(Icons.lock),
        labelText: 'Contraseña',
        suffixIcon: GestureDetector(
          onTap: () => setState(
            () {
              hide = !hide;
              icon = hide
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility);
            },
          ),
          child: icon,
        ),
      ),
    );
  }
}
