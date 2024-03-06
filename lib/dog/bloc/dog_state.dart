import 'package:equatable/equatable.dart';
import '../model/random_dog_model.dart';

abstract class DogState extends Equatable {
  const DogState();

  @override
  List<Object?> get props => [];
}

class DogInitial extends DogState {}

class DogLoading extends DogState {}

class DogLoaded extends DogState {
  final DogModel dogModel;

  const DogLoaded(this.dogModel);
}

class DogError extends DogState {
  final String? message;

  const DogError(this.message);
}
