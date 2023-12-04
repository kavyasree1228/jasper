import 'package:cloud_firestore/cloud_firestore.dart';

class WeightEntry {
  final String documentId;
  final String weight;
  final DateTime timestamp;

  WeightEntry({
    required this.documentId,
    required this.weight,
    required this.timestamp,
  });

  factory WeightEntry.fromMap(String documentId, Map<String, dynamic> map) {
    return WeightEntry(
      documentId: documentId,
      weight: map['weight'] ?? '',
      timestamp: (map['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  String get formattedTimestamp => '${timestamp.toLocal()}';
}
