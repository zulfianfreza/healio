part of 'heart_disease_bloc.dart';

abstract class HeartDiseaseState extends Equatable {
  const HeartDiseaseState();

  @override
  List<Object> get props => [];
}

class HeartDiseaseInitial extends HeartDiseaseState {}

class HeartDiseaseLoading extends HeartDiseaseState {}

class HeartDiseaseFailed extends HeartDiseaseState {
  final String e;
  const HeartDiseaseFailed(this.e);

  @override
  List<Object> get props => [e];
}

class HeartDiseaseSuccess extends HeartDiseaseState {
  final Map<String, dynamic> data;
  const HeartDiseaseSuccess(this.data);

  @override
  List<Object> get props => [data];
}
