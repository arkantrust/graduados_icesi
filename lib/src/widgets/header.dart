import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import '/src/auth/cubit/auth_cubit.dart';
import '/src/views/views.dart';
import '/src/app.dart';

SliverAppBar header(BuildContext context) => SliverAppBar(
      backgroundColor: palette.primary,
      leading: MaterialButton(
        child: Image.asset(
          'images/icon.jpeg',
          color: palette.onPrimary,
          fit: BoxFit.fill,
        ),
        onPressed: () =>
            js.context.callMethod('open', ['https://www.icesi.edu.co/']),
      ),
      title: Padding(
        padding: const EdgeInsets.all(20.0),
        child: MaterialButton(
          child: Text(
            'Graduados',
            style: TextStyle(
              color: palette.onPrimary,
              backgroundColor: palette.primary,
              fontSize: 42,
            ),
          ),
          onPressed: () => context.go(HomeView.route),
        ),
      ),
      floating: true,
      actions: [
        TextButton(
          child: Text(
            'Convenios',
            style: TextStyle(
              color: palette.onPrimary,
              fontSize: 24,
            ),
          ),
          onPressed: () => context.go(AgreementsView.route),
        ),
        TextButton(
          child: Text(
            'Beneficios',
            style: TextStyle(
              color: palette.onPrimary,
              fontSize: 24,
            ),
          ),
          onPressed: () => context.go(BenefitsView.route),
        ),
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return state.authenticated
                ? MaterialButton(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: state.user.photo.isNotEmpty
                          ? NetworkImage(state.user.photo, scale: 2)
                          : const AssetImage('images/unknown-user.jpeg')
                              as ImageProvider,
                    ),
                    onPressed: () => context.go(ProfileView.route),
                  )
                : Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                      icon: Icon(
                        Icons.login,
                        color: palette.background,
                      ),
                      onPressed: () => context.go(LoginView.route),
                    ),
                );
          },
        ),
      ],
    );
