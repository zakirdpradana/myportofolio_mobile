import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/experience.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _description = '';
  String _category = 'full-time';
  String _thumbnail = '';
  bool _isOngoing = true;
  DateTime? _endedAt;
  bool _isSubmitting = false;

  static const Map<String, String> _categories = {
    'internship': 'Internship',
    'research': 'Research',
    'volunteer': 'Volunteer',
    'part-time': 'Part-Time',
    'full-time': 'Full-Time',
    'freelance': 'Freelance',
  };

  Future<void> _pickEndedDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _endedAt ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _endedAt = picked;
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_isOngoing && _endedAt == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Pilih tanggal selesai atau aktifkan status sedang berlangsung!',
          ),
        ),
      );
      return;
    }

    if (!await ensureLoggedIn(context)) return;
    if (!mounted) return;

    setState(() {
      _isSubmitting = true;
    });

    final token = context.read<AuthState>().token!;
    final newExperience = Experience(
      title: _title,
      description: _description,
      category: _category,
      thumbnail: _thumbnail,
      endedAt: _isOngoing ? null : _endedAt,
      isOngoing: _isOngoing,
    );

    try {
      await context.read<ApiClient>().createExperience(
        newExperience,
        token: token,
      );
      if (!mounted) return;

      await showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Pengalaman berhasil ditambahkan!'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title: $_title'),
                  Text('Kategori: ${_categories[_category]}'),
                  Text('Deskripsi: $_description'),
                  if (_thumbnail.isNotEmpty) Text('Thumbnail: $_thumbnail'),
                  Text(
                    'Status: ${_isOngoing ? 'Ongoing' : 'Selesai (${_endedAt!.year}-${_endedAt!.month.toString().padLeft(2, '0')}-${_endedAt!.day.toString().padLeft(2, '0')})'}',
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
      if (mounted) Navigator.pop(context);
    } on ApiException catch (e) {
      if (!mounted) return;
      if (e.statusCode == 401 || e.statusCode == 403) {
        await context.read<AuthState>().logout();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sesi berakhir. Silakan login kembali.'),
          ),
        );
        await ensureLoggedIn(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menambahkan pengalaman: HTTP ${e.statusCode}'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Experience Form')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Title ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Nama Pengalaman',
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _title = value ?? '';
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Title tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),

              // === Description ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Deskripsi Pengalaman',
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value ?? '';
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Deskripsi pengalaman tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),

              // === Category ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  initialValue: _category,
                  items: _categories.entries
                      .map(
                        (entry) => DropdownMenuItem<String>(
                          value: entry.key,
                          child: Text(entry.value),
                        ),
                      )
                      .toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _category = newValue;
                      });
                    }
                  },
                ),
              ),

              // === Thumbnail URL (Opsional) ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'https://example.com/thumbnail.png (opsional)',
                    labelText: 'Thumbnail URL (Opsional)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _thumbnail = value?.trim() ?? '';
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return null;
                    }
                    final uri = Uri.tryParse(value.trim());
                    if (uri == null || !uri.hasScheme || !uri.hasAuthority) {
                      return 'Masukkan URL yang valid (mis. https://...)';
                    }
                    return null;
                  },
                ),
              ),

              // === Is Ongoing ===
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Sedang Berlangsung (Ongoing)'),
                  value: _isOngoing,
                  onChanged: (bool value) {
                    setState(() {
                      _isOngoing = value;
                      if (_isOngoing) _endedAt = null;
                    });
                  },
                ),
              ),

              // === Ended At (jika tidak ongoing) ===
              if (!_isOngoing)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton.icon(
                    onPressed: _pickEndedDate,
                    icon: const Icon(Icons.calendar_today),
                    label: Text(
                      _endedAt == null
                          ? 'Pilih Tanggal Selesai (Ended At)'
                          : 'Ended At: ${_endedAt!.year}-${_endedAt!.month.toString().padLeft(2, '0')}-${_endedAt!.day.toString().padLeft(2, '0')}',
                    ),
                  ),
                ),

              // === Tombol Save ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.indigo),
                    ),
                    onPressed: _isSubmitting ? null : _submit,
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
