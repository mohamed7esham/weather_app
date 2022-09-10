class CurrentWeatherModel {
  final WeatherLocation location;
  final WeatherCurrent current;
  final WeatherForeCast forecast;

  CurrentWeatherModel({
    required this.location,
    required this.current,
    required this.forecast,
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherModel(
      location: WeatherLocation.fromJson(json['location'] as Map<String, dynamic>),
      current: WeatherCurrent.fromJson(json['current'] as Map<String, dynamic>),
      forecast: WeatherForeCast.fromJson(json['forecast'] as Map<String, dynamic>),
    );
  }
}

class WeatherLocation {
  final String name;
  final String country;
  final String region;
  final double lat;
  final double lon;
  final String localtime;

  WeatherLocation({
    required this.name,
    required this.country,
    required this.region,
    required this.lat,
    required this.lon,
    required this.localtime,
  });

  factory WeatherLocation.fromJson(Map<String, dynamic> json) {
    return WeatherLocation(
      name: json['name'] as String,
      country: json['country'] as String,
      region: json['region'] as String,
      lat: json['lat'] as double,
      lon: json['lon'] as double,
      localtime: json['localtime'] as String,
    );
  }
}

class WeatherCurrent {
  final double tempC;
  final double tempF;
  final String condition;
  final double feelslikeC;
  final double feelslikeF;
  final double uv;
  final double windKph;
  final int humidity;

  WeatherCurrent({
    required this.tempC,
    required this.tempF,
    required this.condition,
    required this.feelslikeC,
    required this.feelslikeF,
    required this.uv,
    required this.windKph,
    required this.humidity,
  });

  factory WeatherCurrent.fromJson(Map<String, dynamic> json) {
    return WeatherCurrent(
      tempC: json['temp_c'] as double,
      tempF: json['temp_f'] as double,
      condition: json['condition']['text'] as String, //حالة الطقس
      feelslikeC: json['feelslike_c'] as double,
      feelslikeF: json['feelslike_f'] as double,
      uv: json['uv'] as double,
      windKph: json['wind_kph'] as double,
      humidity: json['humidity'] as int,
    );
  }
}
  class WeatherForeCast {
    WeatherForeCast({
       required this.forecastday,
    });

    final List<Forecastday> forecastday;

    factory WeatherForeCast.fromJson(Map<String, dynamic> json) => WeatherForeCast(
        forecastday: List<Forecastday>.from(json["forecastday"].map((x) => Forecastday.fromJson(x))),
    );
}

class Forecastday {
  final String date;
  final int dateEpoch;
  final double maxtempC;
  final double maxtempF;
  final double mintempC;
  final double mintempF;
  final double avghumidity;
  final int dailyChanceOfRain;
  final int dailyChanceOfSnow;
  final String condition;
  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;
  final String moonPhase;
  final String moonIllumination;
  final double uv;
  final List<Hour> hour;

  Forecastday({
    required this.date,
    required this.dateEpoch, 
    required this.maxtempC,
    required this.maxtempF,
    required this.mintempC,
    required this.mintempF,
    required this.avghumidity,
    required this.dailyChanceOfRain,
    required this.dailyChanceOfSnow,
    required this.condition,    
    required this.sunrise, 
    required this.sunset, 
    required this.moonrise, 
    required this.moonset,
    required this.moonPhase, 
    required this.moonIllumination, 
    required this.uv, 
    required this.hour, 
  });

  factory Forecastday.fromJson(Map<String, dynamic> json) {
    return Forecastday(
      date: json['date'] as String,
      dateEpoch: json['date_epoch'] as int,
      maxtempC: json['day']['maxtemp_c'] as double,
      maxtempF: json['day']['maxtemp_f'] as double,
      mintempC: json['day']['mintemp_c'] as double,
      mintempF: json['day']['mintemp_f'] as double,
      avghumidity: json['day']['avghumidity'] as double,
      dailyChanceOfRain: json['day']['daily_chance_of_rain'] as int,
      dailyChanceOfSnow: json['day']['daily_chance_of_snow'] as int,
      condition: json['day']['condition']['text'] as String,
      sunrise: json['astro']['sunrise'] as String,
      sunset: json['astro']['sunset'] as String,
      moonrise: json['astro']['moonrise'] as String,
      moonset: json['astro']['moonset'] as String,
      moonPhase: json['astro']['moon_phase'] as String,
      moonIllumination: json['astro']['moon_illumination'] as String,
      uv: json['day']['uv'] as double,
      hour: List<Hour>.from(json["hour"].map((x) => Hour.fromJson(x))).toList(),
    );
  }
}

class Hour {
    Hour({
        required this.timeEpoch,
        required this.time,
        required this.tempC,
        required this.tempF,
        required this.isDay,
        required this.condition,
        required this.humidity,
        required this.cloud,
        required this.feelslikeC,
        required this.feelslikeF,
        required this.heatindexC,
        required this.heatindexF,
        required this.uv,
    });

    final int timeEpoch;
    final String time;
    final double tempC;
    final double tempF;
    final int isDay;
    final String condition;
    final int humidity;
    final int cloud;
    final double feelslikeC;
    final double feelslikeF;                                                                
    final double heatindexC;
    final double heatindexF;
    final double uv;

    factory Hour.fromJson(Map<String, dynamic> json) => Hour(
        timeEpoch: json["time_epoch"] as int,
        time: json["time"] as String,
        tempC: json["temp_c"] as double,
        tempF: json["temp_f"] as double,
        isDay: json["is_day"] as int,
        condition: json['condition']['text'] as String,
        humidity: json["humidity"] as int,
        cloud: json["cloud"] as int,
        feelslikeC: json["feelslike_c"] as double,
        feelslikeF: json["feelslike_f"] as double,
        heatindexC: json["heatindex_c"] as double,
        heatindexF: json["heatindex_f"] as double,
        uv: json["uv"] as double,
    );
}
