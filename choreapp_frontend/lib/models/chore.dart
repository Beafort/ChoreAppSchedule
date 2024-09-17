class Chore {
  final int? id;
  final String name;
  final DateTime deadline;
  final bool done;
  const Chore(
      {this.id,
      required this.name,
      required this.deadline,
      required this.done});
  factory Chore.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'deadline': String deadlineString,
        'done': bool done
      } =>
        Chore(
            id: id,
            name: name,
            deadline: DateTime.parse(deadlineString),
            done: done),
      _ => throw const FormatException('Failed to load json')
    };
  }
}
