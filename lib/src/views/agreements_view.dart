import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/auth/cubit/auth_cubit.dart';
import '../models/user.dart';
import '/src/blocs/agreements/agreements_cubit.dart';
import '/src/widgets/header.dart';
import '/src/models/agreement.dart';
import '/src/app.dart';

const Map<Category, String> _categoryNames = {
  Category.entertainment: 'Entretenimiento',
  Category.restaurants: 'Restaurantes',
  Category.medicine: 'Medicina',
  Category.schools: 'Colegios',
  Category.construction: 'Constructoras',
  Category.hotels: 'Hoteles',
  Category.content: 'Contenido',
  Category.culture: 'Cultura',
  Category.miscellaneous: 'Varios',
};

class AgreementsView extends StatelessWidget {
  const AgreementsView({super.key});

  static const String route = '/agreements';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          header(context),
          SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 800,
              mainAxisSpacing: 20,
              crossAxisSpacing: 40,
              childAspectRatio: 4,
            ),
            itemBuilder: (context, index) {
              final Category category = Category.values[index];
              return Padding(
                padding: const EdgeInsets.all(20),
                child: MaterialButton(
                  hoverColor: palette.secondary,
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return AgreementView(category: category);
                      },
                    ),
                  ),
                  child: Text(
                    _categoryNames[category]!,
                    style: TextStyle(
                      color: palette.primaryContainer,
                      fontSize: 18,
                    ),
                  ),
                ),
              );
            },
            itemCount: Category.values.length,
          ),
        ],
      ),
    );
  }
}

class AgreementView extends StatelessWidget {
  const AgreementView({required this.category, super.key});

  final Category category;

  @override
  Widget build(BuildContext context) {
    List<Agreement> agreements =
        context.read<AgreementsCubit>().loadAgreements(category);

    if (agreements.isEmpty) {
      List<bool> premiums = [true, false];
      agreements = [];
      for (var i = 0; i < 10; i++) {
        agreements.add(
          Agreement(
            id: i.toString(),
            name: 'Convenio ${i + 1}',
            description: 'Aquí va la descripción',
            category: category,
            isPremium: premiums[(i + 1) % premiums.length],
            rating: i % (agreements.length + 1) + 0.2,
            image: 'https://picsum.photos/${400 + i}',
          ),
        );
      }
    }

    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: agreements.isEmpty
          ? const Center(child: Text('Parece que no hay nada aquí aún'))
          : CustomScrollView(
              slivers: [
                header(context),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      _categoryNames[category]!,
                      style: const TextStyle(
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
                    final Agreement agreement = agreements[index];
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: MaterialButton(
                        onPressed: () {},
                        child: AgreementTile(agreement: agreement),
                      ),
                    );
                  },
                  itemCount: agreements.length,
                ),
              ],
            ),
    );
  }
}

class AgreementTile extends StatelessWidget {
  final Agreement agreement;

  const AgreementTile({super.key, required this.agreement});

  @override
  Widget build(BuildContext context) {
    User user = context.read<AuthCubit>().state.user;

    Color borderColor = agreement.isPremium && user.isPremium()
        ? const Color.fromRGBO(255, 30, 241, 1)
        : palette.background;

    Color bgColor = agreement.isPremium
        ? user.isPremium()
            ? palette.background
            : Colors.grey
        : palette.background;

    Size size = MediaQuery.sizeOf(context);

    return MaterialButton(
      onPressed: () async {
        String title = agreement.name;
        String body = agreement.description;
        if (agreement.isPremium && !user.isPremium()) {
          title = 'Lo sentimos';
          body = 'Adquiere una membresía premium para acceder a este convenio.';
        }

        await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title, style: const TextStyle(fontSize: 28)),
              content: Text(
                body,
                softWrap: true,
                style: const TextStyle(fontSize: 20),
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
                  image: NetworkImage(agreement.image),
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
                    agreement.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    agreement.description,
                    softWrap: true,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Column(
              children: [
                Text(
                  '${agreement.rating}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '★',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
