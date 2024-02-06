import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:handdx/repositories/auth_repository.dart';
import 'package:handdx/repositories/custom_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:handdx/general_providers.dart';

import 'auth_repository_test.mocks.dart';

@GenerateMocks([FirebaseAuth, UserCredential, User])
void main() {
  group('AuthRepositoryTest - ', () {
    late MockFirebaseAuth firebaseAuth;
    late ProviderContainer container;
    //late WidgetRef ref = M;
    setUp(() {
      firebaseAuth = MockFirebaseAuth();
      container = ProviderContainer(
        overrides: [
          // Example of how you can mock providers
          firebaseAuthProvider.overrideWithValue(firebaseAuth),
        ],
      );
    });
    group('authStateChanges - ', () {
      test('stream should emit User from Stream when not empty', () async {
        // arrange
        final user = MockUser();
        when(firebaseAuth.authStateChanges())
            .thenAnswer((_) => Stream.value(user));
        // act
        final result = container.read(authRepositoryProvider).authStateChanges;
        // assert
        expect(result, emits(user));
      });
      test(
          'stream should emit users from Stream when containing multiple users',
          () async {
        // arrange
        final user1 = MockUser();
        final user2 = MockUser();
        when(firebaseAuth.authStateChanges())
            .thenAnswer((_) => Stream.fromIterable([user1, user2]));
        // act
        final result = container.read(authRepositoryProvider).authStateChanges;
        // assert
        expect(result, emitsInOrder([user1, user2, emitsDone]));
      });
      test('should stream should only emit done when empty', () async {
        // arrange
        when(firebaseAuth.authStateChanges())
            .thenAnswer((_) => const Stream.empty());
        // act
        final result = container.read(authRepositoryProvider).authStateChanges;
        // assert
        expect(result, emitsDone);
      });
    });
    group('signInAnonymously - ', () {
      test('should return when successful', () async {
        // arrange
        when(firebaseAuth.signInAnonymously())
            .thenAnswer((_) => Future(() => MockUserCredential()));
        // act
        container.read(authRepositoryProvider).signInAnonymously();
        // assert
        verify(firebaseAuth.signInAnonymously()).called(1);
      });
      test('should throw CustomException on error', () async {
        // arrange
        when(firebaseAuth.signInAnonymously()).thenThrow(FirebaseAuthException(
            code: 'ERROR', message: 'Something went wrong'));
        // act and assert
        expect(() => container.read(authRepositoryProvider).signInAnonymously(),
            throwsA(isA<CustomException>()));
      });
    });
    group('signInWithEmailAndPassword - ', () {
      test('should return when successful', () async {
        // arrange
        const email = "testEmail";
        const password = "testPassword";
        when(firebaseAuth.signInWithEmailAndPassword(
                email: email, password: password))
            .thenAnswer((_) => Future(() => MockUserCredential()));
        // act
        container
            .read(authRepositoryProvider)
            .signInWithEmailAndPassword(email, password);
        // assert
        verify(firebaseAuth.signInWithEmailAndPassword(
                email: email, password: password))
            .called(1);
      });
    });
    group('signInWithEmailAndPassword - ', () {
      test('should throw CustomException on error', () async {
        // arrange
        const email = "testEmail";
        const password = "testPassword";
        when(firebaseAuth.signInWithEmailAndPassword(
                email: email, password: password))
            .thenThrow(FirebaseAuthException(
                code: 'ERROR', message: 'Something went wrong'));
        // act and assert
        expect(
            () => container
                .read(authRepositoryProvider)
                .signInWithEmailAndPassword(email, password),
            throwsA(isA<CustomException>()));
      });
    });
    group('getCurrentUser - ', () {
      test('should return user when successful', () async {
        // arrange
        final user = MockUser();
        when(firebaseAuth.currentUser).thenReturn(user);
        // act
        final result = container.read(authRepositoryProvider).getCurrentUser();
        // assert
        expect(result, user);
      });
      test('should throw CustomException on error', () async {
        // arrange
        when(firebaseAuth.currentUser).thenThrow(FirebaseAuthException(
            code: 'ERROR', message: 'Something went wrong'));
        // act and assert
        expect(() => container.read(authRepositoryProvider).getCurrentUser(),
            throwsA(isA<CustomException>()));
      });
    });
    group('signOut - ', () {
      test('should return when successful', () async {
        // arrange
        when(firebaseAuth.signInAnonymously()).thenAnswer((_) => Future(() =>
            MockUserCredential())); // signOut signs in user as an anonymous account
        when(firebaseAuth.signOut()).thenAnswer((_) => Future(() => null));
        // act
        container.read(authRepositoryProvider).signOut();
        // assert
        verify(firebaseAuth.signOut()).called(1);
      });
      test('should throw CustomException on error', () async {
        // arrange
        when(firebaseAuth.signInAnonymously())
            .thenAnswer((_) => Future(() => MockUserCredential()));
        when(firebaseAuth.signOut()).thenThrow(FirebaseAuthException(
            code: 'ERROR', message: 'Something went wrong'));
        // act and assert
        expect(() => container.read(authRepositoryProvider).signOut(),
            throwsA(isA<CustomException>()));
      });
    });
    group('createAccountWithEmailAndPassword', () {
      test('should return when successful', () async {
        // arrange
        const email = "testEmail";
        const password = "testPassword";
        when(firebaseAuth.createUserWithEmailAndPassword(
                email: email, password: password))
            .thenAnswer((_) => Future(() => MockUserCredential()));
        // act
        container
            .read(authRepositoryProvider)
            .createAccountWithEmailAndPassword(email, password);
        // assert
        verify(firebaseAuth.createUserWithEmailAndPassword(
                email: email, password: password))
            .called(1);
      });
      test('should throw CustomException on error', () async {
        // arrange
        const email = "testEmail";
        const password = "testPassword";
        when(firebaseAuth.createUserWithEmailAndPassword(
                email: email, password: password))
            .thenThrow(FirebaseAuthException(
                code: 'ERROR', message: 'Something went wrong'));
        // act and assert
        expect(
            () => container
                .read(authRepositoryProvider)
                .createAccountWithEmailAndPassword(email, password),
            throwsA(isA<CustomException>()));
      });
    });
  });
}
