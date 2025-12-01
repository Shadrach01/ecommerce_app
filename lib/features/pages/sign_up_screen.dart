import 'package:ecommerce_app/controllers/auth_controller.dart';
import 'package:ecommerce_app/utils/app_textstyles.dart';
import 'package:ecommerce_app/features/pages/main_screen.dart';
import 'package:ecommerce_app/features/pages/signin_screen.dart';
import 'package:ecommerce_app/features/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController _nameController =
      TextEditingController();

  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
              //back button
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: isDark
                      ? Colors.white
                      : Colors.black,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'Create Account',
                style: AppTextStyles.withColor(
                  AppTextStyles.h1,
                  Theme.of(
                    context,
                  ).textTheme.bodyLarge!.color!,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Signup to get started',
                style: AppTextStyles.withColor(
                  AppTextStyles.bodyLarge,
                  isDark
                      ? Colors.grey[400]!
                      : Colors.grey[600]!,
                ),
              ),

              const SizedBox(height: 40),

              // Full name textfield
              CustomTextfield(
                label: 'Full Name',
                prefixicon: Icons.person_2_outlined,
                keyboardType: TextInputType.emailAddress,
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // email textfield
              CustomTextfield(
                label: 'Email',
                prefixicon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }

                  if (!GetUtils.isEmail(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // password textfield
              CustomTextfield(
                label: 'Password',
                prefixicon: Icons.lock_outline,
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // confirm password textfield
              CustomTextfield(
                label: 'Confirm Password',
                prefixicon: Icons.lock_outline,
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
                controller: _confirmPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 24),

              // signup button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleSignUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(
                      context,
                    ).primaryColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: AppTextStyles.withColor(
                      AppTextStyles.buttonMedium,
                      Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // signin textbutton
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: AppTextStyles.withColor(
                      AppTextStyles.bodyMedium,
                      isDark
                          ? Colors.grey[400]!
                          : Colors.grey[600]!,
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        Get.off(() => SigninScreen()),
                    child: Text(
                      'Sign In',
                      style: AppTextStyles.withColor(
                        AppTextStyles.bodyMedium,
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Sign up button onPressed
  void _handleSignUp() async {
    // validate input fields
    if (_nameController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your name',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // validate input fields
    if (_emailController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (!GetUtils.isEmail(_emailController.text.trim())) {
      Get.snackbar(
        'Error',
        'Please enter a valid email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (_passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (_passwordController.text.length < 6) {
      Get.snackbar(
        'Error',
        'Password must beat least 6 characters long.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (_confirmPasswordController.text !=
        _passwordController.text) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    final AuthController authController =
        Get.find<AuthController>();

    // show loading indicator
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      final result = await authController.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        name: _nameController.text.trim(),
      );

      // close loading dialog
      Get.back();

      if (result.success) {
        Get.snackbar(
          'Success',
          result.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAll(() => const MainScreen());
      } else {
        Get.snackbar(
          'Error',
          result.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      // Close loading dialog
      Get.back();
      Get.snackbar(
        'Error',
        'An unexpected error occured. Please try again',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }
}
