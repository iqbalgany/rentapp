import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rentapp/data/models/car_model.dart';

class CarCard extends StatelessWidget {
  final CarModel car;
  const CarCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 5),
        ],
      ),
      child: Column(
        children: [
          Image.network(car.imageUrl, height: 200),
          Text(
            car.model,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/gps.svg', height: 30),
                  SizedBox(width: 5),
                  Text('${car.distance.toStringAsFixed(0)}km'),
                ],
              ),
              SizedBox(width: 40),
              Row(
                children: [
                  SvgPicture.asset('assets/fuel.svg', height: 30),
                  SizedBox(width: 5),
                  Text('${car.fuelCapacity.toStringAsFixed(0)}L'),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),

          Text(
            '\$${car.pricePerHour.toStringAsFixed(2)}/hour',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
