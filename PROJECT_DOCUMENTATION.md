# PROJECT DOCUMENTATION: FlashCard Quiz Mobile Application

**Organization**: CodeAlpha App Development Internship  
**Task**: Task 1 – FlashCard Quiz Application  
**Application Name**: FlashCard Quiz  
**Repository Name**: `CodeAlpha_FlashcardQuizApp`  

---

## 1. Introduction

FlashCard Quiz is a modern, cross-platform mobile application designed to enhance knowledge retention and study productivity through interactive digital flashcards. Developed using Google's Flutter framework, the application empowers learners to view, create, edit, delete, and organize flashcards while tracking study statistics and streaks offline.

---

## 2. Problem Statement

Traditional paper flashcards are cumbersome to carry, easily damaged, and lack active progress tracking or quantitative metrics. Furthermore, existing mobile flashcard utilities often suffer from overly complex server configurations or unattractive user interfaces. There is a need for a lightweight, visually compelling, offline-first flashcard quiz app that operates seamlessly across mobile platforms.

---

## 3. Aim

To design and build a modern, responsive, high-performance, and persistent mobile application that facilitates interactive learning via customized flashcards, seamless answer revelation, and comprehensive study analytics.

---

## 4. Objectives

1. Develop an intuitive, card-based interface with smooth 3D flip animations.
2. Implement robust local data persistence using Hive for instant offline availability.
3. Provide full CRUD (Create, Read, Update, Delete) capability for user flashcards.
4. Integrate real-time search functionality to filter flashcard collections dynamically.
5. Create a dynamic study analytics module tracking total cards, review count, and daily study streaks.
6. Support a customizable visual theme system featuring Light, Dark, and System modes adhering to Material 3 guidelines.

---

## 5. Proposed System

The proposed FlashCard Quiz system adopts a clean, decoupled client architecture utilizing Provider state management. The app consists of three main presentation layers: Home Dashboard (study experience), Flashcards Management (CRUD and search), and Settings (appearance & app info). Data operations are abstracted into `StorageService` (Hive) and `PreferencesService` (`SharedPreferences`), ensuring zero dependency on network connectivity.

---

## 6. Features

- **3D Interactive Card Flip**: Rotates cards 180 degrees along the Y-axis to reveal answers.
- **Card Navigation & Progress**: Previous / Next controls synced with an animated progress bar.
- **Auto-Seeded Sample Set**: Automatically populates 10 Computer Science flashcards on first install.
- **Full CRUD Management**: Add, update, view, and delete flashcards with safety dialogs.
- **Real-Time Live Search**: Instantly filters flashcards by matching query terms against questions and answers.
- **Study Streak Engine**: Auto-calculates consecutive daily study sessions.
- **Theme Customization**: Material 3 Light and Dark themes with customizable persistence.

---

## 7. Functional Requirements

- **FR-1**: System shall display flashcard questions with hidden answers by default.
- **FR-2**: System shall flip the flashcard to display the answer upon user tap or "Show Answer" click.
- **FR-3**: System shall disable "Previous" button on card index 0 and "Next" button on the final card index.
- **FR-4**: System shall allow users to create new flashcards with validated inputs (minimum character lengths).
- **FR-5**: System shall allow users to modify existing flashcard questions and answers.
- **FR-6**: System shall present a confirmation dialog prior to deleting any flashcard.
- **FR-7**: System shall persist flashcard additions, modifications, and deletions to disk.
- **FR-8**: System shall increment cards reviewed count whenever a card's answer is revealed.

---

## 8. Non-Functional Requirements

- **NFR-1 Performance**: Smooth 60 FPS animation transitions during card flips and list navigation.
- **NFR-2 Usability**: Responsive layout adapted for small, medium, and large phone screens without overflow errors.
- **NFR-3 Reliability**: Fault-tolerant storage initialization; zero data loss upon application restart.
- **NFR-4 Maintainability**: Clean, modular codebase following Dart style guidelines and null safety rules.

