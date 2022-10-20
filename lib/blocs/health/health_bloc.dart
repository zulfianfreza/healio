import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:health/health.dart';

import '../../services/health_service.dart';

part 'health_event.dart';
part 'health_state.dart';

class HealthBloc extends Bloc<HealthEvent, HealthState> {
  HealthBloc() : super(HealthInitial()) {
    on<HealthEvent>((event, emit) async {
      if (event is HealthGetHeartRate) {
        try {
          DateTime now = DateTime.now();
          DateTime yesterday = now.subtract(const Duration(days: 1));
          final types = [
            HealthDataType.HEART_RATE,
          ];

          emit(HealthLoading());

          final heartRate =
              await HealthService().fetchData(now, yesterday, types);

          emit(HealthHeartRateSuccess(heartRate));
        } catch (e) {
          emit(HealthFailed(e.toString()));
        }
      }

      if (event is HealthGetAllHeartRate) {
        try {
          DateTime now = DateTime.now();
          DateTime yesterday = now.subtract(const Duration(days: 30));
          final types = [
            HealthDataType.HEART_RATE,
          ];

          emit(HealthLoading());

          final allHeartRate =
              await HealthService().fetchData(now, yesterday, types);

          emit(HealthAllHeartRateSuccess(allHeartRate));
        } catch (e) {
          emit(HealthFailed(e.toString()));
        }
      }

      if (event is HealthGetBloodOxygen) {
        try {
          DateTime now = DateTime.now();
          DateTime yesterday = now.subtract(const Duration(days: 1));
          final types = [
            HealthDataType.BLOOD_OXYGEN,
          ];

          emit(HealthLoading());

          final bloodOxygen =
              await HealthService().fetchData(now, yesterday, types);

          emit(HealthBloodOxygenSuccess(bloodOxygen));
        } catch (e) {
          emit(HealthFailed(e.toString()));
        }
      }

      if (event is HealthGetAllBloodOxygen) {
        try {
          DateTime now = DateTime.now();
          DateTime yesterday = now.subtract(const Duration(days: 30));
          final types = [
            HealthDataType.BLOOD_OXYGEN,
          ];

          emit(HealthLoading());

          final bloodOxygen =
              await HealthService().fetchData(now, yesterday, types);

          emit(HealthAllBloodOxygenSuccess(bloodOxygen));
        } catch (e) {
          emit(HealthFailed(e.toString()));
        }
      }

      if (event is HealthGetLandingPage) {
        try {
          DateTime now = DateTime.now();
          DateTime yesterday = now.subtract(const Duration(days: 1));
          final heartRateTypes = [
            HealthDataType.HEART_RATE,
          ];
          final bloodOxygenTypes = [
            HealthDataType.BLOOD_OXYGEN,
          ];

          emit(HealthLoading());

          final heartRate =
              await HealthService().fetchData(now, yesterday, heartRateTypes);
          final bloodOxygen =
              await HealthService().fetchData(now, yesterday, bloodOxygenTypes);

          emit(HealthLandingPageSuccess(heartRate, bloodOxygen));
        } catch (e) {
          emit(HealthFailed(e.toString()));
        }
      }
    });
  }
}
