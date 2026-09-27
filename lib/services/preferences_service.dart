import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _themeKey = 'theme_mode';
  static const String _isSeededKey = 'is_seeded';
  static const String _cardsReviewedKey = 'cards_reviewed_count';
  static const String _studyStreakKey = 'study_streak';
  static const String _lastStudyDateKey = 'last_study_date';

  final SharedPreferences? _prefs;

  PreferencesService(this._prefs);

  ThemeMode getThemeMode() {
    final prefs = _prefs;
    if (prefs == null) return ThemeMode.system;
    try {
      final themeString = prefs.getString(_themeKey);
      if (themeString == 'light') return ThemeMode.light;
      if (themeString == 'dark') return ThemeMode.dark;
    } catch (_) {}
    return ThemeMode.system;
  }

  Future<void> saveThemeMode(ThemeMode mode) async {
    final prefs = _prefs;
    if (prefs == null) return;
    try {
      switch (mode) {
        case ThemeMode.light:
          await prefs.setString(_themeKey, 'light');
          break;
        case ThemeMode.dark:
          await prefs.setString(_themeKey, 'dark');
          break;
        case ThemeMode.system:
          await prefs.setString(_themeKey, 'system');
          break;
      }
    } catch (_) {}
  }

  bool isSeeded() {
    final prefs = _prefs;
    if (prefs == null) return false;
    try {
      return prefs.getBool(_isSeededKey) ?? false;
    } catch (_) {
      return false;
    }
  }

  Future<void> setSeeded(bool value) async {
    final prefs = _prefs;
    if (prefs == null) return;
    try {
      await prefs.setBool(_isSeededKey, value);
    } catch (_) {}
  }

  int getCardsReviewedCount() {
    final prefs = _prefs;
    if (prefs == null) return 0;
    try {
      return prefs.getInt(_cardsReviewedKey) ?? 0;
    } catch (_) {
      return 0;
    }
  }

  Future<void> incrementCardsReviewed() async {
    final prefs = _prefs;
    if (prefs == null) return;
    try {
      final current = getCardsReviewedCount();
      await prefs.setInt(_cardsReviewedKey, current + 1);
    } catch (_) {}
  }

  int getStudyStreak() {
    final prefs = _prefs;
    if (prefs == null) return 0;
    try {
      final lastDateStr = prefs.getString(_lastStudyDateKey);
      final streak = prefs.getInt(_studyStreakKey) ?? 0;

      if (lastDateStr == null) return 0;

      final lastDate = DateTime.parse(lastDateStr);
      final now = DateTime.now();

      final today = DateTime(now.year, now.month, now.day);
      final lastDay = DateTime(lastDate.year, lastDate.month, lastDate.day);
      final difference = today.difference(lastDay).inDays;

      if (difference > 1) {
        return 0;
      }
      return streak;
    } catch (_) {
      return 0;
    }
  }

  Future<void> registerStudySession() async {
    final prefs = _prefs;
    if (prefs == null) return;
    try {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final lastDateStr = prefs.getString(_lastStudyDateKey);
      int streak = prefs.getInt(_studyStreakKey) ?? 0;

      if (lastDateStr == null) {
        streak = 1;
      } else {
        final lastDate = DateTime.parse(lastDateStr);
        final lastDay = DateTime(lastDate.year, lastDate.month, lastDate.day);
        final diff = today.difference(lastDay).inDays;

        if (diff == 1) {
          streak += 1;
        } else if (diff > 1) {
          streak = 1;
        } else if (diff == 0 && streak == 0) {
          streak = 1;
        }
      }

      await prefs.setInt(_studyStreakKey, streak);
      await prefs.setString(_lastStudyDateKey, now.toIso8601String());
    } catch (_) {}
  }
}
