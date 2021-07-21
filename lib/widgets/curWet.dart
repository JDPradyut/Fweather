import 'package:flutter/material.dart';
import 'package:fweather/models/curdata.dart';

// ignore: must_be_immutable
class CurrentWeather extends StatelessWidget {
  double height;
  CurDataModel curDataModel;
  CurrentWeather(this.height, this.curDataModel);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: height / 2 - 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                curDataModel.main.temp.toString() + '\u00B0',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 100,
                ),
              ),
              Text(
                curDataModel.weather[0].main,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 30,
                ),
              ),
              Text(
                '\u2191' +
                    curDataModel.main.tempMax.toString() +
                    '\u00B0        \u2193' +
                    curDataModel.main.tempMin.toString() +
                    '\u00B0',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding:
                    EdgeInsets.only(bottom: 5, top: 5, left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black54,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud,
                      color: Colors.white70,
                      size: 18,
                    ),
                    SizedBox(width: 10),
                    Text(
                      curDataModel.main.feelsLike.toString(),
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                padding:
                    EdgeInsets.only(bottom: 5, top: 5, left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black54,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.umbrella,
                      color: Colors.white70,
                      size: 18,
                    ),
                    SizedBox(width: 10),
                    Text(
                      curDataModel.main.humidity.toString() + '%',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
