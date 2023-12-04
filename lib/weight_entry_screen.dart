import 'package:flutter/material.dart';
import 'package:jasper/auth_services.dart';

import 'package:jasper/sign_in_screen.dart';
import 'package:jasper/weight_entry_list.dart';

import 'package:jasper/weight_entry_service.dart';

class WeightEntryScreen extends StatefulWidget {
  @override
  _WeightEntryScreenState createState() => _WeightEntryScreenState();
}

class _WeightEntryScreenState extends State<WeightEntryScreen> {
  late TextEditingController _weightController;
  late WeightEntryService _weightEntryService;
  late AuthService _authService;

  void initState() {
    super.initState();
    _weightController = TextEditingController();
    _weightEntryService = WeightEntryService();
    _authService = AuthService();
  }

  Future<void> _submitWeight() async {
    await _weightEntryService.submitWeight(_weightController.text);
    // Clear weight after successful submission
  }

  Future<void> _signOut() async {
    await _authService.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }

  Future<void> _deleteWeight(String documentId) async {
    await _weightEntryService.deleteWeight(documentId);
  }

  // void _editWeight(WeightEntry weight) {
  //   // Navigate to a new screen or dialog for weight editing
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => EditWeightScreen(
  //         weight: weight,
  //         weightsCollection: _weightEntryService.getWeightsCollection(),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weight Entry Form'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: _signOut,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Please enter Your Weight in Lbs:'),
                TextFormField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  onFieldSubmitted: (value) {
                    _submitWeight();
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _submitWeight,
                  child: Text('Submit Weight'),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: WeightEntryList(
                stream: _weightEntryService.getWeightStream(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // to Clean up the controller when the widget is removed from the widget tree.
    _weightController.dispose();
    super.dispose();
  }
}
