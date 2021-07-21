import 'package:flutter/material.dart';
import 'package:fweather/models/curdata.dart';
import 'package:fweather/widgets/curWet.dart';
import 'package:fweather/widgets/curdetail.dart';
import 'package:fweather/widgets/defaultHome.dart';
import 'package:fweather/widgets/header.dart';
import 'package:fweather/widgets/otherCities.dart';
import 'package:fweather/widgets/savedWeather.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_weather_bg/flutter_weather_bg.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //
  String baseUrl = 'https://api.openweathermap.org/data/2.5/';
  String apiKey = '63bfec5e6637f295dcc92f62314c5cc8';
  bool _isLoaded = false;
  String body;
  //

  //
  var client = http.Client();
  CurDataModel curDataModel;
  getCurData() async {
    Position userLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double lat = userLocation.latitude;

    double long = userLocation.longitude;
    final coordinate = Coordinates(lat, long);
    var address = await Geocoder.local.findAddressesFromCoordinates(coordinate);
    var first = address.first;
    var locality = first.locality;
    var url = baseUrl + 'weather?q=$locality&appid=$apiKey&units=metric';
    try {
      var responce = await client.get(url);
      if (responce.statusCode == 200) {
        setState(() {
          body = responce.body;
          curDataModel = curDataModelFromJson(responce.body);
          _isLoaded = true;
        });
        print('Connected');
      } else {
        print('Error');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> refresPage() async {
    setState(() {
      getCurData();
    });
  }

  @override
  void initState() {
    super.initState();
    getCurData();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: (_isLoaded == false)
          ? DefaultHome()
          : Container(
              child: Stack(
              children: [
                WeatherBg(
                  weatherType: (curDataModel.weather[0].main == 'Thunderstrom')
                      ? WeatherType.thunder
                      : (curDataModel.weather[0].main == 'Rain')
                          ? WeatherType.heavyRainy
                          : (curDataModel.weather[0].main == 'Snow')
                              ? WeatherType.heavySnow
                              : (curDataModel.weather[0].main == 'Haze')
                                  ? WeatherType.hazy
                                  : (curDataModel.weather[0].main == 'Dust')
                                      ? WeatherType.dusty
                                      : (curDataModel.weather[0].main == 'Fog')
                                          ? WeatherType.foggy
                                          : (curDataModel.weather[0].main ==
                                                  'Clouds')
                                              ? WeatherType.cloudy
                                              : WeatherType.sunnyNight,
                  height: size.height,
                  width: size.width,
                ),
                SafeArea(
                  child: Center(
                    child: RefreshIndicator(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Header(
                              'Just Updated',
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
                                  OtherCities(),
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
                      onRefresh: refresPage,
                    ),
                  ),
                ),
              ],
            )),
    );
  }
}
