import 'package:ecommerce_app/controllers/theme_controller.dart';
import 'package:ecommerce_app/features/all_products_screen.dart';
import 'package:ecommerce_app/features/cart_screen.dart';
import 'package:ecommerce_app/features/widgets/category_chips.dart';
import 'package:ecommerce_app/features/widgets/custom_search_bar.dart';
import 'package:ecommerce_app/features/widgets/product_grid.dart';
import 'package:ecommerce_app/features/widgets/sale_banner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(
        context,
      ).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // header section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(
                      'assets/images/avatar.jpg',
                    ),
                  ),

                  const SizedBox(width: 12),

                  const Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello Alex',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),

                      Text(
                        'Good Morning',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // spacer
                  const Spacer(),

                  // notifications icon
                  IconButton(
                    onPressed: () =>
                        Get.to(() => NotificationsScreen()),
                    icon: const Icon(
                      Icons.notifications_outlined,
                    ),
                  ),

                  // cart button
                  IconButton(
                    onPressed: () =>
                        Get.to(() => CartScreen()),
                    icon: const Icon(
                      Icons.shopping_bag_outlined,
                    ),
                  ),

                  // theme button
                  GetBuilder<ThemeController>(
                    builder: (controller) => IconButton(
                      onPressed: () =>
                          controller.toggleTheme(),
                      icon: Icon(
                        controller.isDarkMode
                            ? Icons.light_mode
                            : Icons.dark_mode,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // search bar
            const CustomSearchBar(),

            //category chips
            const CategoryChips(),

            // sale banner
            const SaleBanner(),

            //popular products
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Products',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  GestureDetector(
                    onTap: () => Get.to(
                      () => const AllProductsScreen(),
                    ),
                    child: Text(
                      'See All',
                      style: TextStyle(
                        color: Theme.of(
                          context,
                        ).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // product Grid
            const Expanded(child: ProductGrid()),
          ],
        ),
      ),
    );
  }
}
