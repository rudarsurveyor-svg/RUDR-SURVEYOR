import 'package:flutter/material.dart';

class UnitConverterScreen extends StatefulWidget {
  final bool isGujarati;

  const UnitConverterScreen({super.key, required this.isGujarati});

  @override
  State<UnitConverterScreen> createState() => _UnitConverterScreenState();
}

class _UnitConverterScreenState extends State<UnitConverterScreen> {
  final input = TextEditingController();
  String from = 'm²';
  String to = 'ft²';
  String result = '';

  final units = const ['m²', 'ft²', 'acre', 'guntha', 'hectare'];

  String t(String gu, String en) => widget.isGujarati ? gu : en;

  double toSqm(double value, String unit) {
    switch (unit) {
      case 'ft²': return value / 10.7639104167;
      case 'acre': return value * 4046.8564224;
      case 'guntha': return value * 101.17141056;
      case 'hectare': return value * 10000;
      default: return value;
    }
  }

  double fromSqm(double value, String unit) {
    switch (unit) {
      case 'ft²': return value * 10.7639104167;
      case 'acre': return value / 4046.8564224;
      case 'guntha': return value / 101.17141056;
      case 'hectare': return value / 10000;
      default: return value;
    }
  }

  void convert() {
    final value = double.tryParse(input.text.trim());
    if (value == null) {
      setState(() => result = t('માન્ય સંખ્યા દાખલ કરો.', 'Enter a valid number.'));
      return;
    }
    final converted = fromSqm(toSqm(value, from), to);
    setState(() => result = '${converted.toStringAsFixed(6)} $to');
  }

  @override
  void dispose() {
    input.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(t('યુનિટ કન્વર્ટર', 'Unit Converter'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: input,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: t('મૂલ્ય', 'Value'),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _dropdown('From', from, (v) => setState(() => from = v!))),
              const SizedBox(width: 12),
              Expanded(child: _dropdown('To', to, (v) => setState(() => to = v!))),
            ],
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: convert,
            icon: const Icon(Icons.swap_horiz),
            label: Text(t('કન્વર્ટ કરો', 'Convert')),
          ),
          if (result.isNotEmpty) ...[
            const SizedBox(height: 20),
            Card(child: Padding(
              padding: const EdgeInsets.all(18),
              child: Text(result, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            )),
          ],
        ],
      ),
    );
  }

  Widget _dropdown(String label, String value, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      items: units.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
      onChanged: onChanged,
    );
  }
}
