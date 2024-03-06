import 'package:equatable/equatable.dart';

abstract class RandomDogEvent extends Equatable {
  const RandomDogEvent();

  @override
  List<Object> get props => [];
}

class GetRandomDog extends RandomDogEvent {}