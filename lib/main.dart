import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers/flashcard_provider.dart';
import 'providers/theme_provider.dart';
import 'services/preferences_service.dart';
import 'services/storage_service.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FlashCardQuizApp());
}

class FlashCardQuizApp extends StatefulWidget {
  const FlashCardQuizApp({super.key});

  @override
  State<FlashCardQuizApp> createState() => _FlashCardQuizAppState();
}

class _FlashCardQuizAppState extends State<FlashCardQuizApp> {
  PreferencesService? _prefsService;
  StorageService? _storageService;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _initServices();
  }

  Future<void> _initServices() async {
    PreferencesService? prefs;
    StorageService? storage;

    try {
      SharedPreferences? sharedPrefs;
      try {
        sharedPrefs = await SharedPreferences.getInstance();
      } catch (e) {
        debugPrint('SharedPreferences init note: $e');
      }

      prefs = PreferencesService(sharedPrefs);
      storage = StorageService();

      try {
        await storage.init(prefs);
      } catch (e) {
        debugPrint('StorageService init note: $e');
      }
    } catch (e) {
      debugPrint('General init error: $e');
    } finally {
      prefs ??= PreferencesService(null);
      storage ??= StorageService();

      if (mounted) {
        setState(() {
          _prefsService = prefs;
          _storageService = storage;
          _initialized = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return MaterialApp(
        title: 'FlashCard Quiz',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(_prefsService!),
        ),
        ChangeNotifierProvider(
          create: (_) => FlashcardProvider(_storageService!, _prefsService!),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'FlashCard Quiz',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
