import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:rentapp/data/models/car_model.dart';
import 'package:rentapp/presentations/cubits/car/car_cubit.dart';

class MapsDetailPage extends StatelessWidget {
  final String carId;
  const MapsDetailPage({super.key, required this.carId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: BlocBuilder<CarCubit, CarState>(
        builder: (context, carState) {
          return Stack(
            children: [
              FlutterMap(
                options: MapOptions(
                  initialZoom: 13,
                  initialCenter: LatLng(-7.258225584040908, 112.74908238068296),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: "com.example.rentapp",
                  ),
                ],
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: carDetailsCard(
                  carState.cars.firstWhere((car) => car.id == carId),
                ),
              ),

              Positioned(
                right: 10,
                bottom: 200,
                child: Image.network(
                  height: 120,
                  carState.cars.firstWhere((car) => car.id == carId).imageUrl,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget carDetailsCard(CarModel car) {
    return SizedBox(
      height: 350,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  spreadRadius: 0,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  car.model,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.directions_car, color: Colors.white, size: 16),
                    SizedBox(width: 5),
                    Text(
                      '> ${car.distance} km',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.battery_full, color: Colors.white, size: 14),
                    SizedBox(width: 5),
                    Text(
                      '${car.fuelCapacity}',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Features',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  featureIcons(),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${car.pricePerHour.toStringAsFixed(2)}/day',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.black),
                        ),
                        child: Text(
                          'Book Now',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget featureIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        featureIcon(Icons.local_gas_station, 'diesel', 'Common Rail'),
        featureIcon(Icons.speed, 'Acceleration', '0 - 100km/s'),
        featureIcon(Icons.ac_unit, 'Cold', 'Temp Control'),
      ],
    );
  }

  Widget featureIcon(IconData icon, String title, String subtitle) {
    return Container(
      width: 100,
      height: 100,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, size: 28),
          Text(title),
          Text(subtitle, style: TextStyle(color: Colors.grey, fontSize: 10)),
        ],
      ),
    );
  }
}
