import 'package:flutter/material.dart';
import '../models/item_model.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _assignmentController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  String _errorText = '';

  @override
  void dispose() {
    _subjectController.dispose();
    _assignmentController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  void _saveTask() {
    final String subject = _subjectController.text.trim();
    final String assignment = _assignmentController.text.trim();
    final String deadline = _deadlineController.text.trim().isEmpty
        ? 'No deadline set'
        : _deadlineController.text.trim();

    if (subject.isEmpty || assignment.isEmpty) {
      setState(() {
        _errorText = 'Please enter both subject and assignment.';
      });
      return;
    }

    final StudyTask newTask = StudyTask(
      id: DateTime.now().millisecondsSinceEpoch.toString(), 
      subject: subject, 
      assignment: assignment, 
      deadline: deadline,
      isCompleted: false,
    );

    Navigator.pop(context, newTask);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _subjectController,
              decoration: const InputDecoration(
                labelText: 'Subject',
                hintText: 'e.g., Operating Systems',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _assignmentController,
              decoration: const InputDecoration(
                labelText: 'Assignment',
                hintText: 'e.g., Process scheduling lab report',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _deadlineController,
              decoration: const InputDecoration(
                labelText: 'Deadline',
                hintText: 'e.g. Dec 15, 2026',
                border: OutlineInputBorder(),
              ),
            ),
            if (_errorText.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                _errorText,
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _saveTask,
              icon: const Icon(Icons.save),
              label: const Text('Save'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}