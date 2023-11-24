part of 'agreements_cubit.dart';

class AgreementsState extends Equatable {
  final bool isLoading;
  final List<Agreement> agreements;

  const AgreementsState._({
    this.isLoading = false,
    this.agreements = const [],
  });

  const AgreementsState.initial() : this._();

  const AgreementsState.loading() : this._(isLoading: true);

  const AgreementsState.loaded(List<Agreement> agreements)
      : this._(isLoading: false, agreements: agreements);

  @override
  List<Object> get props => [isLoading, agreements];
}
