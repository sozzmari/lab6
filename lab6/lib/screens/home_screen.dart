import 'package:flutter/material.dart';
import '../models/item_model.dart';
import 'add_item_screen.dart';
import 'detail_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  final String username;

  const HomeScreen({super.key, required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<StudyTask> _tasks = [
    StudyTask(
      id: '1',
      subject: 'Mobile Development', 
      assignment: 'Build multi-screen mini-project', 
      deadline: 'Nov 30, 2026',
      isCompleted: false,
    ),
    StudyTask(
      id: '2', 
      subject: 'Algorithms & Data Structures', 
      assignment: 'Implement graph traversal lab', 
      deadline: 'Nov 30, 2026',
      isCompleted: true,
    ),
    StudyTask(
      id: '3', 
      subject: 'Database Systems', 
      assignment: 'Normalize ER diagram and write SQL queries', 
      deadline: 'Dec 01, 2026',
      isCompleted: false,
    ),
    StudyTask(
      id: '4', 
      subject: 'Linear Programming', 
      assignment: 'Solve simplex method problem set', 
      deadline: 'Dec 03, 2026',
      isCompleted: true,
    ),
    StudyTask(
      id: '5', 
      subject: 'Software Engineering', 
      assignment: 'Prepare architecture presentation slides', 
      deadline: 'Dec 04, 2026',
      isCompleted: false,
    ),
  ];

  int get _completedCount {
    int count = 0;
    for (final task in _tasks) {
      if (task.isCompleted) {
        count += 1;
      }
    }
    return count;
  }

  Future<void> _openAddTaskScreen() async {
    final StudyTask? createdTask = await Navigator.push<StudyTask>(
      context,
      MaterialPageRoute(
        builder: (context) => const AddItemScreen(),
      ),
    );

    if (createdTask != null) {
      setState(() {
        _tasks.add(createdTask);
      });
    }
  }

  Future<void> _openDetailScreen(int index) async {
    final bool? shouldDelete = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(task: _tasks[index]),
      ),
    );

    if (shouldDelete == true) {
      setState(() {
        _tasks.removeAt(index);
      });
    }
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Study palnner'),
            Text(
              'User: ${widget.username}',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _logout,
            tooltip: 'Log out',
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Total tasks',
                          style: TextStyle(fontSize: 13, color: Colors.black54),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${_tasks.length}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 1,
                      height: 36,
                      color: Colors.grey.shade300,
                    ),
                    Column(
                      children: [
                        const Text(
                          'Completed',
                          style: TextStyle(fontSize: 13, color: Colors.black54),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$_completedCount',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: _tasks.isEmpty
                ? const Center(
                  child: Text(
                    'No tasks yet. Tap + to add one.',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                )
              : ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final StudyTask task = _tasks[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      onTap: () => _openDetailScreen(index),
                      leading: Checkbox(
                        value: task.isCompleted, 
                        onChanged: (bool? value) {
                          setState(() {
                            task.isCompleted = value ?? false;
                          });
                        },
                      ),
                      title: Text(
                        task.subject,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      subtitle: Text(
                        '${task.assignment} * Due: ${task.deadline}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  );
                },
              ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTaskScreen,
        child: const Icon(Icons.add),
      ),
    );
  }
}