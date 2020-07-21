import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginState with ChangeNotifier {
  bool _loggedIn = false;
  bool _loading = false;
  String currentUserIdToken;

  //anonimo
  var anonResult;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoggedIn() => _loggedIn;

  bool isLoading() => _loading;

  void login() async {
    _loading = true;
    notifyListeners();

    var user = await _handleAnonSignIn();

    _loading = false;

    if (user != null) {
      var userIdToken = await _getUserIdToken(user);
      print('Sign in with idToken halal: ${userIdToken.token}');
      currentUserIdToken = userIdToken.token;
      _loggedIn = true;
      notifyListeners();
    } else {
      _loggedIn = false;
      notifyListeners();
    }
  }

  void logout() {
    _auth.signOut();
    _loggedIn = false;
    notifyListeners();
  }

  //=============Anonimo
  Future<FirebaseUser> _handleAnonSignIn() async {
    final AuthResult authResult = await _auth.signInAnonymously();
    final FirebaseUser user = authResult.user;
    return user;
  }

  Future<IdTokenResult> _getUserIdToken(user) async {
    final IdTokenResult idTokenResult = await user.getIdToken();
    return idTokenResult;
  }

//  Future<FirebaseUser> _handleSignIn() async {
//    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//    final GoogleSignInAuthentication googleAuth =
//        await googleUser.authentication;
//
//    final AuthCredential credential = GoogleAuthProvider.getCredential(
//      accessToken: googleAuth.accessToken,
//      idToken: googleAuth.idToken,
//    );
//
//    final FirebaseUser user =
//        (await _auth.signInWithCredential(credential)).user;
//    print("signed in " + user.displayName);
//    return user;
//  }
}
