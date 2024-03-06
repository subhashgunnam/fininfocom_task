import 'package:flutter_random_dog_app/dog/api_services/api_client.dart';
import '../model/random_dog_model.dart';

class ApiRepository {
  final _provider = ApiClient();

  Future<DogModel> fetchRandomDog() {
    return _provider.getRandomDog();
  }
}

class NetworkError extends Error {}
