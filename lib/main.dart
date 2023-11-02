import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Color? primColor = Colors.red[500];
    Color? textColor = Colors.white;
    return MaterialApp(
      theme: ThemeData(
        primaryColor: primColor,
        searchBarTheme: SearchBarThemeData(
          backgroundColor: MaterialStateProperty.all(primColor),
          elevation: MaterialStateProperty.all(0.0),
          shape: MaterialStateProperty.all(const BeveledRectangleBorder()),
          textStyle: MaterialStateProperty.all(TextStyle(color: textColor)),
          hintStyle: MaterialStateProperty.all(TextStyle(
              color: textColor, fontSize: 20, fontWeight: FontWeight.w100)),
        ),
        iconTheme: IconThemeData(
          color: textColor,
        ),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: textColor,
              displayColor: textColor,
            ),
        scaffoldBackgroundColor: primColor,
        appBarTheme: AppBarTheme(
          backgroundColor: primColor,
          elevation: 0.0,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Weather Forecast',
      ),
    );
  }

  Widget _searchBar() {
    return SearchAnchor(
      builder: (BuildContext context, SearchController controller) {
        return SearchBar(
          controller: controller,
          hintText: '   Enter City Name',
          leading: const Icon(
            Icons.search,
          ),
          trailing: [
            IconButton(
              onPressed: () {
                controller.clear();
              },
              icon: const Icon(
                Icons.close,
              ),
            ),
          ],
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        return List.empty();
      },
    );
  }

  Widget _cityDetail() {
    DateTime now = DateTime.now();
    String date = DateFormat('EEEE, d MMM, yyyy').format(now);
    return Column(
      children: [
        const Text(
          'New York, USA',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w100,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          date,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w100,
          ),
        ),
      ],
    );
  }

  Widget _temperatureDetail() {
    Random rand = Random();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.light_mode,
          size: 90,
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          children: [
            Text(
              '${rand.nextInt(10) + 10} °F',
              style: const TextStyle(
                fontSize: 65,
                fontWeight: FontWeight.w100,
                fontFeatures: [
                  FontFeature.tabularFigures(),
                ],
              ),
            ),
            const Text(
              'Light Snow',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _extraDetailElement(String first, String second) {
    return Column(
      children: [
        const Icon(
          Icons.ac_unit,
          size: 30,
        ),
        Text(
          first,
          style: const TextStyle(fontWeight: FontWeight.w100, fontSize: 20),
        ),
        Text(
          second,
          style: const TextStyle(
            fontWeight: FontWeight.w100,
          ),
        ),
      ],
    );
  }

  Widget _extraWeatherDetail() {
    Random rand = Random();
    const int range = 5;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _extraDetailElement('${rand.nextInt(range)}', r'km/hr'),
        _extraDetailElement('${rand.nextInt(range)}', '%'),
        _extraDetailElement('${rand.nextInt(range)}', '%'),
      ],
    );
  }

  Widget _weekDetail(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          '7-DAY WEATHER FORECAST',
          style: TextStyle(
            fontWeight: FontWeight.w100,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          height: MediaQuery.of(context).size.height / 8,
          child: ScrollConfiguration(
            behavior: const MaterialScrollBehavior().copyWith(dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.trackpad,
              PointerDeviceKind.stylus,
              PointerDeviceKind.unknown,
            }),
            child: Scrollbar(
              thickness: 3.0,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  const double size = 30;
                  DateTime now = DateTime.now();
                  now = now.add(Duration(days: index));
                  List<Icon> icons = [
                    const Icon(
                      Icons.light_mode,
                      size: size,
                    ),
                    const Icon(
                      Icons.ac_unit,
                      size: size,
                    ),
                    const Icon(
                      Icons.cloud,
                      size: size,
                    )
                  ];
                  Random rand = Random();
                  int temperature = rand.nextInt(20);
                  return Padding(
                    padding: const EdgeInsets.only(
                        right: 10.0, left: 10.0, bottom: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.height / 6,
                      color: Colors.red[200],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              DateFormat('EEEE').format(now),
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                '$temperature °F',
                                style: const TextStyle(
                                  fontSize: size,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                              icons[temperature % 3],
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _body(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              _searchBar(),
              const SizedBox(
                height: 12,
              ),
              _cityDetail(),
              const SizedBox(
                height: 40,
              ),
              _temperatureDetail(),
              const SizedBox(
                height: 60,
              ),
              _extraWeatherDetail(),
              const SizedBox(
                height: 60,
              ),
              _weekDetail(context),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(context),
    );
  }
}
