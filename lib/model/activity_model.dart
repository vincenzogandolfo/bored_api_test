class Activity {
  final String activity;
  final String type;
  final int participants;

  Activity({
    required this.activity,
    required this.type,
    required this.participants,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      activity: json['activity'],
      type: json['type'],
      participants: json['participants'],
    );
  }
}
