import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/widget/new_item.dart';
import 'package:shopping_list/models/grocery_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  //show items and add new List
  List<GroceryItem> _groceryItems = [];
  var _isLoading = true;
  String? _error;

//fetch data in firebase
  @override
  void initState() {
    super.initState();
    _loadItem();
  }

  void _loadItem() async {
    //fetch data
    final url = Uri.https(
        'shoppingapp-3ddd3-default-rtdb.firebaseio.com', 'shopping-list.json');
    try {
      final response = await http.get(url);
      //error handle

      //emplty data
      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      //get decode data tell is map
      final Map<String, dynamic> listData = json.decode(response.body);
      // convert get outers
      final List<GroceryItem> loadedItemList = []; //temp list store
      for (final item in listData.entries) {
        final catergory = categories.entries
            .firstWhere(
                (catItem) => catItem.value.titile == item.value['category'])
            .value;
        //gell all data
        loadedItemList.add(GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: catergory));
      }
      //set to earlier difine value to new
      setState(() {
        _groceryItems = loadedItemList;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _error = 'Something went wrong. Please try again later.';
      });
    }
  }

  //display data this widget
  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: ((ctx) => const NewItem()),
      ),
    );
    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  //remove item
  void _removeItem(GroceryItem item) async {
    final index = _groceryItems.indexOf(item);

    setState(() {
      _groceryItems.remove(item);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
        content: const Text("Deleted"),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _groceryItems.insert(index, item);
              });
            }),
      ),
    );
    final url = Uri.https('shoppingapp-3ddd3-default-rtdb.firebaseio.com',
        'shopping-list/${item.id}.json');
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      print("Error");
    }

    //undo delete
  }

  @override
  Widget build(BuildContext context) {
    //write message if nothing list Items added this is fallback content and add dismiisable to swap then delete
    Widget content = const Center(
      child: Text("No Items here.."),
    );
    if (_isLoading) {
      content = const Center(child: CircularProgressIndicator.adaptive());
    }
    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: ((context, index) => Dismissible(
              //to delete swap use Dissmissble
              onDismissed: ((direction) {
                _removeItem(_groceryItems[index]);
              }),
              key: ValueKey(_groceryItems[index].id),
              //to delete
              child: ListTile(
                title: Text(_groceryItems[index].name),
                leading: Container(
                  height: 24,
                  width: 24,
                  color: _groceryItems[index].category.color,
                ),
                trailing: Text(
                  _groceryItems[index].quantity.toString(),
                ),
              ),
            )),
      );
    }
    //error
    if (_error != null) {
      content = Center(child: Text(_error!));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Grocery List"),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
