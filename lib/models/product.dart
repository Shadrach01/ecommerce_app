// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  final String name;
  final String category;
  final double price;
  final double? oldPrice;
  final String imageUrl;
  final String description;
  final bool isFavorite;

  Product({
    required this.name,
    required this.category,
    required this.price,
    this.oldPrice,
    required this.imageUrl,
    required this.description,
    this.isFavorite = false,
  });
}

final List<Product> products = [
  Product(
    name: 'Shoes',
    category: 'Footwear',
    price: 69.00,
    oldPrice: 189.00,
    imageUrl: 'assets/images/shoe.jpg',
    description: 'This is the description of the product 1',
  ),

  Product(
    name: 'Laptop',
    category: 'Electronics',
    price: 69.00,
    oldPrice: 189.00,
    imageUrl: 'assets/images/laptop.jpg',
    description: 'This is the description of the product 2',
  ),

  Product(
    name: 'Jordan Shoes',
    category: 'Footwear',
    price: 69.00,
    oldPrice: 189.00,
    imageUrl: 'assets/images/shoe2.jpg',
    description: 'This is the description of the product 3',
  ),

  Product(
    name: 'Puma',
    category: 'Footwear',
    price: 69.00,
    oldPrice: 189.00,
    imageUrl: 'assets/images/shoes2.jpg',
    description: 'This is the description of the product 4',
  ),
];
