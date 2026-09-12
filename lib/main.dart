import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/land_measurement_screen.dart';
import 'screens/area_calculator_screen.dart';
import 'screens/unit_converter_screen.dart';
import 'screens/knowledge_screen.dart';
import 'screens/survey_report_screen.dart';

void main() {
  runApp(const RudrSurveyorApp());
}

class RudrSurveyorApp extends StatefulWidget {
  const RudrSurveyorApp({super.key});

  @override
  State<RudrSurveyorApp> createState() => _RudrSurveyorAppState();
}

class _RudrSurveyorAppState extends State<RudrSurveyorApp> {
  Locale _locale = const Locale('gu');

  void toggleLanguage() {
    setState(() {
      _locale = _locale.languageCode == 'gu'
          ? const Locale('en')
          : const Locale('gu');
    });
  }

  @override
  Widget build(BuildContext context) {
    final gu = _locale.languageCode == 'gu';

    return MaterialApp(
      title: 'RUDR SURVEYOR',
      debugShowCheckedModeBanner: false,
      locale: _locale,

      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF1565C0),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),

      home: HomeScreen(
        isGujarati: gu,
        onLanguageToggle: toggleLanguage,
      ),

      routes: {
        '/measurement': (_) =>
            LandMeasurementScreen(isGujarati: gu),

        '/area': (_) =>
            AreaCalculatorScreen(isGujarati: gu),

        '/units': (_) =>
            UnitConverterScreen(isGujarati: gu),

        '/knowledge': (_) =>
            KnowledgeScreen(isGujarati: gu),

        '/report': (_) =>
            SurveyReportScreen(isGujarati: gu),
      },
    );
  }
}
