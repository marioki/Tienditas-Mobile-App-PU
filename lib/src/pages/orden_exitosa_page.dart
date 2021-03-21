import 'package:app_tiendita/src/pages/home_page.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OrdenExitosaPage extends StatelessWidget {
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
                  color: Color(0xFFe6e6fa),
                  // gradient: LinearGradient(
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  //   colors: [
                  //     Color(0xFFe6e6fa),
                  //     Color(0xFFc0bdf9),
                  //     Color(0xFFa4a1e5),
                  //   ],
                  //   stops: [0.20, 0.50, 1],
                  // ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '¡Gracias Por Tu Compra!',
                      style: kLabelTitleStyle,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Con esta compra estás apoyando al empredimiento local',
                      style: kLabelSubTitleStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Image(
                      image: AssetImage('assets/images/confirm_purchase.png'),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      elevation: 5.0,
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return HomePage();
                        }));
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'CONTINUAR',
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   mainAxisSize: MainAxisSize.max,
      //   children: [
      //     Icon(
      //       Icons.check_circle_outline,
      //       color: Colors.green,
      //       size: 200,
      //     ),
      //     Text('Compra Realizada!'),
      //     Align(
      //       alignment: Alignment.bottomCenter,
      //       child: RaisedButton(
      //         shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(35)),
      //         color: Colors.green,
      //         child: Text(
      //           'OK',
      //           style: TextStyle(color: Colors.white),
      //         ),
      //         onPressed: () {
      //           Navigator.pushReplacement(context,
      //               MaterialPageRoute(builder: (BuildContext context) {
      //             return HomePage();
      //           }));
      //         },
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
