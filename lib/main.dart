import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_weather_app/features/home/presentation/bloc/weather_bloc.dart';
import 'package:tdd_weather_app/features/home/presentation/pages/weather_page.dart';
import 'package:tdd_weather_app/injection_container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => serviceLocator<WeatherBloc>())],
      child: MaterialApp(
        title: 'TDD Weather App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const WeatherPage(),
      ),
    );
  }
}
