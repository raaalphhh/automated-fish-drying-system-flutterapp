
---

## 📱 **README – Automated Fish Drying System Mobile App**  
📁 Repository: `automated-fish-drying-system-flutterapp`

```markdown
# 📱 Automated Fish Drying System Mobile App  
### (Flutter App for Real-Time Monitoring via Firebase)

This repository contains the **Flutter mobile application** for the thesis project **“Automated Microcontroller-Based Fish Drying System for Enhanced Drying Performance.”** The app connects to **Firebase Realtime Database** to monitor the ESP32 drying system’s readings — displaying **temperature, duration, and weight** in real time.

---

## 🧠 App Overview

The app provides a **user-friendly interface** for monitoring and analyzing the fish drying process.  
It also supports **remote session tracking**, **logs**, and **notification alerts** for abnormal temperature conditions.

---

## 🧩 Key Features

✅ **Real-Time Monitoring** – Displays live temperature and weight from Firebase  
📊 **Temperature Graphs** – Switch between 1s, 1m, 1h, 1d, or 1mo data intervals  
📜 **Logs Page** – View previous drying sessions and recorded results  
⚙️ **Settings Page** – Adjust app display preferences  
📱 **Responsive Gradient UI** – Carbon fiber texture with smooth layout  
🔔 **Smart Notifications** – Triggers vibration and logs when:
- Temperature exceeds 75°C  
- Firebase `/fish_drying_system/high_temp` = `true`  
- Drying session ends

---

## 🧰 Technologies Used

| Category | Tools / Framework |
|-----------|-------------------|
| Framework | Flutter |
| Language | Dart |
| Database | Firebase Realtime Database |
| Cloud Hosting | Firebase |
| IDE | Visual Studio Code / Android Studio |

---

## 📁 App Structure

```plaintext
lib/
 ├── main.dart
 ├── pages/
 │     ├── dashboard_page.dart
 │     ├── graph_page.dart
 │     ├── history_page.dart
 │     ├── notification_page.dart
 │     └── settings_page.dart
 ├── providers/
 │     ├── text_size_provider.dart
 │     └── theme_provider.dart
 ├── theme.dart

📡 Firebase Data Reference

The app reads from the following Firebase paths:
/fish_drying_system/
    ├── high_temp
    ├── session_active
    └── fish_drying_sessions/
          ├── [session_id]/
          │     ├── temperature
          │     ├── weight
          │     ├── duration
          │     ├── moisture_loss

🔗 Integration with Firmware

This app works hand-in-hand with the firmware repository:
automated-fish-drying-system-firmware

🧑‍💻 Developer

Ralph Buenaventura
🎓 Bachelor of Science in Computer Engineering
📍 Philippines
🔗 GitHub Profile: @raaalphhhb
