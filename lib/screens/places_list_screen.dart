import 'package:flutter/material.dart';
import 'package:greatplaces/providers/great_places.dart';
import 'package:greatplaces/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus lugares"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
        builder: ((ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<GreatPlaces>(
                child: Center(
                  child: Text("Nenhum local cadastrado"),
                ),
                builder: (ctx, greatplaces, ch) => greatplaces.itemsCount == 0
                    ? ch as Widget
                    : ListView.builder(
                        itemCount: greatplaces.itemsCount,
                        itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(
                              greatplaces.getItems(i).image,
                            ),
                          ),
                          title: Text(greatplaces.getItems(i).title),
                          onTap: () {},
                        ),
                      ),
              )),
      ),
    );
  }
}
