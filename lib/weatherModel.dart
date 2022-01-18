//lets create a User model

class Weather {
  String? temp;
  String? wind;
  String? desc;
  List<Forecast>? forecast;

  Weather({this.temp, this.wind, this.desc, this.forecast});

  //json decode using factory constructor
  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        temp: json['temperature'],
        wind: json['wind'],
        desc: json['description'],
        forecast: List<Forecast>.from(
            json["forecast"].map((x) => Forecast.fromJson(x))),
      );

  //this work similar with Json.Encode()
  Map<String, dynamic> toJson() => {
        "temperature": temp,
        "wind": wind,
        "description": desc,
        "forecast": List<dynamic>.from(forecast!.map((x) => x.toJson())),
      };
}

class Forecast {
  Forecast({
    this.day,
    this.temp,
    this.wind,
  });

  String? day;
  String? temp;
  String? wind;

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
        day: json["day"],
        temp: json["temperature"],
        wind: json["wind"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "temperature": temp,
        "wind": wind,
      };
}
