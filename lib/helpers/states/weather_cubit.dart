import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riconews/helpers/adapters/weather.dart';
import '../dio_service.dart' as service;

class InitialState extends Weather {
  @override
  Weather get props => Weather();
}

class LoadingState extends Weather {
  @override
  Weather get props => Weather();
}

class LoadedState extends Weather {
  LoadedState(this.weather);
  final Weather weather;
  @override
  double? get latitude => weather.latitude;
  @override
  double? get longitude => weather.longitude;
  @override
  String? get timezone => weather.timezone;
  @override
  String? get timeUnits => weather.timeUnits;
  @override
  String? get temperatureUnits => weather.temperatureUnits;
  @override
  String? get humidityUnits => weather.humidityUnits;
  @override
  String? get precipitationUnits => weather.precipitationUnits;
  @override
  List? get time => weather.time;
  @override
  List? get temperature => weather.temperature;
  @override
  List? get humidity => weather.humidity;
  @override
  List? get precipitation => weather.precipitation;
  @override
  int get index =>
      weather.time?.indexWhere((element) =>
          DateTime.parse(element).hour == DateTime.now().hour &&
          DateTime.parse(element).day == DateTime.now().day) ??
      0;
}

class ErrorState extends Weather {
  @override
  Weather get props => Weather();
}

class WeathersCubit extends Cubit<Weather> {
  WeathersCubit() : super(InitialState()) {
    getWeathers();
  }

  void getWeathers() async {
    try {
      emit(LoadingState());
      Weather weather = Weather();
      Box<Weather> box = await Hive.openBox('weatherBox');
      //TODO: update when day changes
      if (box.containsKey('weather')) {
        weather = box.values.first;
      } else {
        weather = await service.getWeather();
        box.put('weather', weather);
      }
      emit(LoadedState(weather));
    } catch (e) {
      emit(ErrorState());
    }
  }
}

class AppBlocObserver extends BlocObserver {
  /// {@macro app_bloc_observer}
  const AppBlocObserver();

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) print(change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}
