<div align="center">

  <img src="assets/images/app_logo.png" alt="FlashCard Quiz Logo" width="120" height="120" style="border-radius: 24px;" />

  # 🎴 FlashCard Quiz App

  **A modern, interactive, and beautifully designed cross-platform Flashcard Quiz & Learning Telemetry App built with Flutter.**

  [![Flutter Version](https://img.shields.io/badge/Flutter-v3.38.3-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
  [![Dart](https://img.shields.io/badge/Dart-v3.10.1-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
  [![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20Web%20%7C%20Windows-brightgreen?style=for-the-badge)](https://flutter.dev)
  [![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)](LICENSE)

  ---

  ### 📥 Direct App Download (Android APK)

  [![Download APK](https://img.shields.io/badge/🚀_Download_Release_APK-Direct_Google_Drive-22c55e?style=for-the-badge&logo=android&logoColor=white)](https://drive.google.com/uc?export=download&id=1sSRfFIlbXhKBODuzEk85bt7JF9dfq7Jw)

  > 📲 Click the badge above to download the official **`app-release.apk`** directly to your Android device!

</div>

---

## 📖 About The Project

**FlashCard Quiz** is designed to help learners study efficiently, retain key concepts, and track learning momentum. Built as part of the **CodeAlpha App Development Internship (Task 1)**, the app features an intuitive card-flipping interface, real-time statistics telemetry, dark mode support, and offline persistence.

---

## ✨ Key Features

- 🧠 **Interactive 3D Card Flipper**: Seamlessly flip between questions and answers with smooth physics-based animations.
- 📊 **Live Telemetry & Dashboard**: Real-time tracking of Total Cards, Study Streak (days), Reviewed Count, and Completion Rate.
- 🔍 **Instant Search & Filtering**: Query both questions and answers instantly with zero latency.
- 🛠️ **Full CRUD Management**: Easily create, edit, update, and delete flashcards.
- 🎨 **Adaptive Dark & Light Themes**: Built with Material 3 design system with dynamic theme switching.
- 💾 **Offline Storage & Persistence**: Local data persistence powered by `Hive` and `SharedPreferences`.

---

## 📸 Application Screenshots

| 🏠 Home & Telemetry Dashboard | 🎴 Flashcard Quiz View | 🔍 Flashcard Manager & Search |
| :---: | :---: | :---: |
| <img src="https://raw.githubusercontent.com/VedantWasalwar/FlashCard-Quiz/main/assets/images/app_logo.png" width="220"/> | <img src="https://raw.githubusercontent.com/VedantWasalwar/FlashCard-Quiz/main/assets/images/app_logo.png" width="220"/> | <img src="https://raw.githubusercontent.com/VedantWasalwar/FlashCard-Quiz/main/assets/images/app_logo.png" width="220"/> |

---

## 🛠️ Tech Stack & Architecture

- **Framework**: [Flutter SDK](https://flutter.dev) (Channel stable)
- **Language**: [Dart](https://dart.dev)
- **State Management**: [`Provider`](https://pub.dev/packages/provider)
- **Local Database**: [`Hive`](https://pub.dev/packages/hive) & [`hive_flutter`](https://pub.dev/packages/hive_flutter)
- **Preferences**: [`shared_preferences`](https://pub.dev/packages/shared_preferences)
- **UI Components**: Material Design 3, Custom Animated Builders

---

## 🚀 Getting Started

### Prerequisites

Make sure you have Flutter installed on your machine:
```bash
flutter --version
```

### Installation & Local Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/VedantWasalwar/FlashCard-Quiz.git
   cd FlashCard-Quiz
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the App:**
   - **Chrome (Web):**
     ```bash
     flutter run -d chrome
     ```
   - **Android Device / Emulator:**
     ```bash
     flutter run
     ```
   - **Windows Desktop:**
     ```bash
     flutter run -d windows
     ```

---

## 📦 Building Release APK for Android

To build a standalone production APK:

```bash
flutter build apk --release
```

The compiled APK will be available at:  
`build/app/outputs/flutter-apk/app-release.apk`

### 📲 How to Create a Direct Google Drive Download Link:
1. Upload `app-release.apk` to **Google Drive**.
2. Set permission: `Anyone with the link`.
3. Copy the link: `https://drive.google.com/file/d/FILE_ID/view?usp=sharing`
4. Convert to Direct Download link:  
   `https://drive.google.com/uc?export=download&id=FILE_ID`

---

## 📂 Project Structure

```text
FlashCard-Quiz/
├── android/                 # Android native code & config
├── assets/
│   └── images/
│       └── app_logo.png     # Application Logo
├── lib/
│   ├── models/              # Data Models (Flashcard)
│   ├── providers/           # State Management (FlashcardProvider, ThemeProvider)
│   ├── screens/             # UI Screens (HomeScreen, FlashcardsScreen, SettingsScreen, SplashScreen)
│   ├── services/            # Storage & Preference Services (Hive & SharedPreferences)
│   ├── theme/               # Color Palettes & App Themes
│   ├── utils/               # Form Validators & Helpers
│   ├── widgets/             # Reusable UI Widgets (StatCard, FlashcardWidget, AnimatedProgress)
│   └── main.dart            # Entry Point
├── pubspec.yaml             # Project Dependencies & Assets
└── README.md                # Documentation
```

---

## 📄 License

Distributed under the **MIT License**. See `LICENSE` for more information.

---

<div align="center">
  <sub>Develop ❤️ by <b>Vedant Wasalwar</b></sub>
</div>
