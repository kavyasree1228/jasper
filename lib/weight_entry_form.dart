// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:jasper/auth_services.dart';
// import 'package:jasper/sign_in_screen.dart';
// import 'package:jasper/weight_entry_model.dart';
// import 'package:jasper/weight_entry_service.dart';

// class WeightEntryScreen extends StatefulWidget {
//   @override
//   _WeightEntryScreenState createState() => _WeightEntryScreenState();
// }

// class _WeightEntryScreenState extends State<WeightEntryScreen> {
//   late TextEditingController _weightController;
//   late WeightEntryService _weightEntryService;
//   late CollectionReference _weightsCollection;
//   late AuthService _authService;

//   @override
//   void initState() {
//     super.initState();
//     _weightController = TextEditingController();
//     _weightEntryService = WeightEntryService();
//     _weightsCollection = FirebaseFirestore.instance.collection('weights');
//     _authService = AuthService();
//   }

//   Future<void> _submitWeight() async {
//     await _weightEntryService.submitWeight(_weightController.text);
//     setState(() {
//       _weightController
//           .clear(); // do not forget to clear weight after successful submission
//     });
//   }

//   Future<void> _deleteWeight(String documentId) async {
//     await _weightEntryService.deleteWeight(documentId);
//   }

//   Future<void> _signOut() async {
//     await _authService.signOut();
//     // ignore: use_build_context_synchronously
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (context) => SignInScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Weight Entry Form'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.exit_to_app),
//             onPressed: _signOut,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text('Enter Your Weight in Lbs:'),
//                 TextFormField(
//                   controller: _weightController,
//                   keyboardType: TextInputType.number,
//                 ),
//                 const SizedBox(height: 16.0),
//                 ElevatedButton(
//                   onPressed: _submitWeight,
//                   child: const Text('Submit'),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: _buildWeightList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildWeightList() {
//     return StreamBuilder<QuerySnapshot>(
//       stream:
//           _weightsCollection.orderBy('timestamp', descending: true).snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: const CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return const Center(child: Text('No weight entries to display.'));
//         } else {
//           List<WeightEntry> weights = snapshot.data!.docs
//               .map((doc) => WeightEntry.fromMap(
//                   doc.id, doc.data() as Map<String, dynamic>))
//               .toList();

//           return ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: weights.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text('Weight: ${weights[index].weight}'),
//                 subtitle: Text('Date: ${weights[index].formattedTimestamp}'),
//                 trailing: IconButton(
//                   icon: Icon(Icons.delete),
//                   onPressed: () => _deleteWeight(weights[index].documentId),
//                 ),
//               );
//             },
//           );
//         }
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _weightController.dispose();
//     super.dispose();
//   }
// }
