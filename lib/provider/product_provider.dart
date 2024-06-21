import 'package:prototype_ss/model/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ProductsProvider with ChangeNotifier {
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];

  List<Product> get products => _filteredProducts;
  List<Product> get allProducts => _allProducts;

  Future<void> fetchProducts() async {
    try {
      var snapshot = await FirebaseFirestore.instance.collection('products').get();
      _allProducts = snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
      _filteredProducts = List.from(_allProducts);
      notifyListeners();
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  void filterProducts(String searchQuery, List<String> categoryFilters, List<String> styleFilters, List<String> seasonFilters) 
  async {
     _filteredProducts = List.from(_allProducts);

     print("total = ${_allProducts.length}");

    if (searchQuery.isNotEmpty) {
      _filteredProducts = _filteredProducts.where((product) {
        return product.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
               product.description.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    if (categoryFilters.isNotEmpty) {
      _filteredProducts = _filteredProducts.where((product) {
        return categoryFilters.contains(product.category);
      }).toList();
    }

    if (styleFilters.isNotEmpty) {
      _filteredProducts = _filteredProducts.where((product) {
        return styleFilters.contains(product.style);
      }).toList();
    }

    if (seasonFilters.isNotEmpty) {
      _filteredProducts = _filteredProducts.where((product) {
        return seasonFilters.contains(product.season);
      }).toList();
    }

    notifyListeners();
  }
}
