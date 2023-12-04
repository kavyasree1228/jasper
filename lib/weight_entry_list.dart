import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jasper/weight_entry_model.dart';
import 'package:jasper/weight_entry_service.dart';

class WeightEntryList extends StatefulWidget {
  final Stream<QuerySnapshot> stream;

  WeightEntryList({Key? key, required this.stream}) : super(key: key);

  @override
  _WeightEntryListState createState() => _WeightEntryListState();
}

class _WeightEntryListState extends State<WeightEntryList> {
  late WeightEntryService _weightEntryService;

  @override
  void initState() {
    super.initState();
    _weightEntryService = WeightEntryService();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No weight entries to display.'));
        } else {
          List<WeightEntry> weights = snapshot.data!.docs
              .map((doc) => WeightEntry.fromMap(
                  doc.id, doc.data() as Map<String, dynamic>))
              .toList();

          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: weights.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Weight: ${weights[index].weight}'),
                subtitle: Text('Date: ${weights[index].formattedTimestamp}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteWeight(weights[index].documentId),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

  Future<void> _deleteWeight(String documentId) async {
    await _weightEntryService.deleteWeight(documentId);
    print('This is from the list.');
  }
}
