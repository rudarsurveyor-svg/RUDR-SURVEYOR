import 'package:flutter/material.dart';

class KnowledgeScreen extends StatelessWidget {
  final bool isGujarati;

  const KnowledgeScreen({super.key, required this.isGujarati});

  String t(String gu, String en) => isGujarati ? gu : en;

  @override
  Widget build(BuildContext context) {
    final topics = [
      (
        t('DGPS સર્વે', 'DGPS Survey'),
        t('ઉચ્ચ ચોકસાઈવાળા GNSS/GPS માપ માટે control points અને યોગ્ય coordinate system મહત્વપૂર્ણ છે.',
          'Control points and the correct coordinate system are important for accurate GNSS/GPS surveying.')
      ),
      (
        t('ટોટલ સ્ટેશન', 'Total Station'),
        t('Instrument setup, centering, leveling, backsight અને prism constant યોગ્ય રીતે ચેક કરો.',
          'Check instrument setup, centering, leveling, backsight and prism constant carefully.')
      ),
      (
        t('ડ્રોન સર્વે', 'Drone Survey'),
        t('ફ્લાઇટ પહેલાં site permissions, GCPs, overlap, altitude અને safety requirements ચેક કરો.',
          'Before a flight, check site permissions, GCPs, overlap, altitude and safety requirements.')
      ),
      (
        t('ફિલ્ડ નોટ્સ', 'Field Notes'),
        t('દરેક point ID, description, date, instrument અને coordinate reference નોંધો.',
          'Record point ID, description, date, instrument and coordinate reference for every survey point.')
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(t('સર્વેયર જ્ઞાન', 'Surveyor Knowledge'))),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: topics.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final topic = topics[index];
          return Card(
            child: ExpansionTile(
              title: Text(topic.$1, style: const TextStyle(fontWeight: FontWeight.bold)),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: [Text(topic.$2)],
            ),
          );
        },
      ),
    );
  }
}
