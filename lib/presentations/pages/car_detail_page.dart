import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rentapp/presentations/cubits/car/car_cubit.dart';
import 'package:rentapp/presentations/widgets/car_card.dart';
import 'package:rentapp/presentations/widgets/more_card.dart';
import 'package:rentapp/routing/app_router.dart';

class CarDetailPage extends StatefulWidget {
  final String carId;
  const CarDetailPage({super.key, required this.carId});

  @override
  State<CarDetailPage> createState() => _CarDetailPageState();
}

class _CarDetailPageState extends State<CarDetailPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(begin: 1.0, end: 1.5).animate(_controller!)
      ..addListener(() {
        setState(() {});
      });

    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.forward();
    super.dispose();
  }

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
      ),
      body: BlocBuilder<CarCubit, CarState>(
        builder: (context, carState) {
          final car = carState.cars.firstWhere((car) => car.id == widget.carId);
          final otherCars = carState.cars
              .where((c) => c.id != widget.carId)
              .toList();
          return SingleChildScrollView(
            child: Column(
              children: [
                CarCard(car: car),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 170,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 5,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: AssetImage(
                                  'assets/profile.png',
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Iqbal Gany',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '\$4,256',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 20),

                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            context.pushNamed(
                              AppRoutes.mapsDetailName,
                              pathParameters: {'id': car.id},
                            );
                          },
                          child: Container(
                            height: 170,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Transform.scale(
                                scale: _animation!.value,
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'assets/maps2.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(20),
                  itemCount: otherCars.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                  },
                  itemBuilder: (context, index) {
                    final itemCar = otherCars[index];
                    return GestureDetector(
                      onTap: () => context.pushNamed(
                        AppRoutes.carDetailName,
                        pathParameters: {'id': itemCar.id},
                      ),
                      child: MoreCard(car: itemCar),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
