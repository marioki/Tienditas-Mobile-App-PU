import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

import 'custom_web_view.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _rememberMe = false;

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          Provider.of<LoginState>(context, listen: false).login(context);
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: azulTema,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Nunito',
          ),
        ),
      ),
    );
  }

  Widget _buildFacebookBtn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          loginWithFacebook();
        },
        padding: EdgeInsets.all(15.0),
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
            SizedBox(
              width: 16,
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
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          Provider.of<LoginState>(context, listen: false)
              .signInWithGoogle(context);
        },
        padding: EdgeInsets.all(15.0),
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
              width: 16,
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

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- O -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Regístrate con',
          style: kLabelStyle,
        ),
      ],
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

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        Provider.of<LoginState>(context, listen: false).login(context);
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '¿No tienes una cuenta?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
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

  @override
  Widget build(BuildContext context) {
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
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 32.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 16.0),
                      SizedBox(
                        height: 100.0,
                        width: 250.0,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/logos/logoTienditas.png'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      SizedBox(
                        height: 250.0,
                        width: 300.0,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/welcomeImage.png'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        'Ingresa con:',
                        style: kLabelStyle,
                      ),
                      _buildFacebookBtn(context),
                      Text(
                        '- O -',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      _buildGoogleBtn(),
                      _buildAnonymous(),
                      SizedBox(
                        height: 10,
                      ),
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginState() {
    return Consumer<LoginState>(
      builder: (BuildContext context, LoginState value, Widget child) {
        if (value.isLoading()) {
          return Column(children: <Widget>[
            SizedBox(
              height: 16,
            ),
            SizedBox(
              child: CircularProgressIndicator(),
              height: 40.0,
              width: 40.0,
            ),
            SizedBox(
              height: 32,
            )
          ]);
        } else {
          return child;
        }
      },
      child: _buildLoginBtn(),
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
