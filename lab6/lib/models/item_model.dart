class StudyTask {
  final String id;
  final String subject;
  final String assignment;
  final String deadline;
  bool isCompleted;

  StudyTask({
    required this.id,
    required this.subject,
    required this.assignment,
    required this.deadline,
    this.isCompleted = false,
  });
}