import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_random_dog_app/profile/bloc/profile_bloc.dart';
import 'package:flutter_random_dog_app/profile/bloc/profile_event.dart';
import 'package:intl/intl.dart';
import '../bloc/profile_state.dart';
import '../model/profile_model.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  _ProfileInfoScreenState createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  final ProfileBloc _profileBloc = ProfileBloc();

  @override
  void initState() {
    _fetchProfileInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        _buildProfileInfo(),
      ]),
    );
  }

  void _fetchProfileInfo() {
    _profileBloc.add(GetProfile());
  }

  Widget _buildProfileInfo() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _profileBloc,
        child: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProfileLoaded) {
                return _getProfileInfo(
                    context, state.profileModel.results.first);
              } else if (state is ProfileError) {
                return Center(
                    child: OutlinedButton(
                  onPressed: _fetchProfileInfo,
                  child: const Text(
                    'Refresh',
                  ),
                ));
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _getProfileInfo(BuildContext context, Result? profileInfo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
            child: Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: CachedNetworkImage(
                progressIndicatorBuilder: (context, url, progress) => Center(
                  child: CircularProgressIndicator(
                    value: progress.progress,
                  ),
                ),
                imageUrl: profileInfo!.picture.large,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  profileInfo.name.first,
                  style: const TextStyle(
                      fontSize: 24, fontStyle: FontStyle.normal),
                ),
                Text(profileInfo.location.street.name),
                Text(profileInfo.location.city),
                Text(profileInfo.location.country),
              ],
            )
          ],
        )),
        _getLabelWithValue("E-mail", profileInfo.email),
        _getLabelWithValue(
            "DOB", DateFormat.yMMMMEEEEd().format(profileInfo.dob.date)),
        _getLabelWithValue("Number of days passed since registered",
            "${DateTime.now().difference(profileInfo.registered.date).inDays} days"),
        const SizedBox(
          height: 16,
        ),
        Center(
            child: OutlinedButton(
          onPressed: _fetchProfileInfo,
          child: const Text(
            'GetRandomProfile',
          ),
        ))
      ],
    );
  }

  Widget _getLabelWithValue(String label, String value) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              textAlign: TextAlign.start,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(value)
          ],
        ));
  }
}
