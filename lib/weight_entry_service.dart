// weight_entry_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class WeightEntryService {
  final CollectionReference _weightsCollection =
      FirebaseFirestore.instance.collection('weights');

  Future<void> submitWeight(String weight) async {
    if (weight.isNotEmpty) {
      try {
        await _weightsCollection.add({
          'weight': weight,
          'timestamp': FieldValue.serverTimestamp(),
        });
      } catch (error) {
        print('Error submitting weight: $error');
      }
    }
  }

  Stream<QuerySnapshot> getWeightStream() {
    return _weightsCollection
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<void> deleteWeight(String documentId) async {
    try {
      print(' thisis from service --------');
      await _weightsCollection.doc(documentId).delete();
    } catch (error) {
      print('Error deleting weight: $error');
    }
  }
}
