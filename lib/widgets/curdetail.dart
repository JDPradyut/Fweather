import 'package:flutter/material.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';
import 'package:fweather/models/curdata.dart';

// ignore: must_be_immutable
class CurrentDetail extends StatelessWidget {
  CurDataModel curDataModel;
  CurrentDetail(this.curDataModel);

  String getSunSetRiseTime(int time) {
    final istTime =
        DateTime.fromMillisecondsSinceEpoch(time * 1000, isUtc: true)
            .add(Duration(hours: 5, minutes: 30));

    if (istTime.hour < 12) {
      return '${istTime.hour}:${istTime.minute} AM';
    }
    return ((istTime.hour - 12).toString() + ':${istTime.minute} PM');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Details',
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(color: Colors.grey),
          Container(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        WeatherIcons.wiWindy,
                        color: Colors.white70,
                      ),
                      Column(
                        children: [
                          Text(
                            'Speed : ' +
                                curDataModel.wind.speed.toString() +
                                ' m/s',
                            style: TextStyle(color: Colors.white70),
                          ),
                          Text(
                            'Gust : ' +
                                curDataModel.wind.gust.toString() +
                                ' m/s',
                            style: TextStyle(color: Colors.white70),
                          ),
                          Text(
                            'Degree : ' + curDataModel.wind.deg.toString(),
                            style: TextStyle(color: Colors.white70),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        WeatherIcons.wiSunrise,
                        color: Colors.white70,
                      ),
                      Column(
                        children: [
                          Text(
                            'SunRise : ' +
                                getSunSetRiseTime(curDataModel.sys.sunrise),
                            style: TextStyle(color: Colors.white70),
                          ),
                          Text(
                            'SunSet : ' +
                                getSunSetRiseTime(curDataModel.sys.sunset),
                            style: TextStyle(color: Colors.white70),
                          ),
                          Text(
                            'Country : ' + curDataModel.sys.country.toString(),
                            style: TextStyle(color: Colors.white70),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        WeatherIcons.wiCloud,
                        color: Colors.white70,
                      ),
                      Column(
                        children: [
                          Text(
                            'Status : ' +
                                curDataModel.weather[0].main.toString(),
                            style: TextStyle(color: Colors.white70),
                          ),
                          Text(
                            'Description : ' +
                                curDataModel.weather[0].description.toString(),
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
