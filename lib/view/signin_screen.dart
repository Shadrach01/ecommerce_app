import 'package:ecommerce_app/utils/app_textstyles.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                'Welcome Back!',
                style: AppTextStyles.withColor(
                  AppTextStyles.h1,
                  Theme.of(
                    context,
                  ).textTheme.bodyLarge!.color!,
                ),
              ),

              const SizedBox(height: 8),
              Text(
                'Sign in to continue shopping',
                style: AppTextStyles.withColor(
                  AppTextStyles.bodyLarge,
                  isDark
                      ? Colors.grey[400]!
                      : Colors.grey[600]!,
                ),
              ),

              const SizedBox(height: 40),

              // email textfield
            ],
          ),
        ),
      ),
    );
  }
}
