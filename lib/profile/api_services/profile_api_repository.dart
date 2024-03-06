import 'package:flutter_random_dog_app/profile/api_services/profile_api_client.dart';
import '../model/profile_model.dart';

class ProfileApiRepository {
  final _provider = ProfileApiClient();

  Future<ProfileModel> fetchProfileInfo() {
    return _provider.getProfileInfo();
  }
}

class NetworkError extends Error {}
