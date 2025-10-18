# 📱 Automated Fish Drying System Mobile App  
### *(Flutter App for Real-Time Monitoring via Firebase)*  

This repository contains the **Flutter mobile application** for the thesis project:  
**“Automated Microcontroller-Based Fish Drying System for Enhanced Drying Performance.”**  

The app connects to the **Firebase Realtime Database** to monitor the ESP32 drying system’s readings — displaying **temperature**, **duration**, and **weight** in real time.

---

## 🧠 Overview  

The mobile application provides a **user-friendly interface** for monitoring and analyzing the fish drying process.  
It also supports **remote session tracking**, **activity logs**, and **notification alerts** for abnormal temperature conditions or system states.  

---

## 🧩 Key Features  

- ✅ **Real-Time Monitoring** – Live display of temperature and weight directly from Firebase  
- 📊 **Dynamic Graphs** – Switch between 1-second, 1-minute, 1-hour, 1-day, or 1-month data intervals  
- 📜 **Session Logs** – View and track previous drying sessions with detailed records  
- ⚙️ **Settings Page** – Adjust app preferences such as theme and text size  
- 🎨 **Modern Gradient UI** – Carbon fiber aesthetic with a responsive layout  
- 🔔 **Smart Notifications** – Vibrates and logs events when:  
  - Temperature exceeds **75°C**  
  - Firebase value `/fish_drying_system/high_temp` = `true`  
  - A drying session is about to end  

---

## 🧰 Technologies Used  

| Category | Tools / Framework |
|-----------|-------------------|
| **Framework** | Flutter |
| **Language** | Dart |
| **Database** | Firebase Realtime Database |
| **Cloud Hosting** | Firebase |
| **IDE** | Visual Studio Code / Android Studio |

---

## 📁 Folder Structure  

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
 └── theme.dart
```

## 📡 Firebase Data Reference
```
/fish_drying_system/
    ├── high_temp
    ├── session_active
    └── fish_drying_sessions/
          ├── [session_id]/
          │     ├── temperature
          │     ├── weight
          │     ├── duration
          │     ├── moisture_loss
  ```        

## 🔗 Integration with Firmware
```

This app works hand-in-hand with the ESP32 firmware to achieve full IoT functionality.
Firmware repository:
➡️ automated-fish-drying-system-firmware
```

### 👨‍💻 Developer
```
Ralph Buenaventura
🎓 Bachelor of Science in Computer Engineering
📍 Philippines
🔗 GitHub Profile: @raaalphhhb
```
