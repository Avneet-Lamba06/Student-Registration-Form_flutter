
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';

// 👉 Change this to your PC's IP if it changes
const String baseUrl = 'http://192.168.29.81/student_app/';

void main() => runApp(const StudentApp());

// ───────────────────────── App Root ─────────────────────────
class StudentApp extends StatelessWidget {
  const StudentApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Register',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[50],
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: const StadiumBorder(),
          ),
        ),
      ),
      home: const StudentHome(),
    );
  }
}

// ───────────────────────── Home (Form) ─────────────────────────
class StudentHome extends StatefulWidget {
  const StudentHome({Key? key}) : super(key: key);
  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  DateTime? selectedDob;
  String? selectedGender;

  // Email pattern (very common RFC‑5322 lite)
  final _emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,4}$');

  // ───────────────────────── Register ─────────────────────────
  Future<void> registerStudent() async {
    if (nameController.text.isEmpty ||
        contactController.text.isEmpty ||
        emailController.text.isEmpty ||
        selectedDob == null ||
        selectedGender == null) {
      _snack('Please fill all fields');
      return;
    }

    if (contactController.text.length != 10) {
      _snack('Contact must be exactly 10 digits');
      return;
    }

    if (!_emailRegex.hasMatch(emailController.text)) {
      _snack('Enter a valid email address');
      return;
    }

    try {
      await http.post(
        Uri.parse('${baseUrl}register.php'),
        body: {
          'name': nameController.text,
          'contact': contactController.text,
          'email': emailController.text,
          'dob': _formatDate(selectedDob!),
          'gender': selectedGender!,
        },
      );
      _snack('Student registered!');
      _clearForm();
    } catch (e) {
      _snack('Network error: $e');
    }
  }

  // ───────────────────────── Helpers ─────────────────────────
  String _formatDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  void _clearForm() {
    nameController.clear();
    contactController.clear();
    emailController.clear();
    setState(() {
      selectedDob = null;
      selectedGender = null;
    });
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  // ───────────────────────── UI ─────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Register'), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildFormCard(),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.list_alt),
                label: const Text('View Submitted Data'),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const StudentsListPage()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: contactController,
              decoration:
                  const InputDecoration(labelText: 'Contact Number (10 digits)'),
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    selectedDob == null
                        ? 'Date of Birth'
                        : '${selectedDob!.day}/${selectedDob!.month}/${selectedDob!.year}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.calendar_today_rounded),
                  label: const Text('Select'),
                  onPressed: () async {
                    final today = DateTime.now();
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: today,
                      firstDate: DateTime(1900),
                      lastDate: today,
                    );
                    if (picked != null) setState(() => selectedDob = picked);
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedGender,
              decoration: const InputDecoration(labelText: 'Gender'),
              items: const [
                DropdownMenuItem(value: 'Male', child: Text('Male')),
                DropdownMenuItem(value: 'Female', child: Text('Female')),
                DropdownMenuItem(value: 'Other', child: Text('Other')),
              ],
              onChanged: (val) => setState(() => selectedGender = val),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save_alt),
                label: const Text('Register'),
                onPressed: registerStudent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────── Students List Page ─────────────────────────
class StudentsListPage extends StatefulWidget {
  const StudentsListPage({Key? key}) : super(key: key);
  @override
  State<StudentsListPage> createState() => _StudentsListPageState();
}

class _StudentsListPageState extends State<StudentsListPage> {
  List<Map<String, dynamic>> students = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _fetchStudents();
  }

  Future<void> _fetchStudents() async {
    setState(() => loading = true);
    try {
      final res = await http.get(Uri.parse('${baseUrl}fetch.php'));
      final data = json.decode(res.body) as List;
      setState(() => students = data.cast<Map<String, dynamic>>());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Network error: $e')),
      );
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Students')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : students.isEmpty
              ? Center(
                  child: TextButton.icon(
                    icon: const Icon(Icons.refresh),
                    label: const Text('No students yet – tap to refresh'),
                    onPressed: _fetchStudents,
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _fetchStudents,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: students.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, index) {
                      final s = students[index];
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.teal,
                            child: Text(
                              s['name']
                                      ?.toString()
                                      .substring(0, 1)
                                      .toUpperCase() ??
                                  '?',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            s['name']?.toString() ?? '',
                            style:
                                const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            'Email: ${s['email'] ?? ''}\n'
                            'DOB: ${s['dob'] ?? ''} • Gender: ${s['gender'] ?? ''}\n'
                            'Contact: ${s['contact'] ?? ''}',
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
