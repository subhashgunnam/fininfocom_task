import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_random_dog_app/dog/bloc/dog_state.dart';
import '../api_services/api_repository.dart';
import 'dog_event.dart';

class DogBloc extends Bloc<RandomDogEvent, DogState> {
  DogBloc() : super(DogInitial()) {
    final ApiRepository apiRepository = ApiRepository();

    on<GetRandomDog>((event, emit) async {
      try {
        emit(DogLoading());
        final randomDogData = await apiRepository.fetchRandomDog();
        emit(DogLoaded(randomDogData));
        if (randomDogData.status != "success") {
          emit(const DogError("Failed"));
        }
      } on NetworkError {
        emit(const DogError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
