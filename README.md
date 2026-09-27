# FlashCard Quiz - Mobile Learning Application 🎓📱

![Flutter](https://img.shields.io/badge/Flutter-3.38.3-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.10.1-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Task](https://img.shields.io/badge/CodeAlpha-Task%201-blueviolet?style=for-the-badge)

**FlashCard Quiz** is a complete, modern, startup-quality flashcard learning application built with **Flutter** and **Material 3** for the **CodeAlpha App Development Internship (Task 1)**.

---

## 🎯 Project Aim & Objective

The primary objective of this project is to develop an interactive, visually engaging educational tool that enables students to study computer science concepts, test their knowledge, track their learning progress, and persist flashcards offline.

---

## ✨ Key Features

### 🃏 Interactive Flashcard Experience
- **3D Card Flip Animation**: Smooth 60 FPS rotation along the Y-axis revealing the answer.
- **Card Navigation**: Effortless Next and Previous controls with active progress indicator.
- **Answer Revelation Toggle**: Seamless "Show Answer" and "Hide Answer" button interaction.
- **Smart Progress Tracking**: Real-time progress bar showing active flashcard position.

### 📚 Complete Flashcard Management (CRUD)
- **Create**: Add new flashcards with customizable question and answer fields.
- **Read**: Browse all flashcards with instantaneous live search filtering.
- **Update**: Edit existing flashcard content with pre-filled inputs and real-time validation.
- **Delete**: Remove unwanted flashcards with animated list updates and confirmation modals.

### 📊 Learning Statistics & Micro-Interactions
- **Total Cards Counter**: Live tracking of the current total card collection.
- **Study Streak Tracking**: Calculates continuous daily study sessions automatically.
- **Cards Reviewed Counter**: Persists total cards reviewed across all sessions.
- **Micro-Interactions**: Button scale on press, smooth transitions, and feedback snackbars.

### 🌙 Premium Light & Dark Themes
- Built-in **Material 3 Theme System** with Deep Indigo, Violet, and Cyan color palette.
- **Theme Preferences**: Switch seamlessly between Light, Dark, and System Default modes with instant state update and local persistence.

### 💾 Local Data Persistence & First-Run Seeding
- Powered by **Hive** for fast offline object storage.
- Auto-seeds **10 high-quality Computer Science flashcards** on initial app launch.

---

## 🛠️ Technology Stack

| Component | Technology / Package |
| :--- | :--- |
| **Framework** | [Flutter](https://flutter.dev) (v3.38.3) |
| **Language** | [Dart](https://dart.dev) (v3.10.1) |
| **State Management** | [Provider](https://pub.dev/packages/provider) |
| **Local Storage** | [Hive](https://pub.dev/packages/hive) & [Hive Flutter](https://pub.dev/packages/hive_flutter) |
| **Preferences** | [Shared Preferences](https://pub.dev/packages/shared_preferences) |
| **Identifier Generator** | [UUID](https://pub.dev/packages/uuid) |
| **Design Language** | Material 3 Design System |

---

## 📁 Project Structure

```
CodeAlpha_FlashcardQuizApp/
├── android/
├── ios/
├── web/
├── windows/
├── lib/
│   ├── main.dart                       # App entry point & initialization
│   ├── models/
│   │   └── flashcard.dart              # Flashcard data model & serialization
│   ├── services/
│   │   ├── storage_service.dart        # Hive database CRUD operations & seeding
│   │   └── preferences_service.dart    # Shared preferences & streak logic
│   ├── providers/
│   │   ├── flashcard_provider.dart     # Flashcard collection state & study stats
│   │   └── theme_provider.dart         # Reactive light/dark theme manager
│   ├── theme/
│   │   ├── app_colors.dart             # Palette definitions & gradients
│   │   └── app_theme.dart              # Material 3 light/dark theme configuration
│   ├── utils/
│   │   └── validators.dart             # Input validation helpers
│   ├── widgets/
│   │   ├── flashcard_widget.dart       # 3D Flip Flashcard widget
│   │   ├── stat_card.dart              # Dashboard metric card
│   │   ├── flashcard_list_item.dart    # Manageable list item widget
│   │   ├── custom_button.dart          # Scale-animated interactive button
│   │   ├── empty_state.dart            # Placeholder empty state view
│   │   └── animated_progress.dart      # Progress bar indicator
│   └── screens/
│       ├── splash_screen.dart          # Animated splash screen
│       ├── main_navigation_screen.dart # Bottom NavigationBar shell
│       ├── home_screen.dart            # Main dashboard & interactive study view
│       ├── flashcards_screen.dart      # Flashcards collection management & search
│       ├── add_edit_flashcard_screen.dart # Form for creating/editing cards
│       └── settings_screen.dart        # Theme & app information settings
├── test/
│   └── flashcard_test.dart             # Unit test suite
├── README.md                           # GitHub README documentation
└── PROJECT_DOCUMENTATION.md            # Internship technical documentation
```

---

## ⚡ Installation & Execution Guide

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed (v3.0.0 or higher)
- Android Studio / VS Code with Flutter extension
- Android Emulator / Physical Device / Windows desktop runner

### Step-by-Step Setup

1. **Clone the Repository**
   ```bash
   git clone https://github.com/your-username/CodeAlpha_FlashcardQuizApp.git
   cd CodeAlpha_FlashcardQuizApp
   ```

2. **Fetch Dependencies**
   ```bash
   flutter pub get
   ```

3. **Run Code Analysis & Test Suite**
   ```bash
   flutter analyze
   flutter test
   ```

4. **Launch the Application**
   ```bash
   flutter run
   ```

---

## 📸 Application Screenshots

> *Add application screenshots and demo GIFs here for LinkedIn / GitHub portfolio.*

---

## 🔮 Future Enhancements

- **Deck Categorization**: Group flashcards into specific topics (e.g. Flutter, Algorithms, Web Development).
- **Import / Export**: Backup and restore flashcards via JSON or CSV files.
- **Audio Pronunciation**: Text-to-speech support for answer reading.
- **Spaced Repetition Algorithm (SM-2)**: Optimize revision schedules based on memory strength.

---

## 👨‍💻 Author & Internship Details

- **Task Name**: Task 1 – FlashCard Quiz Application
- **Internship Program**: CodeAlpha App Development Internship
- **Developer**: Vedant
- **Repository**: `CodeAlpha_FlashcardQuizApp`
