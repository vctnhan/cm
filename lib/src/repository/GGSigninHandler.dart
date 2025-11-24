import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Singleton pattern (tuỳ chọn)
  AuthService._privateConstructor();
  static final AuthService instance = AuthService._privateConstructor();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Login với Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger Google Sign-In
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User cancel
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in với Firebase
      final userCredential =
      await _auth.signInWithCredential(credential);

      print("Signed in as ${userCredential.user?.displayName}");
      return userCredential;
    } catch (e) {
      print("Google Sign-In error: $e");
      return null;
    }
  }

  /// Logout
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    print("User signed out");
  }

  /// Lấy user hiện tại
  User? get currentUser => _auth.currentUser;
}
