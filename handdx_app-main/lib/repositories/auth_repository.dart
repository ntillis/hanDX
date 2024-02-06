import 'package:firebase_auth/firebase_auth.dart';
import 'package:handdx/general_providers.dart';
import 'package:handdx/repositories/custom_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseAuthRepository {
  Stream<User?> get authStateChanges;
  Future<void> signInAnonymously();
  Future<void> signInWithEmailAndPassword(String email, String password);
  User? getCurrentUser();
  Future<void> signOut();
  Future<void> createAccountWithEmailAndPassword(String email, String password);
}

final authRepositoryProvider =
    Provider<AuthRepository>((Ref ref) => AuthRepository(ref));

class AuthRepository implements BaseAuthRepository {
  final Ref _ref;

  AuthRepository(this._ref);

  @override
  Stream<User?> get authStateChanges =>
      _ref.read(firebaseAuthProvider).authStateChanges();

  @override
  Future<void> signInAnonymously() async {
    try {
      await _ref.read(firebaseAuthProvider).signInAnonymously();
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _ref
          .read(firebaseAuthProvider)
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  User? getCurrentUser() {
    try {
      return _ref.read(firebaseAuthProvider).currentUser;
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  Future<void> deleteCurrentUser() async {
    try {
      await _ref.read(firebaseAuthProvider).currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  Future<void> forgotPasswordEmail(String email) async {
    try {
      await _ref
          .read(firebaseAuthProvider)
          .sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _ref.read(firebaseAuthProvider).signOut();
      await _ref
          .read(firebaseAuthProvider)
          .signInAnonymously(); // User must be authenticated in some way to use app
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> createAccountWithEmailAndPassword(
      String email, String password) async {
    try {
      await _ref
          .read(firebaseAuthProvider)
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
