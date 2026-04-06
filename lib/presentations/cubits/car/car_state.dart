// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'car_cubit.dart';

enum CarStatus { initial, loading, success, failure }

class CarState extends Equatable {
  final CarStatus status;
  final List<CarModel> cars;
  final String? errorMessage;
  const CarState({
    this.status = CarStatus.initial,
    this.cars = const [],
    this.errorMessage = '',
  });

  @override
  List<Object?> get props => [status, cars, errorMessage];

  CarState copyWith({
    CarStatus? status,
    List<CarModel>? cars,
    String? errorMessage,
  }) {
    return CarState(
      status: status ?? this.status,
      cars: cars ?? this.cars,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
