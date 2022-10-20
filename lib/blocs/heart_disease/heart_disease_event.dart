part of 'heart_disease_bloc.dart';

abstract class HeartDiseaseEvent extends Equatable {
  const HeartDiseaseEvent();

  @override
  List<Object> get props => [];
}

class HeartDiseasePrediction extends HeartDiseaseEvent {
  final HeartDiseaseFormModel data;

  const HeartDiseasePrediction(this.data);

  @override
  List<Object> get props => [data];
}
