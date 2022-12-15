import 'dart:io';

import 'package:flutter/material.dart';
import 'package:greatplaces/providers/great_places.dart';
import 'package:greatplaces/widgets/image_input.dart';
import 'package:greatplaces/widgets/location_input.dart';
import 'package:provider/provider.dart';

class PlacesFormScreen extends StatefulWidget {
  const PlacesFormScreen({super.key});

  @override
  State<PlacesFormScreen> createState() => _PlacesFormScreenState();
}

class _PlacesFormScreenState extends State<PlacesFormScreen> {
  final _titleController = TextEditingController();

  File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _submitForm() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }

    Provider.of<GreatPlaces>(context, listen: false)
        .addPlaces(_titleController.text, _pickedImage!);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo Lugar"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: 'Título'),
                  ),
                  SizedBox(height: 10),
                  ImageInput(_selectImage),
                  SizedBox(height: 10),
                  LocationInput(),
                ],
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _submitForm,
            icon: Icon(Icons.add),
            label: Text('Add'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).accentColor,
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }
}
