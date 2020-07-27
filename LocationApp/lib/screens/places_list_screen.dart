import 'package:LocationApp/providers/great_places.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Places'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
            ),
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (ctx, snapShot) =>
              snapShot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<GreatPlaces>(
                      child: Center(
                        child: const Text('No places saved yet'),
                      ),
                      builder: (ctx, greatPlaces, ch) =>
                          greatPlaces.items.length <= 0
                              ? ch
                              : ListView.builder(
                                  itemBuilder: (ctx, i) => ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: FileImage(
                                        greatPlaces.items[i].image,
                                      ),
                                    ),
                                    title: Text(greatPlaces.items[i].title),
                                    onTap: () {
                                      //..
                                    },
                                  ),
                                  itemCount: greatPlaces.items.length,
                                ),
                    ),
        ));
  }
}
