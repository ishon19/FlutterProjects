import 'package:FoodApp/widgets/mainDrawer.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final Function saveFilters;
  final Map<String, bool> currentFilter;

  SettingsScreen(this.currentFilter, this.saveFilters);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilter['gluten'];
    _vegetarian = widget.currentFilter['veg'];
    _lactoseFree = widget.currentFilter['lactose'];
    _vegan = widget.currentFilter['vegan'];
    super.initState();

  }

  Widget _switchListBuilder(
    String title,
    String subTitle,
    bool currentValue,
    Function updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(subTitle),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferences'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
             final preferences = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'veg': _vegetarian,
                'vegan': _vegan,
              };
              print('pref: $preferences');
              widget.saveFilters(preferences);
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Please select your preferences here',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _switchListBuilder(
                'Gluten Free',
                'Filters Gluten Free meals',
                _glutenFree,
                (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                },
              ),
              _switchListBuilder(
                'Lactose Free',
                'Filters Lactose Free meals',
                _lactoseFree,
                (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                },
              ),
              _switchListBuilder(
                'Vegetarian',
                'Vegetarian meals only',
                _vegetarian,
                (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                },
              ),
              _switchListBuilder(
                'Vegan',
                'Vegan meals only',
                _vegan,
                (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                },
              ),
            ],
          ))
        ],
      ),
    );
  }
}
