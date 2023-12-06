import 'package:flutter/material.dart';
import 'package:kalkulator_beta_01/screen/wheater/model/cuaca_model.dart';
import 'package:kalkulator_beta_01/screen/wheater/service/cuaca_service.dart';
import 'package:lottie/lottie.dart';

class Cuaca extends StatefulWidget {
  const Cuaca({super.key});

  @override
  State<Cuaca> createState() => _CuacaState();
}

class _CuacaState extends State<Cuaca> {
  TextEditingController controller = TextEditingController();
  WeatherService weatherService = WeatherService();
  Weather weather = Weather();
  bool isFecth = false;
  String errorMessage = '';

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/lottie/cerah.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/lottie/berawan.json';
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/lottie/berasap.json';
      case 'rain':
      case 'shower rain':
        return 'assets/lottie/hujan.json';
      case 'thunderstorm':
        return 'assets/lottie/petir.json';
      case 'clear':
        return 'assets/lottie/cerah.json';
      case 'drizzle':
        return 'assets/lottie/gerimis.json';
      case 'snow':
        return 'assets/lottie/salju.json';
      default:
        return 'assets/lottie/awan.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isFecth
                  ? errorMessage.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.white,
                              ),
                              Text(
                                weather.cityName,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Lottie.asset(
                                  getWeatherAnimation(weather.mainCondition)),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                '${weather.temperature}°C',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                weather.description,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 250),
                          child: Column(
                            children: [
                              Text(
                                errorMessage,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    isFecth = false;
                                    errorMessage = '';
                                  });
                                },
                                child: const Text(
                                  'Kembali',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                  : SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset('assets/lottie/onboardcuaca.json'),
                          const Text(
                            "WELCOME TO WEATHER",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const Text(
                            "Kondisi Cuaca Yang Ingin Dikunjungi",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(15),
                    hintText: 'Masukkan Nama Tempat',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  elevation: MaterialStateProperty.all(5), // This is for shadow
                  backgroundColor: MaterialStateProperty.all(Colors.purple),
                ),
                onPressed: () async {
                  isFecth = true;
                  try {
                    weather = await weatherService.fetchData(controller.text);
                    errorMessage = '';
                  } catch (e) {
                    errorMessage = 'Tidak ada kota dengan nama tersebut';
                  }
                  setState(() {});
                },
                child: const Text(
                  'Kirim',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
