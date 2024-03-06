import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/random_dog_model.dart';

class ApiClient {
  ApiClient();

  final _client = http.Client();

  Future<DogModel> getRandomDog() async {
    var dogUrl = 'https://dog.ceo/api/breeds/image/random';
    final http.Response response = await _client.get(Uri.parse(dogUrl));
    var jsonResponse = jsonDecode(response.body);
    var dogResponse = DogModel.fromJson(jsonResponse);
    return dogResponse;
  }
}
