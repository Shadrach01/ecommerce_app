import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/product.dart';

class ProductFirestoreService {
  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;
  static const String _productsCollecion = 'products';

  // Get all products
  static Future<List<Product>> getAllProducts() async {
    try {
      final querySnapshot = await _firestore
          .collection(_productsCollecion)
          .where('isActive', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        return Product.fromFirestore(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  // Get all products by category
  static Future<List<Product>> getAllProductsByCategory(
    String category,
  ) async {
    try {
      final querySnapshot = await _firestore
          .collection(_productsCollecion)
          .where('isActive', isEqualTo: true)
          .where('category', isEqualTo: category)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        return Product.fromFirestore(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      print('Error fetching products by category: $e');
      return [];
    }
  }

  // Get featured products
  static Future<List<Product>> getFeaturedProducts() async {
    try {
      final querySnapshot = await _firestore
          .collection(_productsCollecion)
          .where('isActive', isEqualTo: true)
          .where('isFeatured', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .limit(10)
          .get();

      return querySnapshot.docs.map((doc) {
        return Product.fromFirestore(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      print('Error fetching featured products: $e');
      return [];
    }
  }

  // Get products on sale
  static Future<List<Product>> getSaleProducts() async {
    try {
      final querySnapshot = await _firestore
          .collection(_productsCollecion)
          .where('isActive', isEqualTo: true)
          .where('isOnSale', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        return Product.fromFirestore(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      print('Error fetching sale products: $e');
      return [];
    }
  }

  // Search products
  static Future<List<Product>> searchProducts(
    String searchTerm,
  ) async {
    try {
      final querySnapshot = await _firestore
          .collection(_productsCollecion)
          .where('isActive', isEqualTo: true)
          .where(
            'searchKeywords',
            arrayContains: searchTerm.toLowerCase(),
          )
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        return Product.fromFirestore(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      print('Error searching products: $e');
      return [];
    }
  }

  // Get products by ID
  static Future<Product?> getProductsById(
    String productId,
  ) async {
    try {
      final doc = await _firestore
          .collection(_productsCollecion)
          .doc(productId)
          .get();

      if (doc.exists) {
        return Product.fromFirestore(doc.data()!, doc.id);
      }
      return null;
    } catch (e) {
      print('Error fetching products by ID: $e');
      return null;
    }
  }

  // Get produts stream for real-time updates
  static Stream<List<Product>> getProductStream() {
    return _firestore
        .collection(_productsCollecion)
        .where('isActive', isEqualTo: true)
        .orderBy('createdBy', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return Product.fromFirestore(
              doc.data(),
              doc.id,
            );
          }).toList();
        });
  }

  // Get produts by price range
  static Future<List<Product>> getProductByPriceRange({
    required double minPrice,
    required double maxPrice,
  }) async {
    try {
      final querySnapshot = await _firestore
          .collection(_productsCollecion)
          .where('isActive', isEqualTo: true)
          .where('price', isGreaterThanOrEqualTo: minPrice)
          .where('price', isLessThanOrEqualTo: maxPrice)
          .orderBy('price')
          .get();

      return querySnapshot.docs.map((doc) {
        return Product.fromFirestore(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      print('Error fetching products by price: $e');
      return [];
    }
  }

  // Get all categories
  static Future<List<String>> getAllCategories() async {
    try {
      final querySnapshot = await _firestore
          .collection(_productsCollecion)
          .where('isActive', isEqualTo: true)
          .get();

      final categories = <String>{};
      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        if (data['category'] != null) {
          categories.add(data['category'] as String);
        }
      }

      return categories.toList()..sort();
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }
}
