import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/src/views/views.dart';
import '/src/widgets/header.dart';
import '/src/app.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          header(context),
          const SliverToBoxAdapter(child: SizedBox(height: 50)),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HomeSection(
                    title: 'Convenios',
                    description: 'Conozca los convenios para graduados.',
                    imageUrl: 'images/agreements.jpeg',
                    route: AgreementsView.route,
                  ),
                  HomeSection(
                    title: 'Beneficios',
                    description: 'Conozca los beneficios para graduados.',
                    imageUrl: 'images/benefits.jpeg',
                    route: BenefitsView.route,
                    reversed: true,
                  ),
                  HomeSection(
                    title:
                        'Carné', // https://www.rae.es/duda-linguistica/es-carne-o-carnet
                    description:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam eleifend ipsum ut ullamcorper sagittis. Nam sit amet ligula mattis velit maximus pharetra malesuada vel justo.',
                    imageUrl: 'images/id.jpeg',
                    route: ProfileView.route,
                  ),
                  SizedBox(width: 50),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 50)),
          // SliverToBoxAdapter(child: footer()),
        ],
      ),
    );
  }
}

class HomeSection extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String route;
  final bool reversed;

  const HomeSection({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.route,
    this.reversed = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    double height = size.height * (1 / 3);
    double width = size.width;

    Widget image = Image.asset(
      imageUrl,
      height: size.height * (1 / 3),
      width: size.width * (1 / 3) - 30,
      fit: BoxFit.cover,
    );

    return SizedBox(
      height: height,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
            reversed ? [section(context), image] : [image, section(context)],
      ),
    );
  }

  Widget section(BuildContext context) {
    var size = MediaQuery.of(context).size;

    double height = size.height * (1 / 3);
    double width = size.width * (1 / 3) - 30;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: SizedBox(
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SelectableText(
              title,
              style: TextStyle(
                backgroundColor: palette.surface,
                color: palette.onSurface,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: reversed
                  ? const EdgeInsets.only(right: 20, bottom: 15)
                  : const EdgeInsets.only(left: 20, bottom: 15),
              child: SelectableText(
                description,
                textAlign: TextAlign.left,
                style: TextStyle(
                  backgroundColor: palette.surface,
                  color: palette.onSurface,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(const Size(110, 35)),
                backgroundColor: MaterialStateProperty.all(palette.secondary),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              onPressed: () => context.go(route),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text('Ver más',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      backgroundColor: palette.secondary,
                      color: palette.onSecondary,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
