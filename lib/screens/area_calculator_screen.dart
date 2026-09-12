import 'package:flutter/material.dart';

class AreaCalculatorScreen extends StatefulWidget {
  final bool isGujarati;

  const AreaCalculatorScreen({super.key, required this.isGujarati});

  @override
  State<AreaCalculatorScreen> createState() => _AreaCalculatorScreenState();
}

class _AreaCalculatorScreenState extends State<AreaCalculatorScreen> {
  final a = TextEditingController();
  final b = TextEditingController();
  final c = TextEditingController();
  String shape = 'rectangle';
  String result = '';

  String t(String gu, String en) => widget.isGujarati ? gu : en;

  void calculate() {
    final x = double.tryParse(a.text.trim());
    final y = double.tryParse(b.text.trim());

    if (x == null || y == null || x < 0 || y < 0) {
      setState(() => result = t('માન્ય મૂલ્યો દાખલ કરો.', 'Enter valid values.'));
      return;
    }

    double area;
    String label;

    if (shape == 'triangle') {
      area = 0.5 * x * y;
      label = t('ત્રિકોણનું ક્ષેત્રફળ', 'Triangle area');
    } else if (shape == 'circle') {
      area = 3.141592653589793 * x * x;
      label = t('વર્તુળનું ક્ષેત્રફળ', 'Circle area');
    } else {
      area = x * y;
      label = t('લંબચોરસનું ક્ષેત્રફળ', 'Rectangle area');
    }

    final sqft = area * 10.7639104167;
    setState(() {
      result = '$label: ${area.toStringAsFixed(3)} m²\n'
          '${t("ચોરસ ફૂટ", "Square feet")}: ${sqft.toStringAsFixed(2)}';
    });
  }

  @override
  void dispose() {
    a.dispose();
    b.dispose();
    c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCircle = shape == 'circle';
    return Scaffold(
      appBar: AppBar(title: Text(t('એરિયા કેલ્ક્યુલેટર', 'Area Calculator'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DropdownButtonFormField<String>(
            value: shape,
            decoration: InputDecoration(
              labelText: t('આકાર', 'Shape'),
              border: const OutlineInputBorder(),
            ),
            items: [
              DropdownMenuItem(value: 'rectangle', child: Text(t('લંબચોરસ', 'Rectangle'))),
              DropdownMenuItem(value: 'triangle', child: Text(t('ત્રિકોણ', 'Triangle'))),
              DropdownMenuItem(value: 'circle', child: Text(t('વર્તુળ', 'Circle'))),
            ],
            onChanged: (value) => setState(() {
              shape = value ?? 'rectangle';
              result = '';
            }),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: a,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: isCircle
                  ? t('ત્રિજ્યા (મીટર)', 'Radius (meters)')
                  : t('લંબાઈ / આધાર (મીટર)', 'Length / Base (meters)'),
              border: const OutlineInputBorder(),
            ),
          ),
          if (!isCircle) ...[
            const SizedBox(height: 12),
            TextField(
              controller: b,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: shape == 'triangle'
                    ? t('ઊંચાઈ (મીટર)', 'Height (meters)')
                    : t('પહોળાઈ (મીટર)', 'Width (meters)'),
                border: const OutlineInputBorder(),
              ),
            ),
          ],
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: calculate,
            icon: const Icon(Icons.calculate),
            label: Text(t('ગણતરી કરો', 'Calculate')),
          ),
          if (result.isNotEmpty) ...[
            const SizedBox(height: 20),
            Card(child: Padding(
              padding: const EdgeInsets.all(18),
              child: Text(result, style: const TextStyle(fontSize: 18)),
            )),
          ],
        ],
      ),
    );
  }
}
