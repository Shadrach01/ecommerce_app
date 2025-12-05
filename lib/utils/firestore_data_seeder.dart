import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDataSeeder {
  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  // Seed all data
  static Future<void> seedAllData() async {
    await seedProducts();
  }

  // Add sample products to Firestore
  static Future<void> seedProducts() async {
    final sampleProducts = [
      {
        'name': 'Nike Air Max 270',
        'description':
            'Coomfortable running shoes with excellent cushioning and modern designs. Perfect for daily wear and light excercise.',
        'category': 'Footwear',
        'subcategory': "Running Shoes",
        'price': 129.99,
        'oldPrice': 179.99,
        'currency': 'USD',
        'images': ['assets/images/shoe.jpg'],
        'primaryImage':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzSOrIHIncvVwcn86Yj1lG2no3rymRPhF1AQ&s',
        'brand': 'Nike',
        'sku': 'NIKE-AM270-001',
        'stock': 25,
        'isActive': true,
        'isFeatured': true,
        'isOnSale': true,
        'rating': 4.5,
        'reviewCount': 89,
        'tags': ['popular', 'trending', 'comfortable'],
        'specifications': {
          'color': 'White/Blue',
          'material': 'Synthetic',
          'weight': '0.8kg',
          'sizes': ['7', '8', '9', '10', '11'],
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'searchKeywords': [
          'nike',
          'air',
          'max',
          '270',
          'shoes',
          'running',
          'footwear',
          'white',
          'blue',
        ],
      },
      {
        'name': 'MacBook Pro 13',
        'description':
            'High-performance laptop with M2 chip. Perfect for professionlas and creative work. Features stunning Retina display.',
        'category': 'Electornics',
        'subcategory': "Laptops",
        'price': 1299.99,
        'oldPrice': 1499.99,
        'currency': 'USD',
        'images': ['assets/images/laptop.jpg'],
        'primaryImage':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzSOrIHIncvVwcn86Yj1lG2no3rymRPhF1AQ&s',
        'brand': 'Apple',
        'sku': 'APPLE-MBP13-001',
        'stock': 15,
        'isActive': true,
        'isFeatured': true,
        'isOnSale': false,
        'rating': 4.8,
        'reviewCount': 156,
        'tags': ['premium', 'professional', 'powerful'],
        'specifications': {
          'screen': '13-inch Retina',
          'processor': 'Apple M2',
          'memory': '8GB',
          'storage': '256GB SSD',
          'color': '2Space Gray',
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'searchKeywords': [
          'macbook',
          'pro',
          'laptop',
          'apple',
          'electronics',
          'm2',
          'retina',
        ],
      },
      {
        'name': 'Air Jordan 1 Retro',
        'description':
            'Classix basketball shoes with iconic design. A timeless sneaker that combines style and performance.',
        'category': 'Footwear',
        'subcategory': "Basketball Shoes",
        'price': 170.00,
        'currency': 'USD',
        'images': ['assets/images/shoe2.jpg'],
        'primaryImage':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzSOrIHIncvVwcn86Yj1lG2no3rymRPhF1AQ&s',
        'brand': 'Jordan',
        'sku': 'JORDAN-AJI-001',
        'stock': 30,
        'isActive': true,
        'isFeatured': true,
        'isOnSale': false,
        'rating': 4.7,
        'reviewCount': 203,
        'tags': ['classic', 'basketball', 'iconic'],
        'specifications': {
          'color': 'Black/Red',
          'material': 'Leather',
          'weight': '0.9kg',
          'sizes': ['7', '8', '9', '10', '11', '12'],
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'searchKeywords': [
          'jordan',
          'air',
          'retro',
          'basketball',
          'shoes',
          'black',
          'red',
        ],
      },
      {
        'name': 'Puma RS-X',
        'description':
            'Modern lifestyle sneakers with bold deisgn and superior comfort. Perfefecctct for casual wear and street wear',
        'category': 'Footwear',
        'subcategory': "Lifestyle Shoes",
        'price': 110.00,
        'currency': 'USD',
        'images': ['assets/images/shoes2.jpg'],
        'primaryImage':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzSOrIHIncvVwcn86Yj1lG2no3rymRPhF1AQ&s',
        'brand': 'Puma',
        'sku': 'PUMA-RSK-001',
        'stock': 40,
        'isActive': true,
        'isFeatured': true,
        'isOnSale': true,
        'rating': 4.3,
        'reviewCount': 67,
        'tags': ['Lifestyle', 'casual', 'modern'],
        'specifications': {
          'color': 'Multi-color',
          'material': 'Synthetic/Mesh',
          'weight': '0.7kg',
          'sizes': ['7', '8', '9', '10', '11'],
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'searchKeywords': [
          'puma',
          're-x',
          'lifestyle',
          'shoes',
          'casual',
          'colorful',
        ],
      },

      {
        'name': 'Iphone 15 Pro',
        'description':
            'Latest iphone with titanium design, advanced camera system, and A17 Pro chip for ultimate performance.',
        'category': 'Electronics',
        'subcategory': "Smartphones",
        'price': 999.99,
        'currency': 'USD',
        'images': ['assets/images/phone.jpeg'],
        'primaryImage':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzSOrIHIncvVwcn86Yj1lG2no3rymRPhF1AQ&s',
        'brand': 'Apple',
        'sku': 'APPLE-IP15P-001',
        'stock': 20,
        'isActive': true,
        'isFeatured': true,
        'isOnSale': true,
        'rating': 4.9,
        'reviewCount': 324,
        'tags': ['premium', 'latest', 'flagship'],
        'specifications': {
          'screen': '6.1-inch Super Retina XDR',
          'processor': 'A17 Pro',
          'sstorage': '128Gb',
          'color': 'Titanium Blue',
          'camera': '48MP Main',
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'searchKeywords': [
          'iphone',
          '15',
          'pro',
          'apple',
          'smartphone',
          'titanium',
          'camera',
        ],
      },
      {
        'name': 'Samsung galaxy Watch',
        'description':
            'Smart fitness watch with health monitoring, GPS, and long battery life. Perfect companion for active lifestyle.',
        'category': 'Electronics',
        'subcategory': "Wearables",
        'price': 249.99,
        'oldPrice': 299.99,
        'currency': 'USD',
        'images': ['assets/images/watch.jpeg'],
        'primaryImage':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzSOrIHIncvVwcn86Yj1lG2no3rymRPhF1AQ&s',
        'brand': 'Samsung',
        'sku': 'SAMSUNG-GW-001',
        'stock': 35,
        'isActive': true,
        'isFeatured': false,
        'isOnSale': true,
        'rating': 4.4,
        'reviewCount': 142,
        'tags': ['fitness', 'smart', 'health'],
        'specifications': {
          'display': '1.4-inch AMOLED',
          'battery': '40 hours',
          'waterproof': 'IP68',
          'color': 'White/Blue',
          'connectivity': 'Bluetooth 5.0',
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'searchKeywords': [
          'samsung',
          'galaxy',
          'watch',
          'smart',
          'fitness',
          'health',
          'wearable',
        ],
      },
      {
        'name': 'Nike Dri-FIT T-Shirt',
        'description':
            'Comfortable athletic t-shirt with moisture-wicking technology. Perfect for workouts and casual wear.',
        'category': 'Clothing',
        'subcategory': "T-Shirts",
        'price': 29.99,
        'oldPrice': 39.99,
        'currency': 'USD',
        'images': ['assets/images/tshirt.jpeg'],
        'primaryImage': 'assets/images/tshirt.jpeg',
        'brand': 'Nike',
        'sku': 'NIKE-TSHIRT-001',
        'stock': 50,
        'isActive': true,
        'isFeatured': false,
        'isOnSale': true,
        'rating': 4.2,
        'reviewCount': 76,
        'tags': [
          'athletic',
          'comfortable',
          'moisture-wicking',
        ],
        'specifications': {
          'color': 'Black',
          'material': 'Polyester',
          'fit': 'Regular',
          'sizes': ['S', 'M', 'L', 'XL', 'XXL'],
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'searchKeywords': [
          'nike',
          'dri-fit',
          'tshirt',
          'shirt',
          'clothing',
          'athletic',
          'black',
        ],
      },
      {
        'name': 'Wireless Bluetooth Headphones',
        'description':
            'Premium wireless headphones with noise cancellation and long battery life. Perfect for music and calls.',
        'category': 'Electronics',
        'subcategory': "Audio",
        'price': 199.99,
        'oldPrice': 249.99,
        'currency': 'USD',
        'images': ['assets/images/headphones.jpeg'],
        'primaryImage': 'assets/images/headphones.jpeg',
        'brand': 'Sony',
        'sku': 'SONY-WH-001',
        'stock': 30,
        'isActive': true,
        'isFeatured': true,
        'isOnSale': true,
        'rating': 4.6,
        'reviewCount': 234,
        'tags': ['wireless', 'noise_cancelling', 'premium'],
        'specifications': {
          'color': 'Black',
          'battery': '30 hours',
          'connectivity': 'Bluetooth 5.0',
          'weight': '0.3kg',
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'searchKeywords': [
          'sony',
          'headphones',
          'wireless',
          'bluetooth',
          'audio',
          'electronics',
          'noise',
        ],
      },
      {
        'name': 'Designer Leather Handbag',
        'description':
            'Elegant leather handbag with permium craftmanship. Perfect for professionals and casual occasions.',
        'category': 'Accessories',
        'subcategory': "Bags",
        'price': 149.99,

        'currency': 'USD',
        'images': ['assets/images/handbag.jpeg'],
        'primaryImage': 'assets/images/handbag.jpeg',
        'brand': 'Coach',
        'sku': 'COACH-BAG-001',
        'stock': 15,
        'isActive': true,
        'isFeatured': true,
        'isOnSale': false,
        'rating': 4.7,
        'reviewCount': 89,
        'tags': ['luxury', 'leather', 'designer'],
        'specifications': {
          'color': 'Brown',
          'material': 'Geniune Leather',
          'dimensions': '30x25x15 cm',
          'weight': '0.8kg',
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'searchKeywords': [
          'coach',
          'handbag',
          'bag',
          'leather',
          'accessories',
          'designer',
          'brown',
        ],
      },
      {
        'name': 'Yoga mat Premium',
        'description':
            'High-quality yoga mat with excellent grip and cushioning. Perfect for yoga, plates, and fitness exercises.',
        'category': 'Sports',
        'subcategory': "Fitness Equipment",
        'price': 39.99,
        'oldPrice': 59.99,
        'currency': 'USD',
        'images': ['assets/images/yoga_mat.jpeg'],
        'primaryImage': 'assets/images/yoga_mat.jpeg',
        'brand': 'Manduka',
        'sku': 'MANDUKA-MAT-001',
        'stock': 25,
        'isActive': true,
        'isFeatured': false,
        'isOnSale': true,
        'rating': 4.4,
        'reviewCount': 156,
        'tags': ['yoga', 'fitness', 'excercise'],
        'specifications': {
          'color': 'Purple',
          'material': 'Natural Rubber',
          'dimensions': '183x61x0.6 cm',
          'weight': '2.5kg',
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'searchKeywords': [
          'yoga',
          'mat',
          'fitness',
          'excercise',
          'sports',
          'manduka',
          'purple',
        ],
      },
    ];

    try {
      // Check if product already exists
      final existingProducts = await _firestore
          .collection('products')
          .limit(1)
          .get();

      if (existingProducts.docs.isEmpty) {
        // Add sample products only if collection is empty
        for (var product in sampleProducts) {
          await _firestore
              .collection('products')
              .add(product);
        }

        print(
          'Sample products added to Firestore successfully!',
        );
      } else {
        print(
          'Products already exist in Firestore. Skipping seed data.',
        );
      }
    } catch (e) {
      print('Error seeding products: $e');
    }
  }
}
