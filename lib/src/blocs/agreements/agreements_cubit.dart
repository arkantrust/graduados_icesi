import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/src/models/agreement.dart';

part 'agreements_state.dart';

class AgreementsCubit extends Cubit<AgreementsState> {
  AgreementsCubit() : super(const AgreementsState.initial());

  final List<Agreement> _agreements = [
    Agreement(
      id: '1',
      name: 'Lacordaire',
      description:
          '25% descuento matrícula escolar 10% descuento pensión a partir de párvulos\n15% descuento matrícula para familias que lleven referidos desde párvulos hasta séptimo.',
      category: Category.schools,
      isPremium: false,
      image:
          'https://agenda.lacordaire.edu.co/imagenes/principal/logo-lacordaire.png',
      rating: 4.0,
    ),
    Agreement(
      id: '2',
      name: 'Cañaverales International School',
      description:
          '30% de descuento en el Derecho de Asociación a la Corporación Cañaverales, que realice el pago diferido del mismo.\n40% de descuento en el Derecho de Asociación a la Corporación Cañaverales, que realice el pago de contado del mismo.',
      category: Category.schools,
      isPremium: true,
      image:
          'https://www.icesi.edu.co/images/egresados/convenios/logo-canaverales-international-school.png',
      rating: 4.8,
    ),
    Agreement(
      id: '3',
      name: 'La Churreria Antigua ',
      description: '10% de descuento en todos los productos.',
      category: Category.restaurants,
      isPremium: false,
      image:
          'https://www.icesi.edu.co/images/egresados/convenios/logo-churreria-antigua-act.png',
      rating: 4.5,
    ),
    Agreement(
      id: '4',
      name: 'Convenio 4',
      description: '50% de descuento en todos los productos.',
      category: Category.restaurants,
      isPremium: true,
      image: 'https://picsum.photos/400',
      rating: 4,
    ),
    Agreement(
      id: '5',
      name: 'COLMEDICA',
      description:
          r'Planes desde $197.034 con muchos beneficios para los Egresados.',
      category: Category.medicine,
      isPremium: true,
      image:
          'https://www.icesi.edu.co/images/egresados/convenios/logo-colmedica.png',
      rating: 5,
    ),
    Agreement(
      id: '6',
      name: 'Convenio 6',
      description: r'Ofertas todos los míercoles',
      category: Category.medicine,
      isPremium: false,
      image: 'https://picsum.photos/400',
      rating: 5,
    ),
    Agreement(
      id: '7',
      name: 'Hotel Marriot',
      description: '35% de descuento en alimentación',
      category: Category.hotels,
      isPremium: true,
      image: 'https://picsum.photos/400',
      rating: 4.8,
    ),
    Agreement(
      id: '8',
      name: 'Hotel Hilton Garden Inn Santa Marta',
      description:
          '15% de descuento sobre la tarifa con desayuno\n10% de descuento en alimentación',
      category: Category.hotels,
      isPremium: false,
      image:
          'https://www.icesi.edu.co/images/egresados/convenios/hilton-garden-inn-santa-marta.png',
      rating: 3.5,
    ),
    Agreement(
      id: '7',
      name: 'Bodytech',
      description:
          'Beneficios y tarifas preferenciales del área corporativa de BODYTECH.',
      category: Category.miscellaneous,
      image:
          'https://www.icesi.edu.co/images/egresados/convenios/logo-bodytech.png',
      isPremium: false,
      rating: 5,
    ),
  ];

  List<Agreement> fetchAgreements() {
    emit(const AgreementsState.loading());
    emit(AgreementsState.loaded(_agreements));
    return _agreements;
  }

  List<Agreement> loadAgreements(Category category) {
    emit(const AgreementsState.loading());
    emit(AgreementsState.loaded(_agreements
        .where((agreement) => agreement.category == category)
        .toList()));
    return _agreements
        .where((agreement) => agreement.category == category)
        .toList();
  }
}
