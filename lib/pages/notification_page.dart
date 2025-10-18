import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:vibration/vibration.dart';
import 'dart:async';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<String> notifications = [];
  final List<String> serialLogs = [];

  late DatabaseReference highTempRef;
  late DatabaseReference tempRef;
  late DatabaseReference sessionEndTimeRef;

  StreamSubscription<DatabaseEvent>? highTempSub;
  StreamSubscription<DatabaseEvent>? tempSub;

  @override
  void initState() {
    super.initState();
    initFirebaseListener();
    simulateSerialLogs(); // for visual serial logs
  }

  @override
  void dispose() {
    highTempSub?.cancel();
    tempSub?.cancel();
    super.dispose();
  }

  void initFirebaseListener() async {
    await Firebase.initializeApp();
    highTempRef = FirebaseDatabase.instance.ref('/fish_drying_system/high_temp');
    tempRef = FirebaseDatabase.instance.ref('/fish_drying_system/temp');
    sessionEndTimeRef = FirebaseDatabase.instance.ref('/fish_drying_system/end_time');

    highTempSub = highTempRef.onValue.listen((event) {
      final isHigh = event.snapshot.value as bool? ?? false;
      if (isHigh) {
        _triggerAlert("⚠️ High Temperature Detected (Firebase: high_temp = true)");
      }
    });

    tempSub = tempRef.onValue.listen((event) {
      final temp = double.tryParse(event.snapshot.value.toString()) ?? 0;
      if (temp > 75) {
        _triggerAlert("🔥 Critical Temperature! Current Temp: ${temp.toStringAsFixed(2)}°C");
      }
    });

    Timer.periodic(Duration(seconds: 10), (_) async {
      final snapshot = await sessionEndTimeRef.get();
      if (snapshot.exists) {
        final endTimeMillis = int.tryParse(snapshot.value.toString()) ?? 0;
        final nowMillis = DateTime.now().millisecondsSinceEpoch;
        final remainingMillis = endTimeMillis - nowMillis;
        if (remainingMillis <= 60000 && remainingMillis > 59000) {
          _triggerAlert("⏳ Drying session ending in 1 minute!");
        }
      }
    });
  }

  void _triggerAlert(String message) async {
    setState(() {
      notifications.insert(0, message);
      serialLogs.insert(0, "[LOG] $message");
    });

    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 400);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void simulateSerialLogs() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      final log = "Serial Log: 🕒 ${DateTime.now().toIso8601String()}";
      setState(() {
        serialLogs.insert(0, log);
        if (serialLogs.length > 50) serialLogs.removeLast();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final halfScreenHeight = MediaQuery.of(context).size.height * 0.5;

    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: Column(
        children: [
          Container(
            height: halfScreenHeight,
            color: Colors.grey.shade200,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("⚠️ System Notifications", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                const Divider(),
                Expanded(
                  child: notifications.isEmpty
                      ? const Center(child: Text("No notifications yet."))
                      : ListView.builder(
                          itemCount: notifications.length,
                          itemBuilder: (context, index) => ListTile(
                            leading: const Icon(Icons.warning, color: Colors.orange),
                            title: Text(notifications[index]),
                          ),
                        ),
                ),
              ],
            ),
          ),
          Container(
            height: halfScreenHeight,
            color: Colors.black,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("📟 Serial Monitor", style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
                const Divider(color: Colors.white54),
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: serialLogs.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: Text(
                        serialLogs[index],
                        style: const TextStyle(color: Colors.greenAccent, fontFamily: 'Courier'),
                      ),
                    ),
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
