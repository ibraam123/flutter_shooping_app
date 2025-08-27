import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _firebaseAuth;

  AuthCubit({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        super(AuthInitial());

  /// Sign in with email & password
  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      final UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      emit(AuthSuccess(user: credential.user , 'Account sign-in successfully'));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_mapFirebaseAuthError(e)));
    } catch (e) {
      emit(AuthError('An unexpected error occurred.'));
    }
  }

  /// Register new user with email & password
  Future<void> signUp(String email, String password) async {
    emit(AuthLoading());
    try {
      final UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      emit(AuthSuccess(user: credential.user , "Account created successfully"));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_mapFirebaseAuthError(e)));
    } catch (e) {
      emit(AuthError('An unexpected error occurred.'));
    }
  }

  /// Sign out user
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError('Failed to sign out.'));
    }
  }



  /// Map Firebase errors into friendly messages
  String _mapFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'weak-password':
        return 'Password is too weak.';
      default:
        return e.message ?? 'Authentication error occurred.';
    }
  }
}
