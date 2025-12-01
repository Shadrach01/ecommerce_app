import 'package:ecommerce_app/services/firebase_auth_service.dart';
import 'package:ecommerce_app/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final _storage = GetStorage();

  final RxBool _isFirstTime = true.obs;
  final RxBool _isLoggedIn = false.obs;
  final Rx<User?> _user = Rx<User?>(null);
  final RxBool _isLoading = false.obs;
  final Rx<Map<String, dynamic>?> _userDocument =
      Rx<Map<String, dynamic>?>(null);

  bool get isFirstTime => _isFirstTime.value;
  bool get isLoggedIn => _isLoggedIn.value;
  User? get user => _user.value;
  bool get isLoading => _isLoading.value;
  String? get userEmail => _user.value?.email;
  String? get userDisplayName => _user.value?.displayName;
  Map<String, dynamic>? get userDocument =>
      _userDocument.value;
  String? get username =>
      _userDocument.value?['name'] ??
      _user.value?.displayName;
  String? get userPhone =>
      _userDocument.value?['phoneNumber'];
  List<dynamic>? get userAddresses =>
      _userDocument.value?['addresses'];
  Map<String, dynamic>? get userPreferences =>
      _userDocument.value?['preferences'];

  @override
  void onInit() {
    super.onInit();
    _loadInitialState();
    _listenToAuthChanges();
  }

  void _loadInitialState() {
    _isFirstTime.value =
        _storage.read('isFirstTime') ?? true;
    // check firebase auth state instead of local storage
    _user.value = FirebaseAuthService.currentUser;
    _isLoggedIn.value = FirebaseAuthService.isSignedIn;

    // load user document if user is already signed in
    if (_user.value != null) {
      _loadUserDocument(_user.value!.uid);
    }
  }

  // load user document from firestore
  Future<void> _loadUserDocument(String uid) async {
    try {
      final userDoc =
          await FirestoreService.getUserDocument(uid);
      _userDocument.value = userDoc;
    } catch (e) {
      print('Error loading user document');
    }
  }

  void _listenToAuthChanges() {
    FirebaseAuthService.authStateChanges.listen((
      User? user,
    ) {
      _user.value = user;
      _isLoggedIn.value = user != null;
    });
  }

  void setFirstTimeDone() {
    _isFirstTime.value = false;
    _storage.write('isFirstTime', false);
  }

  // sign up with email and password
  Future<AuthResult> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    _isLoading.value = true;

    try {
      final result =
          await FirebaseAuthService.signUpWithEmailAndPassword(
            email: email,
            password: password,
            name: name,
          );

      // if sign-up is successful, load user document immediately
      if (result.success && result.user != null) {
        // Add a small delay to ensure Firesotre docuent is fully created
        await Future.delayed(
          const Duration(milliseconds: 500),
        );
        await _loadUserDocument(result.user!.uid);
      }

      return result;
    } finally {
      _isLoading.value = false;
    }
  }

  // sign in with email and password
  Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    _isLoading.value = true;

    try {
      final result =
          await FirebaseAuthService.signInWithEmnailAndPassword(
            email: email,
            password: password,
          );

      // if sign-in is successful, load user document immediately
      if (result.success && result.user != null) {
        await _loadUserDocument(result.user!.uid);
      }

      return result;
    } finally {
      _isLoading.value = false;
    }
  }

  Future<AuthResult> sendPasswordResetEmail({
    required String email,
  }) async {
    _isLoading.value = true;

    try {
      final result =
          await FirebaseAuthService.sendPasswordResetEmai(
            email: email,
          );

      return result;
    } finally {
      _isLoading.value = false;
    }
  }

  Future<AuthResult> signOut() async {
    _isLoading.value = true;

    try {
      final result = await FirebaseAuthService.signOut();

      return result;
    } finally {
      _isLoading.value = false;
    }
  }

  // update user profile in Firestore
  Future<bool> updateUserProfile({
    String? name,
    String? phoneNumber,
    String? dateOfBirth,
    String? gender,
    String? profileImageUrl,
  }) async {
    if (_user.value == null) return false;

    _isLoading.value = true;

    try {
      final success =
          await FirestoreService.updateUserProfile(
            uid: _user.value!.uid,
            name: name,
            phoneNumber: phoneNumber,
            dateOfBirth: dateOfBirth,
            gender: gender,
            profileImageUrl: profileImageUrl,
          );

      if (success) {
        // Reload user document to get updated data
        await _loadUserDocument(_user.value!.uid);
      }

      return success;
    } finally {
      _isLoading.value = false;
    }
  }

  // Add user Address
  Future<bool> addUserAddress(
    Map<String, dynamic> address,
  ) async {
    if (_user.value == null) return false;

    _isLoading.value = true;

    try {
      final success = await FirestoreService.addUserAddress(
        uid: _user.value!.uid,
        address: address,
      );

      if (success) {
        // Reload user document to get updated data
        await _loadUserDocument(_user.value!.uid);
      }

      return success;
    } finally {
      _isLoading.value = false;
    }
  }

  // Update user preferences
  Future<bool> updateUserPreferences(
    Map<String, dynamic> preferences,
  ) async {
    if (_user.value == null) return false;

    _isLoading.value = true;

    try {
      final success =
          await FirestoreService.updateUserPreferences(
            uid: _user.value!.uid,
            preferences: preferences,
          );

      if (success) {
        // Reload user document to get updated data
        await _loadUserDocument(_user.value!.uid);
      }

      return success;
    } finally {
      _isLoading.value = false;
    }
  }
}
