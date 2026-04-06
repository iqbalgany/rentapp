import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentapp/presentations/cubits/car/car_cubit.dart';
import 'package:rentapp/presentations/widgets/car_card.dart';

class CarDetailPage extends StatelessWidget {
  final String carId;
  const CarDetailPage({super.key, required this.carId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline_rounded),
            SizedBox(width: 5),
            Text('Car Details'),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<CarCubit, CarState>(
        builder: (context, carState) {
          return Column(
            children: [
              CarCard(car: carState.cars.firstWhere((car) => car.id == carId)),
              SizedBox(height: 20),

              Container(child: Column(children: [CircleAvatar(radius: 40)])),
            ],
          );
        },
      ),
    );
  }
}
