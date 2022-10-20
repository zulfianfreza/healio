part of 'health_bloc.dart';

abstract class HealthEvent extends Equatable {
  const HealthEvent();

  @override
  List<Object> get props => [];
}

class HealthGetHeartRate extends HealthEvent {}

class HealthGetAllHeartRate extends HealthEvent {}

class HealthGetBloodOxygen extends HealthEvent {}

class HealthGetAllBloodOxygen extends HealthEvent {}

class HealthGetLandingPage extends HealthEvent {}
