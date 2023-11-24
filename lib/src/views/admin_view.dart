import 'package:flutter/material.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  static const String route = '/admin';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Admin')));
  }
}
