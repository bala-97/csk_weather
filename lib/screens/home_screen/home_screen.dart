import 'package:cks_weather/blocs/home_bloc.dart';
import 'package:cks_weather/blocs/home_vm.dart';
import 'package:cks_weather/models/weather_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

/// Home screen of the app
/// Launched first when the app starts
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeVm>(
      builder: (context, homeVm) {
        return ValueListenableBuilder<Box<WeatherReport>>(
            valueListenable: homeVm.weatherReportListener,
            builder: (context, box, localWidget) {
              final WeatherReport? report = box.get(homeVm.defaultRecordLocation);
              return ListView(
                children: [
                  const SizedBox(height: 30),
                  if (report != null) _CityAndWeather(report),
                  if (report != null) _ExtraWeatherInfo(homeVm, report),
                  _ClickCounter(homeVm: homeVm),
                  _LoadWeatherReport(homeVm),
                ],
              );
            });
      },
    );
  }
}

class _ClickCounter extends StatelessWidget {
  const _ClickCounter({
    Key? key,
    required this.homeVm,
  }) : super(key: key);

  final HomeVm homeVm;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 100,
      child: StreamBuilder(
          stream: homeVm.counterStream,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            final data = snapshot.hasData ? snapshot.data! : 0;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Text(
                  "$data",
                  textAlign: TextAlign.center,
                  style: textTheme.headline4,
                )),
                Expanded(child: FloatingActionButton(
                  onPressed: () {
                    homeVm.incrementTheCounter(data + 1);
                  },
                  child: const Icon(Icons.add),
                )),
                Expanded(child: FloatingActionButton(
                  onPressed: () {
                    homeVm.switchMode();
                  },
                  child: const Icon(Icons.visibility_outlined),
                )),
              ],
            );
          }),
    );
  }
}

class _CityAndWeather extends StatelessWidget {
  _CityAndWeather(this.report);

  WeatherReport report;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;


    return SizedBox(
      height: size.height * .4,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(report.cityName, style: textTheme.headline5!.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(
            report.localTime!,
            style: textTheme.subtitle1,
          ),
          const SizedBox(height: 10),
          Image.network("https:${report.iconUrl}"),
          const SizedBox(height: 10),
          Text(
            "${report.temperature} \u2103",
            style: textTheme.headline3,
          ),
        ],
      ),
    );
  }
}

class _ExtraWeatherInfo extends StatelessWidget {
  _ExtraWeatherInfo(this.homeVm, this.report);

  HomeVm homeVm;
  WeatherReport report;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * .4,
      width: size.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ExtraInfoCard(
                title: homeVm.windTitle,
                data: "${report.windSpeed} Km/h",
              ),
              _ExtraInfoCard(
                title: homeVm.uvIndexTitle,
                data: "${report.uvIndex}",
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ExtraInfoCard(
                title: homeVm.temperatureTitle,
                data: "${report.temperature} C",
              ),
              _ExtraInfoCard(
                title: homeVm.uvIndexTitle,
                data: "${report.humidity} %",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ExtraInfoCard extends StatelessWidget {
  const _ExtraInfoCard({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)]),
      width: size.width * .4,
      height: 110,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: textTheme.subtitle2,
          ),
          const SizedBox(height: 5),
          Text(
            data,
            style: textTheme.subtitle1!.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _LoadWeatherReport extends StatelessWidget {
  _LoadWeatherReport(this._homeVm);

  HomeVm _homeVm;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * .4,
      width: size.width,
      child: Column(
        children: [
          SizedBox(
            width: size.width * .8,
            child: TextField(
              decoration: InputDecoration(hintText: _homeVm.enterCityNameHint),
              controller: controller,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              _homeVm.loadWeatherReport(controller.text);
            },
            child: Text(_homeVm.loadWeatherButtonTitle),
          )
        ],
      ),
    );
  }
}
