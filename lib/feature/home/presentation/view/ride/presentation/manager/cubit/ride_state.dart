import 'package:equatable/equatable.dart';
import 'package:travel_app/feature/home/presentation/view/ride/data/model/ride_request_model.dart';

abstract class RideState extends Equatable {
  const RideState();

  @override
  List<Object?> get props => [];
}

class RideInitial extends RideState {}

class RideLoading extends RideState {}

class RideSuccess extends RideState {
  final RideRequestModel? ride;

  const RideSuccess(this.ride);

  @override
  List<Object?> get props => [ride];
}

class RideFailure extends RideState {
  final String message;

  const RideFailure(this.message);

  @override
  List<Object?> get props => [message];
}
