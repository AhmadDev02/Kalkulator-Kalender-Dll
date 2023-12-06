import 'dart:convert';
import 'package:kalkulator_beta_01/screen/wheater/model/cuaca_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  // final String apiKey;

  // WeatherService(this.apiKey);

  Future<Weather> fetchData(String cityName) async {
    try {
      final queryParameters = {
        'q': cityName,
        'appid': "85b2cb6f3c4d13f05be26fb882307fbf",
        'units': 'metric',
        'lang': 'id'
      };
      final uri = Uri.https(
          'api.openweathermap.org', '/data/2.5/weather', queryParameters);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Data Tidak Ditemukan");
      }
    } catch (e) {
      rethrow;
    }
  }
}
