import 'package:flutter/material.dart';
import 'package:hijriyah_indonesia/hijriyah_indonesia.dart';

String arabic = 'ar';
String indonesia = 'id';

void main() {
  /* set locale add this */
  Hijriyah.setLocal(indonesia);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.green.shade800),
            colorScheme: ColorScheme.light(primary: Colors.green.shade800)),
        home: const HomeView());
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Hijriyah Indonesia',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          //to activated pasaran name using isPasaran : true
          Hijriyah.fromDate(DateTime.parse('2024-08-23').toLocal(),
                  isPasaran: true)
              .toFormat("EEEE, dd MMMM yyyy"),
          style: const TextStyle(color: Colors.white),
        ), /* converter to hijriyah indonesia */
      ),
    );
  }
}
