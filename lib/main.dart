import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'package:project_app/providers/theme_provider.dart';
import 'package:project_app/providers/text_size_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/dashboard_page.dart';
import 'pages/notification_page.dart';
import 'pages/settings_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => TextSizeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); 
    final textSize = Provider.of<TextSizeProvider>(context).textSize;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fish Drying System',
      theme: themeProvider.themeData.copyWith(
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: textSize + 4, color: Colors.black),
          bodyMedium: TextStyle(fontSize: textSize + 2, color: Colors.black),
          bodySmall: TextStyle(fontSize: textSize, color: Colors.black),
        ),
      ), 
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  Future<void> _handleRefresh() async {
    setState(() {});
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return DashboardPage();
      case 1:
        return RefreshIndicator(
          onRefresh: _handleRefresh,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: NotificationPage(),
            ),
          ),
        );
      case 2:
        return SettingsPage();
      default:
        return DashboardPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Alerts'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
