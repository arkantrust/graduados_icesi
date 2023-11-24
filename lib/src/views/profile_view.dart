import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/src/models/user.dart';
import '/src/auth/cubit/auth_cubit.dart';
import '/src/widgets/header.dart';
import 'views.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  static const String route = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          header(context),
          const SliverToBoxAdapter(child: SizedBox(height: 50)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (!state.authenticated) {
                    return Center(
                        child: TextButton(
                      child: const Text(
                        'Iniciar sesión',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () => context.go(LoginView.route),
                    ));
                  } else if (state.authenticated) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SelectableText(
                          'Bienvenido a tu perfil',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 50),
                        properties(state.user, MediaQuery.sizeOf(context)),
                        const SizedBox(height: 50),
                        ElevatedButton(
                          onPressed: () {
                            context.read<AuthCubit>().logout();
                            context.go(HomeView.route);
                          },
                          child: const Text('Cerrar sesión'),
                        ),
                        const SizedBox(width: 50),
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 50)),
          // SliverToBoxAdapter(child: footer()),
        ],
      ),
    );
  }

  Widget properties(User user, Size size) {
    ImageProvider picture = user.photo.isNotEmpty
        ? NetworkImage(user.photo)
        : const AssetImage('images/unknown-user.jpeg') as ImageProvider;

    return Container(
      decoration: user.isPremium() ? premiumDecor() : null,
      width: size.width * 1 / 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: picture,
          ),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                property('Nombre', user.name),
                const SizedBox(height: 20),
                property('Correo', user.email),
                const SizedBox(height: 20),
                property('Carrera', user.career),
                const SizedBox(height: 20),
                property('Membresía', _membershipNames[user.membership]!)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget property(String label, String value) {
    return Row(
      children: [
        SelectableText(
          '$label:',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 10),
        SelectableText(
          value,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  premiumDecor() => BoxDecoration(
      border: Border.all(color: const Color.fromRGBO(0, 0, 0, 1), width: 2),
      borderRadius: BorderRadius.circular(50),
      gradient: const LinearGradient(colors: [
        Color.fromRGBO(255, 30, 241, 1),
        Color.fromRGBO(255, 30, 241, 0.3)
      ]));
}

const Map<Membership, String> _membershipNames = {
  Membership.free: 'Regular',
  Membership.premium: 'Premium',
};
