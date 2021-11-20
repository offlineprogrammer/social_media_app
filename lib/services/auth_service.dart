import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';

import 'package:amplify_flutter/amplify.dart';
import '/models/ModelProvider.dart';

import 'datastore_service.dart';

class AuthService {
  DataStoreService _dataStoreService = DataStoreService();
  Future<void> signIn(AuthProvider authProvider) async {
    try {
      await Amplify.Auth.signInWithWebUI(provider: authProvider);
    } catch (e) {
      throw e;
    }
  }

  Future<void> signOut() async {
    try {
      await Amplify.DataStore.clear();
      await Amplify.Auth.signOut();
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  Future<bool> isSignedIn() async {
    AuthSession authSessions = await Amplify.Auth.fetchAuthSession();

    if (authSessions.isSignedIn) {
      try {
        var res = await Amplify.Auth.fetchUserAttributes();
        final _authUserAttribute = res.firstWhere(
          (element) => element.userAttributeKey.toString() == 'email',
        );

        await saveUser(_authUserAttribute.value.toString());
      } on AuthException catch (e) {
        print(e.message);
      }

      //  await getCurrentUser();
      // currentUser.value = await _dataStoreService.getUser(authUser.userId);
    } else {}

    return authSessions.isSignedIn;
  }

  Future<AuthUser> getCurrentUser() async {
    AuthUser authUser = await Amplify.Auth.getCurrentUser();
    return authUser;
  }

  Future<bool> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      Map<String, String> userAttributes = {
        'email': email,
        'preferred_username': email,
      };
      SignUpResult res = await Amplify.Auth.signUp(
        username: email,
        password: password,
        //options: CognitoSignUpOptions(userAttributes: userAttributes)
      );
      return res.isSignUpComplete;
    } on AuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      await signOut();
      SignInResult res = await Amplify.Auth.signIn(
        username: email.trim(),
        password: password.trim(),
      );

      await saveUser(email);

      return res.isSignedIn;
    } catch (e) {
      throw e;
    }
  }

  Future saveUser(String email) async {
    AuthUser authUser = await Amplify.Auth.getCurrentUser();
    User user = User(
        id: authUser.userId,
        username: email,
        createdAt: TemporalDateTime.now(),
        displayname: '',
        isVerified: false);
    print(user);

    await _dataStoreService.saveUser(user);
  }

  Future<bool?> confirmRegisterWithCode(
      String email, String password, String code) async {
    try {
      SignUpResult res = await Amplify.Auth.confirmSignUp(
          username: email, confirmationCode: code);

      if (res.isSignUpComplete) {
        final signInRes = await signInWithEmailAndPassword(email, password);
        await saveUser(email);
        return signInRes;
      }
    } catch (e) {
      throw e;
    }
  }
}
