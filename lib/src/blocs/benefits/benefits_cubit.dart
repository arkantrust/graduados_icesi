import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/src/models/benefit.dart';

part 'benefits_state.dart';

class BenefitsCubit extends Cubit<BenefitsState> {
  BenefitsCubit() : super(const BenefitsState.initial());

  final List<Benefit> _benefits = [
    Benefit(
      id: '1',
      name: 'Estudios',
      description:
          'Para estudios de posgrado o programas abiertos de educación continua tienes el 15% de descuento sobre el valor de tu matrícula.',
      url: 'https://www.icesi.edu.co/posgrados/',
      category: Category.education,
      isPremium: false,
      image:
          'https://images.unsplash.com/photo-1535982330050-f1c2fb79ff78?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    Benefit(
      id: '2',
      name: 'Bienestar',
      description:
          'Desde la Oficina de Relación con Graduados, queremos que sigas disfrutando la Universidad y para ello tenemos muchas actividades para que empieces a transformar tu salud, cuerpo y mente.',
      url: 'https://www.icesi.edu.co/bienestar-universitario/',
      category: Category.wellbeing,
      isPremium: false,
      image:
          'https://images.unsplash.com/photo-1541534741688-6078c6bfb5c5?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    Benefit(
      id: '3',
      name: 'Biblioteca',
      description:
          'Ofrecemos un portafolio de servicios que integra variadas fuentes de información científica, académica y cultura, respaldo por un excelente equipo de expertos profesionales de la información y el conocimiento.',
      url: 'https://www.icesi.edu.co/biblioteca/',
      category: Category.library,
      isPremium: false,
      image:
          'https://images.unsplash.com/photo-1521587760476-6c12a4b040da?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8bGlicmFyeXxlbnwwfHwwfHx8MA%3D%3D',
    ),
    Benefit(
      id: '4',
      name: 'Beneficio 4',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam eleifend ipsum ut ullamcorper sagittis. Nam sit amet ligula mattis velit maximus pharetra malesuada vel justo.',
      url: 'https://arkantrust.me/',
      category: Category.values[3 % Category.values.length],
      isPremium: true,
      image: 'https://picsum.photos/400',
    ),
    Benefit(
      id: '5',
      name: 'Beneficio 5',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam eleifend ipsum ut ullamcorper sagittis. Nam sit amet ligula mattis velit maximus pharetra malesuada vel justo.',
      url: 'https://arkantrust.me/',
      category: Category.values[3 % Category.values.length],
      isPremium: false,
      image: 'https://picsum.photos/400',
    ),
    Benefit(
      id: '6',
      name: 'Beneficio 6',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam eleifend ipsum ut ullamcorper sagittis. Nam sit amet ligula mattis velit maximus pharetra malesuada vel justo.',
      url: 'https://arkantrust.me/',
      category: Category.values[3 % Category.values.length],
      isPremium: false,
      image: 'https://picsum.photos/400',
    ),
    Benefit(
      id: '5',
      name: 'Beneficio 5',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam eleifend ipsum ut ullamcorper sagittis. Nam sit amet ligula mattis velit maximus pharetra malesuada vel justo.',
      url: 'https://arkantrust.me/',
      category: Category.values[3 % Category.values.length],
      isPremium: true,
      image: 'https://picsum.photos/400',
    ),
    Benefit(
      id: '5',
      name: 'Beneficio 5',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam eleifend ipsum ut ullamcorper sagittis. Nam sit amet ligula mattis velit maximus pharetra malesuada vel justo.',
      url: 'https://arkantrust.me/',
      category: Category.values[3 % Category.values.length],
      isPremium: false,
      image: 'https://picsum.photos/400',
    ),
    Benefit(
      id: '5',
      name: 'Beneficio 5',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam eleifend ipsum ut ullamcorper sagittis. Nam sit amet ligula mattis velit maximus pharetra malesuada vel justo.',
      url: 'https://arkantrust.me/',
      category: Category.values[3 % Category.values.length],
      isPremium: true,
      image: 'https://picsum.photos/400',
    ),
  ];

  List<Benefit> fetchBenefits() {
    emit(const BenefitsState.loading());
    emit(BenefitsState.loaded(_benefits));
    return _benefits;
  }

  List<Benefit> loadBenefits(Category category) {
    emit(const BenefitsState.loading());
    emit(BenefitsState.loaded(_benefits
        .where((benefit) => benefit.category == category)
        .toList()));
    return _benefits
        .where((benefit) => benefit.category == category)
        .toList();
  }
}
