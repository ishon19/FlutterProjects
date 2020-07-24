import 'package:LocationApp/providers/great_places.dart';
import 'package:LocationApp/screens/add_place_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlacesScreen.routeName);
            },
          )
        ],
      ),
      body: Consumer<GreatPlaces>(
        child: Center(
          child: const Text('No place added yet'),
        ),
        builder: (ctx, greatPlaces, ch) => greatPlaces.items.length <= 0
            ? ch
            : ListView.builder(
                itemCount: greatPlaces.items.length,
                itemBuilder: (ctx, idx) => ListTile(
                  leading: CircleAvatar(backgroundImage: FileImage(greatPlaces.items[idx].image),),
                  title: Text(greatPlaces.items[idx].title),
                  onTap:(){
                    //go to details page
                  },
                ),
              ),
      ),
    ); 
  }
}
