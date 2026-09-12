import 'package:flutter/material.dart';

class SurveyReportScreen extends StatefulWidget {
  final bool isGujarati;

  const SurveyReportScreen({super.key, required this.isGujarati});

  @override
  State<SurveyReportScreen> createState() => _SurveyReportScreenState();
}

class _SurveyReportScreenState extends State<SurveyReportScreen> {
  final client = TextEditingController();
  final village = TextEditingController();
  final surveyNo = TextEditingController();
  final area = TextEditingController();
  final notes = TextEditingController();

  String t(String gu, String en) => widget.isGujarati ? gu : en;

  @override
  void dispose() {
    client.dispose();
    village.dispose();
    surveyNo.dispose();
    area.dispose();
    notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(t('સર્વે રિપોર્ટ', 'Survey Report'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _field(client, t('ગ્રાહકનું નામ', 'Client Name')),
          _field(village, t('ગામ / સ્થળ', 'Village / Location')),
          _field(surveyNo, t('સર્વે નંબર', 'Survey Number')),
          _field(area, t('વિસ્તાર', 'Area')),
          _field(notes, t('નોંધ', 'Notes'), maxLines: 5),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(t(
                  'રિપોર્ટની વિગતો તૈયાર થઈ ગઈ.',
                  'Report details are ready.',
                ))),
              );
            },
            icon: const Icon(Icons.description),
            label: Text(t('રિપોર્ટ તૈયાર કરો', 'Prepare Report')),
          ),
          const SizedBox(height: 12),
          Text(
            t(
              'નોંધ: આ screen હાલમાં report data તૈયાર કરે છે. PDF/printing માટે આગળ integration કરી શકાય છે.',
              'Note: This screen prepares report data. PDF/printing integration can be added next.',
            ),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _field(TextEditingController controller, String label, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
