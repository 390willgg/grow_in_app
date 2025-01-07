import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grow_in_app/error/exceptions.dart';

import '../models/sign_in/sign_in_model.dart';
import '../models/sign_up/sign_up_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserCredential> signIn(SignInModel signIn);

  Future<UserCredential> signUp(SignUpModel signUp);

  Future<UserCredential> googleAuthentication();

  Future<Unit> verifyEmail();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserCredential> signIn(SignInModel signIn) async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: signIn.email,
        password: signIn.password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ExistedAccountException(message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordException(
            message: 'Wrong password provided for that user.');
      } else {
        throw ServerException(
          message: e.message ?? 'An error occurred in server connection',
        );
      }
    }
  }

  @override
  Future<UserCredential> signUp(SignUpModel signUp) async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      return await firebaseAuth.createUserWithEmailAndPassword(
        email: signUp.email,
        password: signUp.password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordException(
            message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw ExistedAccountException(
            message: 'The account already exists for that email.');
      } else {
        throw ServerException(
          message: e.message ?? 'An error occurred in server connection',
        );
      }
    }
  }

  @override
  Future<UserCredential> googleAuthentication() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.currentUser?.reload();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    try {
      return await firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      throw ServerException(
        message: e.toString(),
      );
    }
  }

  @override
  Future<Unit> verifyEmail() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final user = firebaseAuth.currentUser;
    if (user != null) {
      try {
        await user.reload();
        await user.sendEmailVerification();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'too-many-requests') {
          throw TooManyRequestException(
              message: 'Too many requests. Try again later.');
        } else {
          throw ServerException(
            message: e.message ?? 'An error occurred in server connection',
          );
        }
      } catch (e) {
        throw ServerException(
          message: e.toString(),
        );
      }
    } else {
      throw NoUserException(message: 'No user found');
    }
    return Future.value(unit);
  }
}
