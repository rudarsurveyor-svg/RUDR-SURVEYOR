import 'package:flutter/material.dart';

class LandMeasurementScreen extends StatefulWidget {
  final bool isGujarati;

  const LandMeasurementScreen({super.key, required this.isGujarati});

  @override
  State<LandMeasurementScreen> createState() => _LandMeasurementScreenState();
}

class _LandMeasurementScreenState extends State<LandMeasurementScreen> {
  final lengthController = TextEditingController();
  final widthController = TextEditingController();
  String result = '';

  String t(String gu, String en) => widget.isGujarati ? gu : en;

  void calculate() {
    final length = double.tryParse(lengthController.text.trim());
    final width = double.tryParse(widthController.text.trim());

    if (length == null || width == null || length < 0 || width < 0) {
      setState(() => result = t('માન્ય માપ દાખલ કરો.', 'Enter valid measurements.'));
      return;
    }

    final sqm = length * width;
    final sqft = sqm * 10.7639104167;
    final guntha = sqft / 1089.0;
    final acre = sqft / 43560.0;

    setState(() {
      result = '${t("ચોરસ મીટર", "Square meters")}: ${sqm.toStringAsFixed(3)}\n'
          '${t("ચોરસ ફૂટ", "Square feet")}: ${sqft.toStringAsFixed(2)}\n'
          '${t("ગુંઠા", "Guntha")}: ${guntha.toStringAsFixed(3)}\n'
          '${t("એકર", "Acre")}: ${acre.toStringAsFixed(4)}';
    });
  }

  @override
  void dispose() {
    lengthController.dispose();
    widthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(t('જમીન માપણી', 'Land Measurement'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(t('લંબચોરસ જમીનનું માપ', 'Rectangular Land Measurement'),
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          TextField(
            controller: lengthController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: t('લંબાઈ (મીટર)', 'Length (meters)'),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: widthController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: t('પહોળાઈ (મીટર)', 'Width (meters)'),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: calculate,
            icon: const Icon(Icons.calculate),
            label: Text(t('ગણતરી કરો', 'Calculate')),
          ),
          if (result.isNotEmpty) ...[
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Text(result, style: const TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
