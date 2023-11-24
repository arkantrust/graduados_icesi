import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/app.dart';
import '/src/auth/cubit/auth_cubit.dart';
import '/src/blocs/agreements/agreements_cubit.dart';
import '/src/blocs/benefits/benefits_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthCubit(),
      ),
      BlocProvider(
        create: (context) => AgreementsCubit(),
      ),
      BlocProvider(
        create: (context) => BenefitsCubit(),
      ),
    ],
    child: const App(),
  ));
}
