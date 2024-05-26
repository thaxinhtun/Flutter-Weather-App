import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

import '../../../secret.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherFetchDataLoading()) {
    on<FetchWeatherAPI>(
      (event, emit) async {
        try {
          WeatherFactory weatherFactory =
              WeatherFactory(apiKey, language: Language.ENGLISH);

          Weather weather = await weatherFactory.currentWeatherByLocation(
              event.position.latitude, event.position.longitude);
          emit(WeatherFetchDataSuccess(weather));
        } catch (e) {
          emit(WeatherFetchDataError());
        }
      },
    );
  }
}
