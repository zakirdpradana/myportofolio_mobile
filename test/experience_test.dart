import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/models/experience.dart';

void main() {
  test('Experience.fromJson parses required fields correctly', () {
    final experience = Experience.fromJson(const <String, dynamic>{
      'title': 'Software Engineer Intern',
      'description': 'Developed mobile features',
      'category': 'internship',
    });

    expect(experience.title, 'Software Engineer Intern');
    expect(experience.description, 'Developed mobile features');
    expect(experience.category, 'internship');
    expect(experience.isOngoing, isTrue);
  });
}
