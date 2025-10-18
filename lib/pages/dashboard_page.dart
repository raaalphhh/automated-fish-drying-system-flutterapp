import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Color buttonColor = Colors.green;
  bool isFirstPress = true;
  double temperature = 0.0;
  List<FlSpot> temperatureData =
      List.generate(10, (index) => FlSpot(index.toDouble(), 0.0));
  double yAxisMax = 50;

  DateTime? startTime;
  Duration elapsedDuration = Duration.zero;

  void updateDuration() {
    if (startTime != null) {
      setState(() {
        elapsedDuration = DateTime.now().difference(startTime!);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    listenToRealTimeData();
    checkSessionStatus();
  }

  void checkSessionStatus() {
    final ref =
        FirebaseDatabase.instance.ref('fish_drying_system/session_active');

    ref.onValue.listen((event) {
      final isActive = event.snapshot.value as bool? ?? false;

      setState(() {
        buttonColor = isActive ? Colors.red : Colors.green;
        isFirstPress = !isActive;
      });
    });
  }

  void listenToRealTimeData() {
    final ref = FirebaseDatabase.instance.ref('fish_drying_sessions/real_time');

    ref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as Map?;

      if (data != null) {
        setState(() {
          double newTemp = (data['temp'] ?? 0).toDouble();
          int durationSeconds = (data['duration'] ?? 0).toInt();

          temperatureData.removeAt(0);
          temperatureData.add(FlSpot(temperatureData.last.x + 1, newTemp));

          temperature = newTemp;
          elapsedDuration = Duration(seconds: durationSeconds);

          if (newTemp > yAxisMax) {
            yAxisMax = (newTemp > 100) ? ((newTemp ~/ 20) + 1) * 20 : 100;
          } else if (newTemp < 50) {
            yAxisMax = 50;
          }
        });
      }
    });
  }

  void onFabPressed() async {
    try {
      final ref = FirebaseDatabase.instance.ref('fish_drying_system/esp32_ip');
      final snapshot = await ref.get();

      if (!snapshot.exists) {
        print("ESP32 IP not found in Firebase.");
        return;
      }

      final ip = snapshot.value.toString();
      final response = await http.get(Uri.parse('http://$ip/fab_pressed'));

      if (response.statusCode == 200) {
        print("FAB Pressed.");
        setState(() {
          if (isFirstPress) {
            startTime = DateTime.now();
            elapsedDuration = Duration.zero;
            buttonColor = Colors.red;
            isFirstPress = false;
          } else {
            buttonColor = Colors.green;
            isFirstPress = true;
          }
        });
      } else {
        print("Failed to trigger FAB.");
      }
    } catch (e) {
      print("Error sending FAB request: $e");
    }
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'Real-Time Temperature Graph',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 25.0, 16.0, 20.0),
              child: LineChart(
                LineChartData(
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      tooltipBgColor: Colors.black54,
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((spot) {
                          return LineTooltipItem(
                            "${spot.y.toStringAsFixed(2)} °C",
                            TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }).toList();
                      },
                    ),
                    handleBuiltInTouches: true,
                    getTouchedSpotIndicator: (barData, indicators) {
                      return indicators.map((int index) {
                        return TouchedSpotIndicatorData(
                          FlLine(color: Colors.white, strokeWidth: 2),
                          FlDotData(show: true),
                        );
                      }).toList();
                    },
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 10,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            "${value.toInt()} °C",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: const Color.fromARGB(255, 204, 33, 33),
                                  fontSize: 12,
                                ),
                          );
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: temperatureData,
                      isCurved: true,
                      color: Colors.red,
                      barWidth: 3,
                      isStrokeCapRound: true,
                    ),
                  ],
                  minY: 0,
                  maxY: yAxisMax,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Temperature: ${temperature.toStringAsFixed(2)} °C',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          SizedBox(height: 10),
          Text(
            'Drying Duration: ${formatDuration(elapsedDuration)}',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: onFabPressed,
            backgroundColor: buttonColor,
            child: Icon(Icons.power_settings_new, color: Colors.white),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
