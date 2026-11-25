import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _endDateFieldKey = GlobalKey<FormFieldState<DateTime>>();

  String _institutionName = "";
  String _description = "";
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isOngoing = false;

  String _formatDate(DateTime? date) {
    if (date == null) return "";
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Education Form')),
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
              // === Institution Name ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "SMA 67 Jayakarta",
                    labelText: "Nama Institusi Pendidikan",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _institutionName = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama institusi pendidikan tidak boleh kosong!";
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
                    hintText: "Deskripsi terkait jurusan, IPK, kegiatan, dll.",
                    labelText: "Deskripsi Pendidikan",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Deskripsi pendidikan tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // === Start Date ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormField<DateTime>(
                  validator: (value) {
                    if (_startDate == null) {
                      return "Tanggal mulai tidak boleh kosong!";
                    }
                    return null;
                  },
                  builder: (FormFieldState<DateTime> state) {
                    return InkWell(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: _startDate ?? DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          setState(() {
                            _startDate = picked;
                            // Reset tanggal selesai jika lebih awal dari tanggal mulai baru
                            if (_endDate != null &&
                                _endDate!.isBefore(_startDate!)) {
                              _endDate = null;
                              _endDateFieldKey.currentState?.didChange(null);
                            }
                          });
                          state.didChange(picked);
                        }
                      },
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: "Tanggal Mulai",
                          suffixIcon: const Icon(Icons.calendar_today),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          errorText: state.errorText,
                        ),
                        child: Text(
                          _startDate == null
                              ? "Pilih Tanggal Mulai"
                              : _formatDate(_startDate),
                          style: TextStyle(
                            color: _startDate == null
                                ? Colors.grey[600]
                                : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // === Checkbox Masih Berjalan ===
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  activeColor: Colors.indigo,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: const Text("Pendidikan ini masih berjalan (Saat ini)"),
                  value: _isOngoing,
                  onChanged: (bool? value) {
                    setState(() {
                      _isOngoing = value ?? false;
                      if (_isOngoing) {
                        _endDate = null;
                        _endDateFieldKey.currentState?.reset();
                      }
                    });
                  },
                ),
              ),

              // === End Date ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormField<DateTime>(
                  key: _endDateFieldKey,
                  validator: (value) {
                    if (!_isOngoing && _endDate == null) {
                      return "Tanggal selesai wajib diisi jika sudah lulus/selesai!";
                    }
                    return null;
                  },
                  builder: (FormFieldState<DateTime> state) {
                    return InkWell(
                      onTap: _isOngoing
                          ? null
                          : () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate:
                                    _endDate ?? _startDate ?? DateTime.now(),
                                firstDate: _startDate ?? DateTime(1950),
                                lastDate: DateTime(2100),
                              );
                              if (picked != null) {
                                setState(() {
                                  _endDate = picked;
                                });
                                state.didChange(picked);
                              }
                            },
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: "Tanggal Selesai",
                          suffixIcon: const Icon(Icons.calendar_today),
                          filled: _isOngoing,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          errorText: state.errorText,
                        ),
                        child: Text(
                          _isOngoing
                              ? "Sekarang (Masih Berjalan)"
                              : (_endDate == null
                                    ? "Pilih Tanggal Selesai"
                                    : _formatDate(_endDate)),
                          style: TextStyle(
                            color: _isOngoing || _endDate == null
                                ? Colors.grey[600]
                                : Colors.black,
                            fontStyle: _isOngoing
                                ? FontStyle.italic
                                : FontStyle.normal,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.indigo,
                            side: const BorderSide(color: Colors.indigo),
                          ),
                          onPressed: () {
                            _formKey.currentState!.reset();
                            _endDateFieldKey.currentState?.reset();
                            setState(() {
                              _institutionName = "";
                              _description = "";
                              _startDate = null;
                              _endDate = null;
                              _isOngoing = false;
                            });
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                const SnackBar(
                                  content: Text("Form telah dikosongkan"),
                                ),
                              );
                          },
                          child: const Text("Reset"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Colors.indigo,
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text(
                                      'Pendidikan berhasil ditambahkan!',
                                    ),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Nama Institusi: $_institutionName',
                                          ),
                                          Text('Deskripsi: $_description'),
                                          Text(
                                            'Tanggal Mulai: ${_formatDate(_startDate)}',
                                          ),
                                          Text(
                                            'Tanggal Selesai: ${_isOngoing ? "-" : _formatDate(_endDate)}',
                                          ),
                                          Text(
                                            'Status: ${_isOngoing ? "Masih Berjalan" : "Selesai"}',
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          _formKey.currentState!.reset();
                                          setState(() {
                                            _institutionName = "";
                                            _description = "";
                                            _startDate = null;
                                            _endDate = null;
                                            _isOngoing = false;
                                          });
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: const Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
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
