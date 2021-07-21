import 'package:flutter/material.dart';
import 'package:fweather/models/othcitydata.dart';
import 'package:http/http.dart' as http;

class OtherCities extends StatefulWidget {
  @override
  _OtherCitiesState createState() => _OtherCitiesState();
}

class _OtherCitiesState extends State<OtherCities> {
  OthCityModel delhiModel;
  OthCityModel chenModel;
  OthCityModel mumModel;
  String baseUrl = 'https://api.openweathermap.org/data/2.5/';
  String apiKey = '63bfec5e6637f295dcc92f62314c5cc8';
  bool _isLoaded = false;
  var client = http.Client();
  getData() async {
    var url1 = baseUrl + 'weather?q=delhi&appid=$apiKey&units=metric';
    var url2 = baseUrl + 'weather?q=chennai&appid=$apiKey&units=metric';
    var url3 = baseUrl + 'weather?q=mumbai&appid=$apiKey&units=metric';
    try {
      var res1 = await client.get(url1);
      if (res1.statusCode == 200) {
        var res2 = await client.get(url2);
        if (res2.statusCode == 200) {
          var res3 = await client.get(url3);
          if (res3.statusCode == 200) {
            setState(() {
              //     delhiModel = othCityModelFromJson(res1.body);
              chenModel = othCityModelFromJson(res2.body);
              mumModel = othCityModelFromJson(res3.body);
              _isLoaded = true;
            });
            print('Connected 3');
          }
          print('Connected 2');
        }
        print('Connected 1');
      } else {
        print('Error');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
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
            'Other Cities',
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(color: Colors.grey),
          Container(
            height: 150,
            child: (_isLoaded == false)
                ? Container(
                    child: Center(
                      child: Text(
                        'No Data',
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                    ),
                  )
                : ListView(
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
                            Text(
                              mumModel.main.temp.toString() + '\u00B0',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 40,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  'City : ' + mumModel.name.toString(),
                                  style: TextStyle(color: Colors.white70),
                                ),
                                Text(
                                  'Status : ' + mumModel.weather[0].main,
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              chenModel.main.temp.toString() + '\u00B0',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 40,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  'City : ' + chenModel.name.toString(),
                                  style: TextStyle(color: Colors.white70),
                                ),
                                Text(
                                  'Status : ' + chenModel.weather[0].main,
                                  style: TextStyle(color: Colors.white70),
                                )
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
