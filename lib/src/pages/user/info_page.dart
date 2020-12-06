import 'package:app_tiendita/src/modelos/usuario_tienditas.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/providers/info_provider.dart';
import 'package:app_tiendita/src/modelos/questions.dart';


import 'edit_user_address.dart';
class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Future<List<Question>> infoResponse;
  List<Question> listResponse;
  void initState() {
  _getThingsOnStartup().then((value) {
  Provider.of<LoginState>(context).reloadUserInfo();
  });
  super.initState();
  setState(() {
    infoResponse = fetchQuestions(context);

  });
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<LoginState>(context).getTienditaUser();

    return Scaffold(
      body: Column(
        children: <Widget>[
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              height: 340,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF191660),
                    Color(0xFF11249F),
                  ]
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                 SizedBox(height: 50),
                  Expanded(child: Stack(
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/images/help5.png'),
                        width: 230,
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter,
                      ),
                      Positioned(
                          top:30,
                          left: 150,
                          child: Text (
                        "Todo lo que\nnecesitas saber.",
                        style: appBarStyle,
                      )),
                      Container(),
                    ],
                  ))
                ],
              ),
            ),
          ),
          Container(
            child: FutureBuilder(
              future: infoResponse,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                listResponse = snapshot.data;

                return ListView.builder(
                    shrinkWrap: true,
                    //itemCount: listResponse.length + 1,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12.0, bottom: 32.0, left: 16.0, right: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              listResponse[index].question,
                              style: storeSubtitles,),
                            Text(
                              listResponse[index].answer,
                              style: storeItemSubTitleStyle,),
                          ],
                        ),
                        ),
                      );
                    },
                    itemCount: listResponse.length,
                    );
              }else {
                return Container(
                  height: 400,
                  child: Center(
                    child: Text('Nos encontramos haciendo mantenimiento,\npronto volvera a estar disponible esta opcion'),
                  ),
                );
              }
              }
            ),
          )
        ]
      ),
    );


  }
  Future _getThingsOnStartup() async {
    await Future.sync(() => null);
  }

  Future<List<Question>> fetchQuestions(BuildContext context) {
    return InfoProvider().getAllQuestions(context);
  }
}

class MyClipper extends CustomClipper<Path> {
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(size.width/2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    return path;
  }
  bool shouldReclip(CustomClipper<Path> oldClipper){
    return false;
  }
}

