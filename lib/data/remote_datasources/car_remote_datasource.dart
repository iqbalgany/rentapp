import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentapp/data/models/car_model.dart';

class CarRemoteDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CarModel>> getCars() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('cars')
          .get();

      return snapshot.docs.map((doc) => CarModel.fromMap(doc)).toList();
    } catch (e) {
      throw Exception('Failed to retrieve vehicle data: $e');
    }
  }
}
