import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final bool isGujarati;
  final VoidCallback onLanguageToggle;

  const HomeScreen({
    super.key,
    required this.isGujarati,
    required this.onLanguageToggle,
  });

  String t(String gu, String en) => isGujarati ? gu : en;

  @override
  Widget build(BuildContext context) {
    final items = [
      ('📐', t('જમીન માપણી', 'Land Measurement'), '/measurement'),
      ('🧮', t('એરિયા કેલ્ક્યુલેટર', 'Area Calculator'), '/area'),
      ('🔄', t('યુનિટ કન્વર્ટર', 'Unit Converter'), '/units'),
      ('📚', t('સર્વેયર જ્ઞાન', 'Surveyor Knowledge'), '/knowledge'),
      ('📋', t('સર્વે રિપોર્ટ', 'Survey Report'), '/report'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'RUDR SURVEYOR',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: onLanguageToggle,
            child: Text(
              isGujarati ? 'EN' : 'ગુ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                'assets/images/rudr_logo.jpg',
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              t(
                'Surveying માટે તમારા દૈનિક tools',
                'Daily tools for professional surveying',
              ),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            ...items.map(
              (item) => Card(
                child: ListTile(
                  leading: Text(
                    item.$1,
                    style: const TextStyle(fontSize: 28),
                  ),
                  title: Text(
                    item.$2,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  ),
                  onTap: () => Navigator.pushNamed(context, item.$3),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.support_agent),
                title: Text(t('Customer Care', 'Customer Care')),
                subtitle: const Text('8487847474'),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
