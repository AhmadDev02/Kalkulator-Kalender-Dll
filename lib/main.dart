import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kalkulator_beta_01/routes.dart';
import 'package:kalkulator_beta_01/screen/home/home.dart';

final helloWorldProvider = Provider((_) => 'Hello world');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null)
      .then((_) => runApp(const ProviderScope(child: MyApp())));
}
// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator Beta 1.0',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Kanit",
        scaffoldBackgroundColor: const Color.fromARGB(66, 72, 101, 1000),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      initialRoute: HomeScreen.routeName,
      routes: routes,
    );
  }
}
