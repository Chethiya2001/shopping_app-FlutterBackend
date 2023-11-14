import 'package:flutter/material.dart';

enum Catergories {
  vegetables,
  fruit,
  meat,
  dairy,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  other
}

class Category {
  const Category(this.titile, this.color);

  final String titile;
  final Color color;
}
