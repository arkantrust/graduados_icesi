import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import '/src/auth/cubit/auth_cubit.dart';
import '/src/blocs/benefits/benefits_cubit.dart';
import '/src/models/benefit.dart';
import '/src/widgets/header.dart';
import '/src/app.dart';

class BenefitsView extends StatelessWidget {
  const BenefitsView({super.key});

  static const String route = '/benefits';

  @override
  Widget build(BuildContext context) {
    List<Benefit> benefits = context.read<BenefitsCubit>().fetchBenefits();

    if (benefits.isEmpty) {
      List<bool> premiums = [true, false];
      benefits = [];
      for (var i = 0; i < 10; i++) {
        benefits.add(
          Benefit(
            id: i.toString(),
            name: 'Beneficio ${i + 1}',
            description: 'Aquí va la descripción',
            url: 'https://www.arkantrust.me',
            category: Category.values[i % Category.values.length],
            isPremium: premiums[(i + 1) % premiums.length],
            image: 'https://picsum.photos/${400 + i}',
          ),
        );
      }
    }

    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: benefits.isEmpty
          ? const Center(child: Text('Parece que no hay nada aquí aún'))
          : CustomScrollView(
              slivers: [
                header(context),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Beneficios',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SliverGrid.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: size.width * 0.42,
                    mainAxisExtent: size.height * 0.25,
                  ),
                  itemBuilder: (context, index) {
                    final Benefit benefit = benefits[index];
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: MaterialButton(
                        onPressed: () {},
                        child: BenefitTile(benefit: benefit),
                      ),
                    );
                  },
                  itemCount: benefits.length,
                ),
              ],
            ),
    );
  }
}

class BenefitTile extends StatelessWidget {
  final Benefit benefit;

  const BenefitTile({super.key, required this.benefit});

  @override
  Widget build(BuildContext context) {
    var user = context.read<AuthCubit>().state.user;

    Color borderColor = benefit.isPremium && user.isPremium()
        ? const Color.fromRGBO(255, 30, 241, 1)
        : palette.background;

    Color bgColor = benefit.isPremium
        ? user.isPremium()
            ? palette.background
            : Colors.grey
        : palette.background;

    Size size = MediaQuery.sizeOf(context);

    return MaterialButton(
      onPressed: () async {
        String title = benefit.name;
        String body = benefit.description;
        if (benefit.isPremium && !user.isPremium()) {
          title = 'Lo sentimos';
          body =
              'Adquiere una membresía premium para acceder a este beneficio.';
        }
        await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title, style: const TextStyle(fontSize: 28)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: size.width / 4,
                    child: Text(
                      body,
                      softWrap: true,
                      textWidthBasis: TextWidthBasis.parent,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox.fromSize(size: size / 32),
                  MaterialButton(
                     elevation: 20,
                      child: const Text(
                        'Accede aquí',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20
                        ),
                      ),
                      onPressed: () =>
                          js.context.callMethod('open', [benefit.url]))
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      },
      child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(color: borderColor, width: 5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                width: size.width * 1 / 16,
                height: size.height * 1 / 16,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(benefit.image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      benefit.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      benefit.description,
                      softWrap: true,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
