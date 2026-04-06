import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rentapp/presentations/cubits/auth/auth_cubit.dart';
import 'package:rentapp/presentations/cubits/car/car_cubit.dart';
import 'package:rentapp/presentations/widgets/car_card.dart';
import 'package:rentapp/routing/app_router.dart';

class CarListPage extends StatelessWidget {
  const CarListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Cars'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthCubit>().logout();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocBuilder<CarCubit, CarState>(
        builder: (context, carState) {
          return ListView.builder(
            itemCount: carState.cars.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => context.pushNamed(
                  AppRoutes.carDetailName,
                  pathParameters: {'id': carState.cars[index].id},
                ),
                child: CarCard(car: carState.cars[index]),
              );
            },
          );
        },
      ),
    );
  }
}
