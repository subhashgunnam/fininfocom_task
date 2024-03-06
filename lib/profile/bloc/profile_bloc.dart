import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_random_dog_app/profile/bloc/profile_state.dart';

import '../api_services/profile_api_repository.dart';
import 'profile_event.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    final ProfileApiRepository apiRepository = ProfileApiRepository();

    on<GetProfile>((event, emit) async {
      try {
        emit(ProfileLoading());
        final profileInfo = await apiRepository.fetchProfileInfo();
        emit(ProfileLoaded(profileInfo));
      } on NetworkError {
        emit(
            const ProfileError("Failed to fetch data. is your device online?"));
      }catch(e){
        emit(const ProfileError("Something went wrong, please refresh"));
      }
    });
  }
}
