import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/custom_widget/custom_loading_screen_widget.dart';
import 'package:weather_app/custom_widget/custom_weather_detailed.dart';
import 'package:weather_app/features/home/bloc/weather_bloc.dart';

import '../../../utils/styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String currentTimezone;
  Widget getWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return Image.asset("assets/1.png");
      case >= 300 && < 400:
        return Image.asset("assets/2.png");
      case >= 500 && < 600:
        return Image.asset("assets/3.png");
      case >= 600 && < 700:
        return Image.asset("assets/4.png");
      case >= 700 && < 800:
        return Image.asset("assets/5.png");
      case == 800:
        return Image.asset("assets/6.png");
      case > 800 && <= 804:
        return Image.asset("assets/7.png");
      default:
        return Image.asset("assets/7.png");
    }
  }

  String getCurrentLocalTime(int hour) {
    switch (hour) {
      case >= 5 && < 12:
        currentTimezone = "Good Mornig";
        return currentTimezone;
      case >= 12 && < 18:
        currentTimezone = "Good Afternoon";
        return currentTimezone;
      case >= 18 && < 22:
        currentTimezone = "Good Evening";
        return currentTimezone;
      default:
        currentTimezone = "Good Night";
        return currentTimezone;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (BuildContext context, state) {
          debugPrint(state.toString());
          if (state is WeatherFetchDataSuccess) {
            return SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: Stack(
                children: [
                  Align(
                    alignment: const AlignmentDirectional(3, -0.3),
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.deepPurple),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-3, -0.3),
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.deepPurple),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0, -1.2),
                    child: Container(
                      height: 300,
                      width: 600,
                      decoration: const BoxDecoration(
                          shape: BoxShape.rectangle, color: Colors.orange),
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                    child: Container(
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 30, right: 30),
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 18,
                              ),
                              kHorizontalSpace(5),
                              kCustomText("${state.weather.areaName}", 16,
                                  FontWeight.w300),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          kCustomText(getCurrentLocalTime(DateTime.now().hour),
                              25, FontWeight.bold),
                          getWeatherIcon(
                              state.weather.weatherConditionCode ?? 0),
                          Center(
                              child: kCustomText(
                                  "${state.weather.temperature!.celsius!.round()}° C",
                                  55,
                                  FontWeight.w600)),
                          Center(
                              child: kCustomText(
                                  state.weather.weatherMain!.toUpperCase(),
                                  25,
                                  FontWeight.w500)),
                          Center(
                              child: kCustomText(
                                  DateFormat("EEEE dd")
                                      .add_jm()
                                      .format(state.weather.date!),
                                  16,
                                  FontWeight.w300)),
                          kverticalSpace(15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              WeatherDetail(
                                  img: "assets/11.png",
                                  firstText: "Sunrise",
                                  secondText: DateFormat()
                                      .add_jm()
                                      .format(state.weather.sunrise!),
                                  firstTextWeight: FontWeight.w300,
                                  secondTextWeight: FontWeight.w700),
                              WeatherDetail(
                                  img: "assets/12.png",
                                  firstText: "Sunset",
                                  secondText: DateFormat()
                                      .add_jm()
                                      .format(state.weather.sunset!),
                                  firstTextWeight: FontWeight.w300,
                                  secondTextWeight: FontWeight.w700),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              WeatherDetail(
                                  img: "assets/13.png",
                                  firstText: "Temp Max",
                                  secondText:
                                      "${state.weather.tempMax!.celsius!.round()}° C",
                                  firstTextWeight: FontWeight.w300,
                                  secondTextWeight: FontWeight.w700),
                              WeatherDetail(
                                  img: "assets/14.png",
                                  firstText: "Temp Min",
                                  secondText:
                                      "${state.weather.tempMin!.celsius!.round()}° C",
                                  firstTextWeight: FontWeight.w300,
                                  secondTextWeight: FontWeight.w700),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          if (state is WeatherFetchDataLoading) {
            return const CustomLoadingScreen();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
