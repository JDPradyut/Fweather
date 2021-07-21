import 'dart:convert';

OthCityModel othCityModelFromJson(String str) =>
    OthCityModel.fromJson(json.decode(str));

String othCityModelToJson(OthCityModel data) => json.encode(data.toJson());

class OthCityModel {
  OthCityModel({
    this.weather,
    this.main,
    this.name,
  });

  List<Weather> weather;
  Main main;
  String name;

  factory OthCityModel.fromJson(Map<String, dynamic> json) => OthCityModel(
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        main: Main.fromJson(json["main"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "name": name,
      };
}

class Main {
  Main({
    this.temp,
    this.tempMin,
    this.tempMax,
  });

  int temp;
  int tempMin;
  int tempMax;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"],
        tempMin: json["temp_min"],
        tempMax: json["temp_max"],
      );
}

class Weather {
  Weather({
    this.main,
    this.description,
    this.icon,
  });

  String main;
  String description;
  String icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "main": main,
        "description": description,
        "icon": icon,
      };
}
