import 'package:flutter/material.dart';
import 'package:greatplaces/models/places.dart';
import 'package:greatplaces/screens/map_screen.dart';

class PlacesDetailScreen extends StatelessWidget {
  const PlacesDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Place place = ModalRoute.of(context)!.settings.arguments as Place;
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              place.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            place.location.addres as String,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          SizedBox(
            height: 10,
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => MapScreen(
                      isreadonly: true,
                      initialLocation: place.location,
                    )),
                fullscreenDialog: true,
              ));
            },
            icon: Icon(Icons.map),
            label: Text('Ver no Mapa'),
          ),
        ],
      ),
    );
  }
}
