import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/utils/constants.dart';
import 'package:apple_sign_in/apple_sign_in_button.dart';
import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:flutter/material.dart' hide ButtonStyle;
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'apple_sign_in_available.dart';
import 'custom_web_view.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _rememberMe = false;

  Widget _buildFacebookBtn(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 8),
        elevation: 5.0,
        onPressed: () {
          loginWithFacebook();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildSocialBtn(
              () => print('Login with Facebook'),
              AssetImage(
                'assets/logos/facebook.png',
              ),
            ),
            Text(
              'FACEBOOK',
              style: TextStyle(
                color: azulTema,
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Nunito',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoogleBtn() {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 8),
        elevation: 5.0,
        onPressed: () {
          Provider.of<LoginState>(context, listen: false)
              .signInWithGoogle(context);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildSocialBtn(
              () => print('Login with Facebook'),
              AssetImage(
                'assets/logos/google.png',
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'GOOGLE',
              style: TextStyle(
                color: azulTema,
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Nunito',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30.0,
        width: 30.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildAnonymous() {
    ProgressDialog pr = ProgressDialog(context);
    pr.style(
        message: 'Iniciando sesión...',
        progressWidget: Container(
          height: 400,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ));
    return GestureDetector(
      onTap: () {
        Provider.of<LoginState>(context, listen: false).login(context);
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Ingresar como invitado',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signInWithApple(BuildContext context) async {
    try {
      final authService = Provider.of<LoginState>(context, listen: false);
      final user = await authService.signInWithApple(context);
      print('User Tienditas Name: ${user.name}');
      print('User Tienditas Email: ${user.userEmail}');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appleSignInAvailable =
        Provider.of<AppleSignInAvailable>(context, listen: false);
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFa4a1e5),
                      Color(0xFF817cc3),
                      Color(0xFF5f58a1),
                      Color(0xFF3d3680),
                      azulTema
                    ],
                    stops: [0.1, 0.4, 0.7, 0.8, 0.9],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image(
                      image: AssetImage('assets/logos/logoTienditas.png'),
                    ),
                    Image(
                      image: AssetImage('assets/images/welcomeImage.png'),
                    ),
                    Text(
                      'Ingresa con:',
                      style: kLabelStyle,
                    ),
                    // _buildFacebookBtn(context),
                    if (appleSignInAvailable.isAvailable)
                      AppleSignInButton(
                        style: ButtonStyle.white,
                        type: ButtonType.signIn,
                        onPressed: () => _signInWithApple(context),
                      ),
                    _buildGoogleBtn(),
                    _buildAnonymous(),
                    FutureBuilder(
                      future: getVersionNumber(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            'v${snapshot.data}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.normal,
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  loginWithFacebook() async {
    String facebookId = "382658952699555";
    String facebookRedirectUrl =
        "https://www.facebook.com/connect/login_success.html";
    String result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CustomWebView(
                selectedUrl:
                    'https://www.facebook.com/dialog/oauth?client_id=$facebookId&redirect_uri=$facebookRedirectUrl&response_type=token&scope=email,public_profile,',
              ),
          maintainState: true),
    );
    Provider.of<LoginState>(context, listen: false)
        .signInWithFacebook(result, context);
  }

  Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;

    return version;
  }
}
