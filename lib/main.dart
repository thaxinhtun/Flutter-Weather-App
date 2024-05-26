import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/custom_widget/custom_loading_screen_widget.dart';
import 'package:weather_app/features/home/bloc/weather_bloc.dart';
import 'package:weather_app/features/home/ui/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: getLocation(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BlocProvider<WeatherBloc>(
                create: (BuildContext context) => WeatherBloc()
                  ..add(FetchWeatherAPI(snapshot.data as Position)),
                child: const HomeScreen());
          } else {
            return const Scaffold(
                backgroundColor: Colors.black, body: CustomLoadingScreen());
          }
        },
      ),
    );
  }
}

Future<Position> getLocation() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error("Location Service are disabled");
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error("Location Permissions are denied");
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error("Location Permission are denied, we cannot access");
  }
  return await Geolocator.getCurrentPosition();
}
