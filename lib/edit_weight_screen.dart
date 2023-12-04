import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jasper/weight_entry_model.dart';

class EditWeightScreen extends StatefulWidget {
  final WeightEntry weight;
  final CollectionReference weightsCollection;

  const EditWeightScreen({
    Key? key,
    required this.weight,
    required this.weightsCollection,
  }) : super(key: key);

  @override
  _EditWeightScreenState createState() => _EditWeightScreenState();
}

class _EditWeightScreenState extends State<EditWeightScreen> {
  late TextEditingController _weightController;

  @override
  void initState() {
    super.initState();
    _weightController = TextEditingController(text: widget.weight.weight);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Weight'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Edit Weight:'),
            TextFormField(
              controller: _weightController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _submitEditedWeight(widget.weight.documentId);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitEditedWeight(String documentId) {
    String editedWeight = _weightController.text;
    if (editedWeight.isNotEmpty) {
      widget.weightsCollection.doc(documentId).update({
        'weight': editedWeight,
      });
      Navigator.of(context).pop(); // Close the editing screen
    }
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }
}
