part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherFetchDataLoading extends WeatherState {}

final class WeatherFetchDataError extends WeatherState {}

final class WeatherFetchDataSuccess extends WeatherState {
  final Weather weather;

  const WeatherFetchDataSuccess(this.weather);

  @override
  List<Object> get props => [weather];
}
