import 'package:flutter_random_dog_app/profile/model/profile_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileApiClient {
  ProfileApiClient();

  final _client = http.Client();

  Future<ProfileModel> getProfileInfo() async {
    var profileUrl = 'https://randomuser.me/api/';
    final http.Response response = await _client.get(Uri.parse(profileUrl));
    var jsonResponse = jsonDecode(response.body);
    var profileResponse = ProfileModel.fromJson(jsonResponse);
    return profileResponse;
  }
}
