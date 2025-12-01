// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_app/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user
  static User? get currentUser => _auth.currentUser;

  // get current user stream
  static Stream<User?> get authStateChanges =>
      _auth.authStateChanges();

  // sign up with email and password
  static Future<AuthResult> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final UserCredential result = await _auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

      // update display name
      await result.user?.updateDisplayName(name);
      await result.user?.reload();

      // create user document in Firestore and wait for completion
      if (result.user != null) {
        final firestoreSuccess =
            await FirestoreService.createUserDocument(
              uid: result.user!.uid,
              email: email,
              name: name,
            );

        if (!firestoreSuccess) {
          // if Firestore creation fails, we still return success for auth
          // but log the error (user can still use the app)
          print(
            'Warning: Failed to create user document in Firestore',
          );
        }
      }
      return AuthResult(
        success: true,
        user: result.user,
        message: 'Account created successfully',
      );
    } on FirebaseAuthException catch (e) {
      return AuthResult(
        success: false,
        message: _getErrorMessage(e.code),
      );
    } catch (e) {
      return AuthResult(
        success: false,
        message:
            'An unexpected error occured. Please try again.',
      );
    }
  }

  // sign in with email and password
  static Future<AuthResult> signInWithEmnailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential result = await _auth
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          );

      return AuthResult(
        success: true,
        user: result.user,
        message: 'Signed in successfully',
      );
    } on FirebaseAuthException catch (e) {
      return AuthResult(
        success: false,
        message: _getErrorMessage(e.code),
      );
    } catch (e) {
      return AuthResult(
        success: false,
        message:
            'An unexpected error occurred. Please try again',
      );
    }
  }

  // send password reset email
  static Future<AuthResult> sendPasswordResetEmai({
    required String email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return AuthResult(
        success: true,
        message: 'Password reset email sent successfully',
      );
    } on FirebaseAuthException catch (e) {
      return AuthResult(
        success: false,
        message: _getErrorMessage(e.code),
      );
    } catch (e) {
      return AuthResult(
        success: false,
        message:
            'An unexpected error occurred. Please try again',
      );
    }
  }

  // sign out
  static Future<AuthResult> signOut() async {
    try {
      await _auth.signOut();
      return AuthResult(
        success: true,
        message: 'Sign out successfully',
      );
    } catch (e) {
      return AuthResult(
        success: false,
        message: 'Failed to sign out. Please try again.',
      );
    }
  }

  // check if user is signed in
  static bool get isSignedIn => _auth.currentUser != null;

  // Get user email
  static String? get userEmail => _auth.currentUser?.email;

  //  Get user display name
  static String? get userDisplayName =>
      _auth.currentUser?.displayName;

  // Get user id
  static String? get userId => _auth.currentUser?.uid;

  // Helper method to get user-friendly error messages
  static String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No user found with this email address.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'An account already exist with this email address.';
      case 'weak-password':
        return 'Password is too weak. Please choose a stronger password.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many failed attempts. Please try again later.';
      case 'operaion-not-allowed':
        return 'Email/password are not enabled.';
      case 'invalid-credential':
        return 'This account has been disabled.';

      default:
        return 'An error occurred. Please try again later.';
    }
  }
}

class AuthResult {
  final bool success;
  final User? user;
  final String message;

  AuthResult({
    required this.success,
    this.user,
    required this.message,
  });
}