---

## 9. Technology Stack

- **UI Framework**: Flutter 3.38.3 (Material 3)
- **Language**: Dart 3.10.1
- **State Management**: Provider (v6.1.5)
- **Database / Local Storage**: Hive (v2.2.3) & Hive Flutter (v1.1.0)
- **Preferences**: SharedPreferences (v2.5.5)
- **ID Generation**: UUID (v4.6.0)

---

## 10. System Workflow

```
[Splash Screen (2.2s)]
       │
       ▼
[Main Navigation Shell]
 ├── Tab 1: Home Dashboard ──► [Interactive 3D Card] ──► [Reveal Answer] ──► [Increment Review & Streak]
 ├── Tab 2: My Flashcards  ──► [Search Filter] ──► [Add / Edit Form] / [Delete Confirmation]
 └── Tab 3: Settings       ──► [Toggle Light / Dark / System Theme]
```

---

## 11. Module Description

1. **Model Layer (`lib/models/`)**: Defines `Flashcard` schema and JSON/Map conversion utilities.
2. **Service Layer (`lib/services/`)**: Implements `StorageService` for Hive database persistence and `PreferencesService` for metric counters and theme modes.
3. **Provider Layer (`lib/providers/`)**: `FlashcardProvider` maintains current card index, search query, review counts, and CRUD methods. `ThemeProvider` manages reactive theme toggling.
4. **Widget Layer (`lib/widgets/`)**: Contains reusable visual components (`FlashcardWidget`, `StatCard`, `CustomButton`, `AnimatedProgress`, `EmptyState`, `FlashcardListItem`).
5. **Screen Layer (`lib/screens/`)**: Contains app views (`SplashScreen`, `MainNavigationScreen`, `HomeScreen`, `FlashcardsScreen`, `AddEditFlashcardScreen`, `SettingsScreen`).

---

## 12. Database / Local Storage

Data is stored locally on device using Hive key-value box (`flashcards_box`).
Each entry maps a unique UUID string key to a serialized `Flashcard` payload:

```json
{
  "id": "c6a2b8e0-1234-5678-9abc-def012345678",
  "question": "What is Flutter?",
  "answer": "Flutter is an open-source UI software development kit created by Google...",
  "createdAt": "2026-09-15T16:00:00.000Z"
}
```

---

## 13. UI Design

- **Primary Color**: Deep Indigo (`#3F51B5` / `#2A3890`)
- **Secondary Color**: Violet (`#6C5CE7`)
- **Accent Color**: Cyan (`#00CEC9`)
- **Typography**: Clean sans-serif hierarchy with bold card titles and medium body text.
- **Card Styling**: 20px-24px rounded corners, soft ambient shadows, and dual-state front/back color gradients.

---

## 14. Testing

Testing was executed across two tiers:
1. **Static Analysis**: Executed `flutter analyze` ensuring 0 warnings and 0 errors across the codebase.
2. **Automated Unit Testing**: Executed `flutter test` validating serialization, `copyWith`, and input validator logic.

**Test Results Summary**:
- `Flashcard toMap and fromMap serialization`: **PASSED**
- `Flashcard copyWith updates fields`: **PASSED**
- `validateQuestion detects empty/short input`: **PASSED**
- `validateAnswer detects empty/short input`: **PASSED**

---

## 15. Future Scope

- **Spaced Repetition Integration**: Implementing SuperMemo-2 algorithm to schedule card reviews based on user mastery rating.
- **Cloud Synchronization**: Optional Firebase / Supabase backend sync across multiple devices.
- **Category Tags**: Tagging flashcards by subject (e.g. Flutter, Web, Database, General Knowledge).

---

## 16. Conclusion

The FlashCard Quiz application delivers a robust, elegant, startup-ready mobile experience fulfilling all objectives set forth for the CodeAlpha App Development Internship Task 1. The combination of clean architecture, 3D card physics, offline persistence, and Material 3 design creates a standout portfolio project.
