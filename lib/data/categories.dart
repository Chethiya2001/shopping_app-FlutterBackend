import 'package:flutter/material.dart';

import 'package:shopping_list/models/category.dart';

const categories = {
  Catergories.vegetables: Category(
    'Vegetables',
    Color.fromARGB(255, 0, 255, 128),
  ),
  Catergories.fruit: Category(
    'Fruit',
    Color.fromARGB(255, 145, 255, 0),
  ),
  Catergories.meat: Category(
    'Meat',
    Color.fromARGB(255, 255, 102, 0),
  ),
  Catergories.dairy: Category(
    'Dairy',
    Color.fromARGB(255, 0, 208, 255),
  ),
  Catergories.carbs: Category(
    'Carbs',
    Color.fromARGB(255, 0, 60, 255),
  ),
  Catergories.sweets: Category(
    'Sweets',
    Color.fromARGB(255, 255, 149, 0),
  ),
  Catergories.spices: Category(
    'Spices',
    Color.fromARGB(255, 255, 187, 0),
  ),
  Catergories.convenience: Category(
    'Convenience',
    Color.fromARGB(255, 191, 0, 255),
  ),
  Catergories.hygiene: Category(
    'Hygiene',
    Color.fromARGB(255, 149, 0, 255),
  ),
  Catergories.other: Category(
    'Other',
    Color.fromARGB(255, 0, 225, 255),
  ),
};
