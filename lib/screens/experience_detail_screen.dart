import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/experience.dart';

class ExperienceDetailScreen extends StatelessWidget {
  const ExperienceDetailScreen({required this.experience, super.key});

  final Experience experience;

  String _formatDate(DateTime? date) {
    if (date == null) return '-';
    final local = date.toLocal();
    return '${local.year}-${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(experience.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              experience.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                Chip(label: Text(experience.category.toUpperCase())),
                Chip(
                  label: Text(experience.isOngoing ? 'Ongoing' : 'Completed'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text('ID: ${experience.id ?? '-'}'),
            const SizedBox(height: 4),
            Text('Started At: ${_formatDate(experience.startedAt)}'),
            const SizedBox(height: 4),
            Text(
              'Ended At: ${experience.isOngoing ? 'Present' : _formatDate(experience.endedAt)}',
            ),
            const Divider(height: 24),
            Text(
              'Description',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(experience.description),
          ],
        ),
      ),
    );
  }
}