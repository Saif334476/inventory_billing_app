import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../services/firestore/firestore_service.dart';


final authControllerProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController();
});

class AuthState {
  final String email;
  final String password;
  final String confirmPassword;

  AuthState({
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
  });
}

class AuthController extends StateNotifier<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
    clientId: 'YOUR_CLIENT_ID',
  );

  AuthController() : super(AuthState());

  void updateEmail(String text) {
    state = AuthState(email: text, password: state.password, confirmPassword: state.confirmPassword);
  }

  void updatePassword(String text) {
    state = AuthState(email: state.email, password: text, confirmPassword: state.confirmPassword);
  }

  void updateConfirmPassword(String text) {
    state = AuthState(email: state.email, password: state.password, confirmPassword: text);
  }

  void signup() async {
    if (state.password != state.confirmPassword) {
      print('Passwords do not match');
      return;
    }

    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );

      if (userCredential.user != null) {
        await _firestoreService.storeUserData(
          uid: userCredential.user!.uid,
          email: state.email,
        );

        print('User signed up successfully');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
  void signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        if (userCredential.user != null) {
          final String? email = userCredential.user!.email;
          if (email != null) {
            await _firestoreService.storeUserData(
              uid: userCredential.user!.uid,
              email: email,
            );
            print('User signed in with Google successfully');
          } else {
            print('Error: User email is null');
          }
        } else {
          print('Error: User credential is null');
        }
      } else {
        print('Error: Google sign-in failed');
      }
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Exception: ${e.message}');
    } catch (e) {
      print('Error: $e');
    }
  }

}