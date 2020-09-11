import 'dart:async';

import 'package:app_tiendita/src/modelos/usuario_tienditas.dart';
import 'package:app_tiendita/src/providers/user/create_user.dart';
import 'package:app_tiendita/src/providers/user/user_tienditas_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginState with ChangeNotifier {
  bool _loggedIn = false;
  bool _isAnon;
  bool _loading = false;
  String currentUserIdToken;
  User _userTienditas;

  FirebaseUser _firebaseUser;

  //anonimo
  var anonResult;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  FirebaseUser getFireBaseUser() => _firebaseUser;

  User getTienditaUser() => _userTienditas;

  bool isLoggedIn() => _loggedIn;

  bool isAnon() => _isAnon;

  bool isLoading() => _loading;

  void login() async {
    _loading = true;
    notifyListeners();

    var user = await _handleAnonSignIn();

    _loading = false;

    if (user != null) {
      var userIdToken = await _getUserIdToken(user);
      print('Sign in with idToken halal: ${userIdToken.token}');
      print('Objeto Token Anonimo Completo: '
          '${userIdToken.toString()}');
      currentUserIdToken = userIdToken.token;
      _loggedIn = true;
      _isAnon = true;
      notifyListeners();
    } else {
      _loggedIn = false;
      notifyListeners();
    }
  }

  void logout() {
    _auth.signOut();
    _loggedIn = false;
    _googleSignIn.signOut();
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
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final AuthResult authResult =
          await _auth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);

      IdTokenResult tokenResult = await user.getIdToken();
      currentUserIdToken = tokenResult.token;
      print('signInWithGoogle succeeded; Sign In As: ${user.displayName}');
      _firebaseUser = user;
      _userTienditas = await UsuarioTienditasProvider()
          .getUserInfo(currentUserIdToken, user.email);

      if (_userTienditas != null) {
        print('=================Detalles de Este Usuario ================');
        print(_userTienditas.address);

        _loggedIn = true;
        _isAnon = false;

        notifyListeners();
      } else {
        print('Tienes que crear el usuario aqui');
        var userCreateResponse = await CreateTienditaUser()
            .createUserTienditas(_firebaseUser, currentUserIdToken);
        print(userCreateResponse.body);
        if (userCreateResponse.statusCode == 200) {
          _userTienditas = await UsuarioTienditasProvider()
              .getUserInfo(currentUserIdToken, user.email);

          _loggedIn = true;
          _isAnon = false;
          notifyListeners();
        }
      }
    } else {
      print('Sign in stopped do to null account');
    }
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
        print('signInWithFacebook succeeded; Sign In As: ${user.displayName}');
        _firebaseUser = user;
        _userTienditas = await UsuarioTienditasProvider()
            .getUserInfo(currentUserIdToken, user.email);

        if (_userTienditas != null) {
          print('=================Detalles de Este Usuario ================');
          print(_userTienditas.name);

          _loggedIn = true;
          _isAnon = false;

          notifyListeners();
        } else {
          print('Tienes que crear el usuario aqui');
          var userCreateResponse = await CreateTienditaUser()
              .createUserTienditas(_firebaseUser, currentUserIdToken);
          print(userCreateResponse.body);
          if (userCreateResponse.statusCode == 200) {
            _userTienditas = await UsuarioTienditasProvider()
                .getUserInfo(currentUserIdToken, user.email);

            _loggedIn = true;
            _isAnon = false;
            notifyListeners();
          }
        }
      } catch (e) {
        _loggedIn = false;
        notifyListeners();
      }
    }
  }

  reloadUserInfo() async {
    _userTienditas = await UsuarioTienditasProvider()
        .getUserInfo(currentUserIdToken, _firebaseUser.email);

    if (_userTienditas != null) {
      print('=================Detalles de Este Usuario ================');
      print(_userTienditas.name);

      _loggedIn = true;
      _isAnon = false;

      notifyListeners();
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
