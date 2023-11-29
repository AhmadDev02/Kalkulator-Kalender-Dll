import 'package:flutter/material.dart';
import 'package:kalkulator_beta_01/screen/kalender/kalender.dart';
import 'package:kalkulator_beta_01/screen/kalkulator/kalkulator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String routeName = '/homescreen';

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double tabBarHeight = 60; // Ganti dengan tinggi TabBar Anda
            double screenHeight = constraints.maxHeight;
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: TabBar(
                      labelColor: const Color.fromARGB(144, 144, 177, 1000),
                      unselectedLabelColor: Colors.white,
                      controller: tabController,
                      indicatorColor: Colors.white,
                      tabs: const [
                        Icon(
                          Icons.calculate,
                          size: 40,
                        ),
                        Icon(
                          Icons.calendar_month,
                          size: 40,
                        ),
                        Icon(
                          Icons.cloud,
                          size: 40,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight - tabBarHeight,
                  width: double.maxFinite,
                  child: TabBarView(
                    controller: tabController,
                    children: const [
                      Kalkulator(),
                      Kalender(),
                      Text(
                        'Masih Tahap develop',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
