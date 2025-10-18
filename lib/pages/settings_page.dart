import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/text_size_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final textSizeProvider = Provider.of<TextSizeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Enable Alerts Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Enable Alerts", 
                style: TextStyle(
                    fontSize: textSizeProvider.textSize, // ✅ Apply dynamic size
                    color: Theme.of(context).colorScheme.primary,)),
                Switch(value: false, onChanged: (value) {}) // Placeholder
              ],
            ),
            Divider(),

            // Dark Mode Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dark Mode", 
                style: TextStyle(
                    fontSize: textSizeProvider.textSize, // ✅ Apply dynamic size
                    color: Theme.of(context).colorScheme.primary,
                  )
                ),
                Switch(
                  value: themeProvider.isDarkMode,
                  onChanged: (value) => themeProvider.toggleTheme(),
                ),
              ],
            ),
            Divider(),

            // Text Size Slider
            Text("Text Size", 
            style: TextStyle(
                  fontSize: textSizeProvider.textSize, // ✅ Apply dynamic size
                  color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Slider(
              min: 12.0,
              max: 24.0,
              value: textSizeProvider.textSize,
              onChanged: (newSize) => textSizeProvider.setTextSize(newSize),
            ),
          ],
        ),
      ),
    );
  }
}
