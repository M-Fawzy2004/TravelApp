part of 'governorate_cubit.dart';

abstract class GovernorateState extends Equatable {
  const GovernorateState();

  @override
  List<Object> get props => [];
}

class GovernorateInitial extends GovernorateState {}

class GovernorateLoading extends GovernorateState {}

class GovernorateSuccess extends GovernorateState {
  final List<GovernorateModel> governorates;

  const GovernorateSuccess({required this.governorates});

  @override
  List<Object> get props => [governorates];
}

class GovernorateFailure extends GovernorateState {
  final String message;

  const GovernorateFailure({required this.message});

  @override
  List<Object> get props => [message];
}
