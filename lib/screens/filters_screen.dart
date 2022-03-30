import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  //const FiltersScreen({ Key? key }) : super(key: key);
//
  static const routeName = '/filters-screen';
  final Function filterHandler;
  final Map<String, bool> filters;
  FiltersScreen(this.filters, this.filterHandler);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var isGlutenFree = false;
  var isVegan = false;
  var isVegetarian = false;
  var isLactoseFree = false;

  // // () {
  //   isGlutenFree = widget.filters['gluten'];
  //   isVegan = widget.filters['vegan'];
  //   isVegetarian = widget.filters['vegetarian'];
  //   isLactoseFree = widget.filters['lactose'];
  //   super.initState();
  // }
  @override
  void initState() {
    isGlutenFree = widget.filters['gluten'];
    isVegan = widget.filters['vegan'];
    isVegetarian = widget.filters['vegetarian'];
    isLactoseFree = widget.filters['lactose'];
    super.initState();
  }

  Widget buildSwitchTile(
      String title, String subTitle, bool currentValue, Function updateValue) {
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
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                final selectedFilters = {
                  'gluten': isGlutenFree,
                  'lactose': isLactoseFree,
                  'vegan': isVegan,
                  'vegetarian': isVegetarian
                };
                widget.filterHandler(selectedFilters);
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text('Adjust your meal selection',
                style: Theme.of(context).appBarTheme.titleTextStyle),
          ),
          Expanded(
              child: ListView(
            children: <Widget>[
              buildSwitchTile(
                  'Gluten-Free', 'Only include gluten free meal', isGlutenFree,
                  (newValue) {
                setState(() {
                  isGlutenFree = newValue;
                });
              }),
              buildSwitchTile('Lactose-Free', 'Only include Lactose free meal',
                  isLactoseFree, (newValue) {
                setState(() {
                  isLactoseFree = newValue;
                });
              }),
              buildSwitchTile('Vegetarian Meals',
                  'Only include Vegetarian meal', isVegetarian, (newValue) {
                setState(() {
                  isVegetarian = newValue;
                });
              }),
              buildSwitchTile('Vegan Meals', 'Only include Vegan meal', isVegan,
                  (newValue) {
                setState(() {
                  isVegan = newValue;
                });
              }),
            ],
          ))
        ],
      ),
    );
  }
}
