part of 'benefits_cubit.dart';

class BenefitsState extends Equatable {
  final bool isLoading;
  final List<Benefit> benefits;

  const BenefitsState._({
    this.isLoading = false,
    this.benefits = const [],
  });

  const BenefitsState.initial() : this._();

  const BenefitsState.loading() : this._(isLoading: true);

  const BenefitsState.loaded(List<Benefit> benefits)
      : this._(isLoading: false, benefits: benefits);

  @override
  List<Object> get props => [isLoading, benefits];
}
