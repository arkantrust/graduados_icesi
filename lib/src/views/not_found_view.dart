import 'package:flutter/material.dart';

class NotFoundView extends StatelessWidget {
  const NotFoundView({super.key});

  static const String route = '/404';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Not Found')));
  }
}