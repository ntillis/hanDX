import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:handdx/repositories/auth_repository.dart';
import 'package:handdx/repositories/custom_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

final authControllerExceptionProvider =
    StateProvider<CustomException?>((_) => null);

final authControllerProvider = StateNotifierProvider<AuthController, User?>(
    (ref) => AuthController(ref)..appStarted());


class AuthController extends StateNotifier<User?> {
  final Ref _ref;
  bool notify = false;

  StreamSubscription<User?>? _authStateChangesSubscription;

  AuthController(this._ref) : super(null) {
    _authStateChangesSubscription?.cancel();
    _authStateChangesSubscription = _ref
        .read(authRepositoryProvider)
        .authStateChanges
        .listen((user) => state = user);
  }
  

  void appStarted() async {
    final user = _ref.read(authRepositoryProvider).getCurrentUser();
    if (user == null) {
      await _ref.read(authRepositoryProvider).signInAnonymously();
    }
  }

  Future<void> signInWithEmailPassword(String email, String password) async {
    try {
      await _ref
          .read(authRepositoryProvider)
          .signInWithEmailAndPassword(email, password);
          notify = true;
    } on CustomException catch (e) {
      _ref.read(authControllerExceptionProvider.notifier).state = e;
    }
  }

  Future<void> signInWithBiometrics() async {
    final LocalAuthentication auth = LocalAuthentication();
    bool isBiometricSupported = await auth.isDeviceSupported();
    bool canCheckBiometrics = await auth.canCheckBiometrics;

    bool isAuthenticated = false;
    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {
      try {
        final bool didAuthenticate = await auth.authenticate(
            localizedReason: 'Please authenticate to show account balance',
            options: const AuthenticationOptions(useErrorDialogs: false));
      } on PlatformException catch (e) {
        if (e.code == auth_error.notAvailable) {
          // Add handling of no hardware here.
        } else if (e.code == auth_error.notEnrolled) {
        } else {}
      }
    }
  }

  Future<void> deleteAccount() async {
    await _ref.read(authRepositoryProvider).deleteCurrentUser();
  }

  Future<void> signOut() async {
    await _ref.read(authRepositoryProvider).signOut();
  }

  Future<void> createAccountWithEmailPassword(
      String email, String password) async {
    try {
      await _ref
          .read(authRepositoryProvider)
          .createAccountWithEmailAndPassword(email, password);
    } on CustomException catch (e) {
      _ref.read(authControllerExceptionProvider.notifier).state = e;
    }
  }

  Future<void> forgotPasswordEmail(String email) async {
    try {
      await _ref.read(authRepositoryProvider).forgotPasswordEmail(email);
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  void setNotify(bool n) {
    notify = n;
  }
}

