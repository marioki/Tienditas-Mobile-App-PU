import 'package:app_tiendita/src/modelos/faqs_response_model.dart';
import 'package:app_tiendita/src/providers/info_provider.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  Future<FaqsResponseModel> infoResponse;

  @override
  void initState() {
    super.initState();
    setState(() {
      infoResponse = fetchQuestions(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        ClipPath(
          clipper: MyClipper(),
          child: Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color(0xFF191660),
                  Color(0xFF11249F),
                ])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 30),
                Expanded(
                    child: Stack(
                  children: <Widget>[
                    Image(
                      image: AssetImage('assets/images/help5.png'),
                      width: 230,
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
                    ),
                    Positioned(
                        top: 30,
                        left: 150,
                        child: Text(
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
        FutureBuilder(
            future: infoResponse,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                FaqsResponseModel faqsResponse = snapshot.data;
                List<Question> questionList = faqsResponse.body.questions;
                return Expanded(
                  flex: 3,
                  child: ListView.builder(
                    shrinkWrap: false,
                    itemCount: questionList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ExpansionCard(
                          borderRadius: 50,
                          title: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(questionList[index].question,
                                    style: cartTotalPriceStyle)
                              ],
                            ),
                          ),
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 7),
                              child: Text(
                                questionList[index].answer,
                                style: faqsTextContent,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Container(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(),
                );
              }
            })
      ]),
    );
  }

  Future<FaqsResponseModel> fetchQuestions(BuildContext context) {
    return InfoProvider().getFaqs(context);
  }
}

class MyClipper extends CustomClipper<Path> {
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    return path;
  }

  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
