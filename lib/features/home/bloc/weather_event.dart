part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchWeatherAPI extends WeatherEvent {
  final Position position;

  const FetchWeatherAPI(this.position);

  @override
  List<Object> get props => [position];
}
