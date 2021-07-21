import 'package:flutter/material.dart';
import 'package:flutter_weather_bg/flutter_weather_bg.dart';
import 'package:fweather/models/curdata.dart';
import 'package:fweather/widgets/curWet.dart';
import 'package:fweather/widgets/curdetail.dart';
import 'package:fweather/widgets/header.dart';
import 'package:fweather/widgets/savedWeather.dart';

// ignore: must_be_immutable
class DefaultHome extends StatelessWidget {
  static String body =
      '{"coord":{"lon":88.3697,"lat":22.5697},"weather":[{"id":721,"main":"Haze","description":"haze","icon":"50n"}],"base":"stations","main":{"temp":27,"feels_like":31.16,"temp_min":27,"temp_max":27,"pressure":1009,"humidity":94},"visibility":2800,"wind":{"speed":4.12,"deg":210},"clouds":{"all":20},"dt":1618093808,"sys":{"type":1,"id":9114,"country":"IN","sunrise":1618098590,"sunset":1618143896},"timezone":19800,"id":1275004,"name":"Kolkata","cod":200}';
  CurDataModel curDataModel = curDataModelFromJson(body);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        child: Stack(
      children: [
        WeatherBg(
          weatherType: WeatherType.sunnyNight,
          height: size.height,
          width: size.width,
        ),
        SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(
                    'Updating...',
                    curDataModel.name,
                    body,
                    curDataModel.main.temp.toString(),
                    curDataModel.weather[0].main),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: ListView(
                      children: [
                        CurrentWeather(size.height, curDataModel),
                        SizedBox(height: 20),
                        CurrentDetail(curDataModel),
                        SizedBox(height: 20),
                        SavedData(),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  flex: 2,
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
