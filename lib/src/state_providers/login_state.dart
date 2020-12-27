import 'dart:async';

import 'package:app_tiendita/src/modelos/usuario_tienditas.dart';
import 'package:app_tiendita/src/providers/user/create_user.dart';
import 'package:app_tiendita/src/providers/user/user_tienditas_provider.dart';
import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:progress_dialog/progress_dialog.dart';

class LoginState with ChangeNotifier {
  bool _loggedIn = false;
  bool _isAnon;
  bool _loading = false;
  String currentUserIdToken;
  UserTienditas _userTienditas;

  User _firebaseUser;
  final _firebaseAuth = FirebaseAuth.instance;
  //anonimo
  var anonResult;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User getFireBaseUser() => _firebaseUser;

  UserTienditas getTienditaUser() => _userTienditas;

  bool isLoggedIn() => _loggedIn;

  bool isAnon() => _isAnon;

  bool isLoading() => _loading;

  void login(BuildContext context) async {
    ProgressDialog pr = ProgressDialog(context);
    pr.style(
      message: 'Iniciando sesión...',
      progressWidget: Container(
        height: 400,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
    pr.show();
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
      idTokenRefresher(user);
      pr.hide();
      _loggedIn = true;
      _isAnon = true;
      notifyListeners();
    } else {
      pr.hide();
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

  //=============Anonimo============================================
  Future<User> _handleAnonSignIn() async {
    final UserCredential authResult = await _auth.signInAnonymously();
    final User user = authResult.user;
    return user;
  }

  Future<IdTokenResult> _getUserIdToken(user) async {
    final IdTokenResult idTokenResult = await user.getIdToken();
    return idTokenResult;
  }

  //==============Con=Google=Account==================================
  //Sign in
  signInWithGoogle(BuildContext context) async {
    ProgressDialog pr = ProgressDialog(context, isDismissible: false);

    pr.style(
      message: 'Iniciando sesión...',
      progressWidget: Container(
        height: 400,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
    _loading = true;

    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    if (googleSignInAccount != null) {
      pr.show();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User user = authResult.user;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      assert(user.uid == user.uid);

      IdTokenResult tokenResult = await user.getIdTokenResult();
      currentUserIdToken = tokenResult.token;

      idTokenRefresher(user);
      print('signInWithGoogle succeeded; Sign In As: ${user.displayName}');
      _firebaseUser = user;
      _userTienditas = await UsuarioTienditasProvider()
          .getUserInfo(currentUserIdToken, user.email);

      if (_userTienditas != null) {
        print('=================Detalles de Este Usuario ================');
        print(_userTienditas.address);

        _loggedIn = true;
        _isAnon = false;
        pr.hide();

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
          pr.hide();
          notifyListeners();
        }
      }
    } else {
      print('Sign in stopped do to null account');
    }
  }

  Future<UserTienditas> signInWithApple({List<Scope> scopes = const []}) async {
    //ProgressDialog pr = ProgressDialog(context, isDismissible: false);

    // pr.style(
    //   message: 'Iniciando sesión...',
    //   progressWidget: Container(
    //     height: 400,
    //     child: Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //   ),
    // );
    _loading = true;
    // 1. perform the sign-in request
    final AuthorizationResult result = await AppleSignIn.performRequests([
      AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);
    // 2. check the result
    switch (result.status) {
      case AuthorizationStatus.authorized:
        final appleIdCredential = result.credential;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
          idToken: String.fromCharCodes(appleIdCredential.identityToken),
          accessToken:
              String.fromCharCodes(appleIdCredential.authorizationCode),
        );
        print(result.credential.user);
        final authResult = await _firebaseAuth.signInWithCredential(credential);
        final firebaseUser = authResult.user;
        IdTokenResult tokenResult = await firebaseUser.getIdTokenResult();
        currentUserIdToken = tokenResult.token;
        idTokenRefresher(firebaseUser);
        if (scopes.contains(Scope.fullName)) {
          final displayName =
              '${appleIdCredential.fullName.givenName} ${appleIdCredential.fullName.familyName}';
          print(displayName);
          await firebaseUser.updateProfile(displayName: displayName);
        }
        print('================= Actualizando PhotoURL ================');
        await firebaseUser.updateProfile(
            photoURL:
                "https://tienditas-dev-images.s3.amazonaws.com/tiendas/iconos/tienditas_default.jpg");
        // pr.show();
        print(firebaseUser);
        _firebaseUser = firebaseUser;
        _userTienditas = await UsuarioTienditasProvider()
            .getUserInfo(currentUserIdToken, firebaseUser.email);

        if (_userTienditas != null) {
          print('=================Detalles de Este Usuario ================');
          print(_userTienditas.name);
          print(_userTienditas.userEmail);

          _loggedIn = true;
          _isAnon = false;
          // pr.hide();

          notifyListeners();
        } else {
          print('Creando usuario en DB Tienditas');
          print(_firebaseUser.displayName);
          print(_firebaseUser.email);
          var userCreateResponse = await CreateTienditaUser()
              .createUserTienditas(_firebaseUser, currentUserIdToken);
          print(userCreateResponse.body);
          if (userCreateResponse.statusCode == 200) {
            _userTienditas = await UsuarioTienditasProvider()
                .getUserInfo(currentUserIdToken, firebaseUser.email);

            _loggedIn = true;
            _isAnon = false;
            // pr.hide();
            notifyListeners();
          }
        }
        return _userTienditas;

      case AuthorizationStatus.error:
        throw PlatformException(
          code: 'ERROR_AUTHORIZATION_DENIED',
          message: result.error.toString(),
        );

      case AuthorizationStatus.cancelled:
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      default:
        throw UnimplementedError();
    }
  }

  signInWithFacebook(String result, BuildContext context) async {
    ProgressDialog pr = ProgressDialog(context, isDismissible: false);
    pr.style(
      message: 'Iniciando sesión...',
      progressWidget: Container(
        height: 400,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
    _loading = true;
    pr.show();
    notifyListeners();
    if (result != null) {
      try {
        final facebookAuthCred = FacebookAuthProvider.credential(result);
        final UserCredential authResult =
            await _auth.signInWithCredential(facebookAuthCred);
        final User user = authResult.user;
        final userIdToken = await user.getIdToken();
        currentUserIdToken = userIdToken;
        idTokenRefresher(user);
        print('signInWithFacebook succeeded; Sign In As: ${user.displayName}');
        _firebaseUser = user;
        _userTienditas = await UsuarioTienditasProvider()
            .getUserInfo(currentUserIdToken, user.email);

        if (_userTienditas != null) {
          print('=================Detalles de Este Usuario ================');
          print(_userTienditas.name);
          pr.hide();
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
            pr.hide();
            _loggedIn = true;
            _isAnon = false;
            notifyListeners();
          }
        }
      } catch (e) {
        pr.hide();
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

  void idTokenRefresher(User user) async {
    Timer.periodic(Duration(minutes: 40), (timer) async {
      print(DateTime.now());
      print('+++++++Refreshing user id token++++++++');
      IdTokenResult tokenResult = await user.getIdTokenResult();
      currentUserIdToken = tokenResult.token;
    });
  }
}
