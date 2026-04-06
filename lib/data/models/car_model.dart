// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class CarModel {
  final String id;
  final String model;
  final double distance;
  final double fuelCapacity;
  final double pricePerHour;
  CarModel({
    required this.id,
    required this.model,
    required this.distance,
    required this.fuelCapacity,
    required this.pricePerHour,
  });

  CarModel copyWith({
    String? id,
    String? model,
    double? distance,
    double? fuelCapacity,
    double? pricePerHour,
  }) {
    return CarModel(
      id: id ?? this.id,
      model: model ?? this.model,
      distance: distance ?? this.distance,
      fuelCapacity: fuelCapacity ?? this.fuelCapacity,
      pricePerHour: pricePerHour ?? this.pricePerHour,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'model': model,
      'distance': distance,
      'fuelCapacity': fuelCapacity,
      'pricePerHour': pricePerHour,
    };
  }

  factory CarModel.fromMap(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return CarModel(
      id: snapshot.id,
      model: (data['model'] ?? ''),
      distance: (data['distance'] ?? 0).toDouble(),
      fuelCapacity: (data['fuelCapacity'] ?? 0).toDouble(),
      pricePerHour: (data['pricePerHour'] ?? 0).toDouble(),
    );
  }
}
