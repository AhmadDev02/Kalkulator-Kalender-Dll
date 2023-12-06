class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final String mainCondition;

  Weather(
      {this.cityName = "",
      this.temperature = 0,
      this.description = "",
      this.mainCondition = ''});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'] ?? '',
      temperature: json['main']['temp'] ?? 0,
      description: json['weather'][0]['description'] ?? "",
      mainCondition: json['weather'][0]['main'],
    );
  }
}
