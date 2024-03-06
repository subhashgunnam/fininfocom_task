import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_random_dog_app/dog/bloc/dog_event.dart';
import '../bloc/dog_bloc.dart';
import '../bloc/dog_state.dart';

class RandomDogScreen extends StatefulWidget {
  const RandomDogScreen({super.key});

  @override
  _RandomDogScreenState createState() => _RandomDogScreenState();
}

class _RandomDogScreenState extends State<RandomDogScreen> {
  final DogBloc _newsBloc = DogBloc();

  @override
  void initState() {
    _fetchDog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Dog')),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        _buildRandomImages(),
        OutlinedButton(
          onPressed: _fetchDog,
          child: const Text(
            'Refresh',
          ),
        )
      ]),
    );
  }

  void _fetchDog() {
    _newsBloc.add(GetRandomDog());
  }

  Widget _buildRandomImages() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<DogBloc, DogState>(
          listener: (context, state) {
            if (state is DogError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<DogBloc, DogState>(
            builder: (context, state) {
              if (state is DogInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DogLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DogLoaded) {
                return _buildRandomCard(context, state.dogModel.message);
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildRandomCard(BuildContext context, String? url) {
    return (url != null && url.isNotEmpty)
        ? Card(
            child: Container(
              width: MediaQuery.of(context).size.width,
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
                imageUrl: url,
              ),
            ),
          )
        : const SizedBox();
  }
}
