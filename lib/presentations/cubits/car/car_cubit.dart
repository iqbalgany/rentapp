import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rentapp/data/models/car_model.dart';
import 'package:rentapp/data/remote_datasources/car_remote_datasource.dart';

part 'car_state.dart';

class CarCubit extends Cubit<CarState> {
  final CarRemoteDatasource _datasource;
  CarCubit(this._datasource) : super(const CarState()) {
    fetchCars();
  }

  void fetchCars() async {
    emit(state.copyWith(status: CarStatus.loading));

    try {
      final cars = await _datasource.getCars();
      emit(state.copyWith(status: CarStatus.success, cars: cars));
    } catch (e) {
      emit(
        state.copyWith(status: CarStatus.failure, errorMessage: e.toString()),
      );
    }
  }
}
