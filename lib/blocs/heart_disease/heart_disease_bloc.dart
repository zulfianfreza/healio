import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healio/models/heart_disease_form_model.dart';
import 'package:healio/services/heart_disease_service.dart';

part 'heart_disease_event.dart';
part 'heart_disease_state.dart';

class HeartDiseaseBloc extends Bloc<HeartDiseaseEvent, HeartDiseaseState> {
  HeartDiseaseBloc() : super(HeartDiseaseInitial()) {
    on<HeartDiseaseEvent>((event, emit) async {
      if (event is HeartDiseasePrediction) {
        try {
          emit(HeartDiseaseLoading());

          final res = await HeartDiseaseService().prediction(event.data);

          emit(HeartDiseaseSuccess(res));
        } catch (e) {
          emit(HeartDiseaseFailed(e.toString()));
        }
      }
    });
  }
}
