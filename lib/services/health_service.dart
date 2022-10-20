import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/health_model.dart';

class HealthService {
  final CollectionReference _healthReference =
      FirebaseFirestore.instance.collection('health');

  Future<List<HealthDataPoint>> fetchData(
    DateTime now,
    DateTime yesterday,
    List<HealthDataType> types,
  ) async {
    List<HealthDataPoint> healthDataList = [];
    HealthFactory health = HealthFactory();

    final permissions = [
      HealthDataAccess.READ,
    ];

    bool requested =
        await health.requestAuthorization(types, permissions: permissions);

    await Permission.activityRecognition.request();
    await Permission.location.request();

    if (requested) {
      try {
        List<HealthDataPoint> healthData =
            await health.getHealthDataFromTypes(yesterday, now, types);
        healthDataList.addAll((healthData.length < 100)
            ? healthData
            : healthData.sublist(0, 100));
      } catch (error) {
        throw Exception("Exception in getHealthDataFromTypes: $error");
      }

      healthDataList = HealthFactory.removeDuplicates(healthDataList);

      healthDataList.sort((a, b) {
        var aDate = a.dateFrom;
        var bDate = b.dateFrom;
        return bDate.compareTo(aDate);
      });

      return healthDataList;
    } else {
      throw Exception("Authorization not granted");
    }
  }

  Future<HealthModel> getHeartRateFromFirebase() async {
    try {
      DocumentSnapshot snapshot =
          await _healthReference.doc('heart_rate').get();

      return HealthModel(
        type: snapshot['type'],
        value: snapshot['value'],
        unit: snapshot['unit'],
        dateFrom: snapshot['dateFrom'],
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateHeartRateFromFirebase(
    int value,
    String dateFrom,
  ) async {
    try {
      _healthReference.doc('heart_rate').update({
        'value': value,
        'dateFrom': dateFrom,
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<HealthModel> getBloodOxygenFromFirebase() async {
    try {
      DocumentSnapshot snapshot =
          await _healthReference.doc('blood_oxygen').get();

      return HealthModel(
        type: snapshot['type'],
        value: snapshot['value'],
        unit: snapshot['unit'],
        dateFrom: snapshot['dateFrom'],
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateBloodOxygenFromFirebase(
    int value,
    String dateFrom,
  ) async {
    try {
      _healthReference.doc('blood_oxygen').update({
        'value': value,
        'dateFrom': dateFrom,
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
