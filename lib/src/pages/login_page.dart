import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/material.dart';
import 'package:app_tiendita/src/utils/constants.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _rememberMe = false;

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Nunito',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'mitienda@tienditas.app',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Nunito',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Ingresa tu contraseña',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          '¿Olvidaste tu contraseña?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.blue,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Recordarme',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          Provider.of<LoginState>(context, listen: false).login();
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
        height: 45.0,
        width: 45.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            () => print('Login with Facebook'),
            AssetImage(
              'assets/logos/facebook.png',
            ),
          ),
          _buildSocialBtn(
            Provider.of<LoginState>(context, listen: false).signInWithGoogle,
            AssetImage(
              'assets/logos/google.png',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => print('Sign Up Button Pressed'),
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
                              image: AssetImage('assets/logos/tienditas.png'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      _buildEmailTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildPasswordTF(),
                      _buildForgotPasswordBtn(),
                      _buildRememberMeCheckbox(),
                      _buildLoginState(),
                      _buildSignInWithText(),
                      _buildSocialBtnRow(),
                      //_buildSignupBtn(),
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
}

// class _LoginPageState extends State<LoginPage> {
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(size.height * .13),
//           child: Container(
//             padding: EdgeInsets.all(28),
//             child: Row(
//               children: <Widget>[
//                 Text(
//                   'Login',
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 28,
//                       fontFamily: 'Nunito',
//                       fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         backgroundColor: azulTema,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.symmetric(vertical: 32, horizontal: 28),
//           child: Column(
//             children: <Widget>[
//               Text(
//                 '¡Bienvenido a Tienditas!',
//                 style: TextStyle(
//                     letterSpacing: 3,
//                     color: azulTema,
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Nunito'),
//               ),
//               SizedBox(height: 65),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Container(
//                     padding: EdgeInsets.symmetric(vertical: 10),
//                     child: Text(
//                       'Correo Electrónico',
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 14,
//                         fontWeight: FontWeight.normal,
//                       ),
//                     ),
//                   ),
//                   _crearEmailInput(),
//                   SizedBox(height: 20),
//                   Container(
//                     padding: EdgeInsets.symmetric(vertical: 10),
//                     child: Text(
//                       'Contraseña',
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 14,
//                         fontWeight: FontWeight.normal,
//                       ),
//                     ),
//                   ),
//                   _crearPasswordInput(),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: <Widget>[
//                       Container(
//                         padding: EdgeInsets.all(16),
//                         child: Text(
//                           '¿Olvidaste tu contraseña?',
//                           style: TextStyle(
//                             fontSize: 13,
//                             fontFamily: 'Nunito',
//                             color: azulOptions,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 38),
//                   Container(
//                     width: double.infinity,
//                     child: FlatButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context, 'new_store');
//                       },
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(35),
//                       ),
//                       color: azulTema,
//                       child: Text(
//                         'Entra',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontFamily: 'Nunito',
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _crearEmailInput() {
//     return Container(
//       decoration: BoxDecoration(
//         color: grisClaroTema,
//         borderRadius: BorderRadius.circular(32),
//       ),
//       child: TextFormField(
//         cursorColor: Colors.black,
//         keyboardType: TextInputType.emailAddress,
//         decoration: new InputDecoration(
//             border: InputBorder.none,
//             focusedBorder: InputBorder.none,
//             enabledBorder: InputBorder.none,
//             errorBorder: InputBorder.none,
//             disabledBorder: InputBorder.none,
//             contentPadding:
//                 EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
//             hintText: 'Escribe tu email',
//             hintStyle: TextStyle(
//               fontFamily: 'Nunito',
//               color: Colors.grey,
//               fontSize: 13,
//             )),
//       ),
//     );
//   }

//   Widget _crearPasswordInput() {
//     return Container(
//       decoration: BoxDecoration(
//         color: grisClaroTema,
//         borderRadius: BorderRadius.circular(32),
//       ),
//       child: TextFormField(
//         obscureText: true,
//         cursorColor: Colors.black,
//         keyboardType: TextInputType.emailAddress,
//         decoration: new InputDecoration(
//             border: InputBorder.none,
//             focusedBorder: InputBorder.none,
//             enabledBorder: InputBorder.none,
//             errorBorder: InputBorder.none,
//             disabledBorder: InputBorder.none,
//             contentPadding:
//                 EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
//             hintText: 'contraseña',
//             hintStyle: TextStyle(
//               fontFamily: 'Nunito',
//               color: Colors.grey,
//               fontSize: 13,
//             )),
//       ),
//     );
//   }
// }
