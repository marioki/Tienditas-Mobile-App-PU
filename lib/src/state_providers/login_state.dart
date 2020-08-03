import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginState with ChangeNotifier {
  bool _loggedIn = false;
  bool _loading = false;
  String currentUserIdToken;

  //anonimo
  var anonResult;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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

  //==============ConGoogleAccount
  //Sign in
  signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    IdTokenResult tokenResult = await user.getIdToken();
    currentUserIdToken = tokenResult.token;
    print('signInWithGoogle succeeded; Sign In As: ${user.displayName}');
    print(currentUserIdToken);
    _loggedIn = true;

    notifyListeners();
  }

  signInWithFacebook(String result) async {
    _loading = true;
    notifyListeners();
    if (result != null) {
      try {
        final facebookAuthCred =
            FacebookAuthProvider.getCredential(accessToken: result);
        final AuthResult authResult =
            await _auth.signInWithCredential(facebookAuthCred);
        final FirebaseUser user = authResult.user;
        final userIdToken = await user.getIdToken();
        currentUserIdToken = userIdToken.token;
        print('signInWithFacebook succeeded');
        _loggedIn = true;
        notifyListeners();
      } catch (e) {
        _loggedIn = false;
        notifyListeners();
      }
    }
  }

  //Sign out
  void signOutGoogle() async {
    await _googleSignIn.signOut();

    print("User Sign Out");
  }

//======Old Code============
  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    return user;
  }
}
