import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/material.dart';

class MyProfileWidget extends StatelessWidget {
  final String name;
  final String email;
  final String image;
  final String phoneNumber;
  final Function onPressed;

  const MyProfileWidget({
    Key key,
    @required this.name,
    @required this.email,
    @required this.image,
    @required this.phoneNumber,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 0.0,
      ),
      child: Card(
        // clipBehavior: Clip.antiAlias,
        // margin: EdgeInsets.symmetric(
        //   vertical: 8,
        // ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //Circle avatar
              Container(
                margin: EdgeInsets.only(right: 10),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: size.height * .04,
                  child: ClipOval(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FadeInImage(
                            fit: BoxFit.contain,
                            image: NetworkImage(image),
                            placeholder:
                                AssetImage('assets/logos/tienditas.png'),
                          )),
                    ),
                  ),
                ),
              ),
              //Store Details Column
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        name,
                        maxLines: 2,
                        style: userProfileNameCardStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(email, style: userProfileEmailCardStyle),
                      SizedBox(height: 10),
                      Text(
                        phoneNumber,
                        maxLines: 2,
                        style: userProfilePhoneNumberCardStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                      ButtonTheme(
                        height: 17,
                        minWidth: 54,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          color: Colors.green,
                          // padding: EdgeInsets.symmetric(
                          //     horizontal: 8, vertical: 6),
                          child: Text(
                            'Editar',
                            style: userProfileButtonEdit,
                          ),
                          onPressed: onPressed,
                        ),
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
}
