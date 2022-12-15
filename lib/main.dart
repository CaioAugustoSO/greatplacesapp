import 'package:flutter/material.dart';
import 'package:greatplaces/providers/great_places.dart';
import 'package:greatplaces/screens/place_form_screen.dart';
import 'package:greatplaces/screens/places_list_screen.dart';
import 'package:greatplaces/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlaces(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
        ),
        home: PlacesListScreen(),
        routes: {
          AppRoutes.PLACE_FORM: (ctx) => PlacesFormScreen(),
        },
      ),
    );
  }
}
