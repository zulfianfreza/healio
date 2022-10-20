part of 'health_bloc.dart';

abstract class HealthState extends Equatable {
  const HealthState();

  @override
  List<Object> get props => [];
}

class HealthInitial extends HealthState {}

class HealthLoading extends HealthState {}

class HealthFailed extends HealthState {
  final String e;
  const HealthFailed(this.e);

  @override
  List<Object> get props => [e];
}

class HealthHeartRateSuccess extends HealthState {
  final List<HealthDataPoint> heartRate;
  const HealthHeartRateSuccess(this.heartRate);

  @override
  List<Object> get props => [heartRate];
}

class HealthAllHeartRateSuccess extends HealthState {
  final List<HealthDataPoint> allHeartRate;
  const HealthAllHeartRateSuccess(this.allHeartRate);

  @override
  List<Object> get props => [allHeartRate];
}

class HealthBloodOxygenSuccess extends HealthState {
  final List<HealthDataPoint> bloodOxygen;
  const HealthBloodOxygenSuccess(this.bloodOxygen);

  @override
  List<Object> get props => [bloodOxygen];
}

class HealthAllBloodOxygenSuccess extends HealthState {
  final List<HealthDataPoint> allBloodOxygen;
  const HealthAllBloodOxygenSuccess(this.allBloodOxygen);

  @override
  List<Object> get props => [allBloodOxygen];
}

class HealthLandingPageSuccess extends HealthState {
  final List<HealthDataPoint> heartRate;
  final List<HealthDataPoint> bloodOxygen;
  const HealthLandingPageSuccess(this.heartRate, this.bloodOxygen);

  @override
  List<Object> get props => [heartRate, bloodOxygen];
}
