import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(size.height * .13),
          child: Container(
            padding: EdgeInsets.all(28),
            child: Row(
              children: <Widget>[
                Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: azulTema,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 32, horizontal: 28),
          child: Column(
            children: <Widget>[
              Text(
                '¡Bienvenido a Tienditas!',
                style: TextStyle(
                    letterSpacing: 3,
                    color: azulTema,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito'),
              ),
              SizedBox(height: 65),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Correo Electrónico',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  _crearEmailInput(),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Contraseña',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  _crearPasswordInput(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          '¿Olvidaste tu contraseña?',
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Nunito',
                            color: azulOptions,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 38),
                  Container(
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'home_page');
                      },
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                      color: azulTema,
                      child: Text(
                        'Entra',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Nunito',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearEmailInput() {
    return Container(
      decoration: BoxDecoration(
        color: grisClaroTema,
        borderRadius: BorderRadius.circular(32),
      ),
      child: TextFormField(
        cursorColor: Colors.black,
        keyboardType: TextInputType.emailAddress,
        decoration: new InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding:
                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            hintText: 'Escribe tu email',
            hintStyle: TextStyle(
              fontFamily: 'Nunito',
              color: Colors.grey,
              fontSize: 13,
            )),
      ),
    );
  }

  Widget _crearPasswordInput() {
    return Container(
      decoration: BoxDecoration(
        color: grisClaroTema,
        borderRadius: BorderRadius.circular(32),
      ),
      child: TextFormField(
        obscureText: true,
        cursorColor: Colors.black,
        keyboardType: TextInputType.emailAddress,
        decoration: new InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding:
                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            hintText: 'contraseña',
            hintStyle: TextStyle(
              fontFamily: 'Nunito',
              color: Colors.grey,
              fontSize: 13,
            )),
      ),
    );
  }
}
