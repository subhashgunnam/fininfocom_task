import 'package:flutter/material.dart';
import 'package:flutter_random_dog_app/profile/ui/profile_info_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'bluetooth/bluetooth_provider.dart';
import 'dog/ui/dog_detail.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final GoRouter _router = GoRouter(
  initialLocation: "/",
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyHomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: DogRoute.randomImage.route,
          name: DogRoute.randomImage.name,
          builder: (BuildContext context, GoRouterState state) {
            return const RandomDogScreen();
          },
        ),
        GoRoute(
          path: DogRoute.profile.route,
          name: DogRoute.profile.name,
          builder: (BuildContext context, GoRouterState state) {
            return const ProfileInfoScreen();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("DashBoard"),
          backgroundColor: Colors.blueAccent, //
        ),
        body: Container(
          margin: const EdgeInsets.all(16),
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
            children: [
              GestureDetector(
                onTap: () {
                  context.pushNamed(DogRoute.randomImage.name);
                },
                child: const Card(
                  color: Colors.cyan,
                  child: Center(
                    child: Text(
                      "Dog",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  enableBluetooth();
                },
                child: const Card(
                  color: Colors.pinkAccent,
                  child: Center(
                      child: Text(
                    "Bluetooth",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.pushNamed(DogRoute.profile.name);
                },
                child: const Card(
                  color: Colors.blueAccent,
                  child: Center(
                      child: Text(
                    "Profile",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ],
          ),
        ));
  }
}

enum DogRoute {
  randomImage("RandomDogDetail"),
  bluetooth("BlueTooth"),
  profile("Profile");

  final String name;

  const DogRoute(this.name);

  String get route {
    return name;
  }
}
