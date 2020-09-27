import 'package:app_tiendita/src/modelos/categoria_model.dart';
import 'package:app_tiendita/src/modelos/response_model.dart';
import 'package:app_tiendita/src/modelos/usuario_tienditas.dart';
import 'package:app_tiendita/src/providers/category_provider.dart';
import 'package:app_tiendita/src/providers/user/user_tienditas_provider.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditUserProfile extends StatefulWidget {
  EditUserProfile({this.user});

  User user;

  @override
  _EditUserProfileState createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  var response;
  List<String> _categories = [
    'Hubo problemas de conexión, \nfavor revisar su conexión a internet'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35)),
        ),
        centerTitle: true,
        toolbarHeight: 100,
        backgroundColor: azulTema,
        title: Text(
          'Edita tu Perfil',
          style: appBarStyle,
        ),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: SingleChildScrollView(
                child:
                    Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        left: 15, right: 15, top: 5, bottom: 15),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      color: Colors.white,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Número de celular",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Nunito"),
                                ),
                                TextFormField(
                                  initialValue: widget.user.phoneNumber,
                                  onChanged: (String value) {
                                    widget.user.phoneNumber = value;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Ingresar número de celular';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      hintText: '6123-4567'),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Preferencias",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Nunito"),
                                ),
                                FutureBuilder(
                                  future: CategoriesProvider()
                                      .getAllCategories(context),
                                  builder: (BuildContext context, snapshot) {
                                    if (snapshot.hasData) {
                                      CategoryResponseModel resultcategories =
                                          snapshot.data;
                                      var categories =
                                          resultcategories.body.categoryList;
                                      _categories = [];
                                      for (var i = 0;
                                          i < categories.length;
                                          i++) {
                                        _categories
                                            .add(categories[i].categoryName);
                                      }
                                      return DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          hint: Text("Seleccionar categoría"),
                                          onChanged: (newValue) {
                                            if (widget.user.preferences
                                                .contains(newValue)) {
                                              Scaffold.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      '$newValue ya se encuentra en sus preferencias'),
                                                ),
                                              );
                                            } else {
                                              Scaffold.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      '$newValue ha sido añadido a sus preferencias'),
                                                ),
                                              );
                                              setState(() {
                                                widget.user.preferences
                                                    .add(newValue);
                                              });
                                            }
                                          },
                                          items: _categories.map((value) {
                                            return new DropdownMenuItem(
                                              child: new Text(value),
                                              value: value,
                                            );
                                          }).toList(),
                                        ),
                                      );
                                    } else {
                                      return DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          hint: Text("Seleccionar categoría"),
                                          onChanged: (newValue) {
                                            print(newValue);
                                          },
                                          items: _categories.map((value) {
                                            return new DropdownMenuItem(
                                              child: new Text(value),
                                              value: value,
                                            );
                                          }).toList(),
                                        ),
                                      );
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 200,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                      color: Colors.black,
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    shrinkWrap: true,
                                    itemCount: widget.user.preferences.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        child: Row(
                                          children: <Widget>[
                                            UserPreferenceCard(
                                              name: widget
                                                  .user.preferences[index],
                                              onPressed: () {
                                                Scaffold.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        'ha eliminado ${widget.user.preferences[index]} de sus preferencias'),
                                                  ),
                                                );
                                                setState(() {
                                                  widget.user.preferences
                                                      .removeAt(index);
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  alignment: Alignment(0.0, 0.0),
                                  child: RaisedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        if (widget.user.preferences != null) {
                                          response =
                                              await UsuarioTienditasProvider()
                                                  .updateUser(
                                                      Provider.of<LoginState>(
                                                              context)
                                                          .currentUserIdToken,
                                                      widget.user);
                                          Provider.of<LoginState>(context)
                                              .reloadUserInfo();
                                        } else {
                                          Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Debe seleccionar categorías para guardarlas en sus preferencias'),
                                            ),
                                          );
                                        }
                                        if (response.statusCode == 200) {
                                          ResponseTienditasApi
                                              responseTienditasApi =
                                              responseFromJson(response.body);
                                          if (responseTienditasApi.statusCode ==
                                              200) {
                                            print(responseTienditasApi
                                                .body.message);
                                            isLoading = false;
                                            Navigator.of(context).pop();
                                          } else {
                                            print(responseTienditasApi
                                                .body.message);
                                            isLoading = false;
                                          }
                                        } else {
                                          Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Hubo problemas al editar su perfil, \nfavor revisar su conexión a internet'),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    color: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    textColor: Colors.white,
                                    child: Text(
                                      "Guardar",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "Nunito"),
                                    ),
                                  ),
                                )
                              ]),
                        ),
                      ),
                    ),
                  ),
                ]),
              ));
        },
      ),
    );
  }
}

class UserPreferenceCard extends StatelessWidget {
  UserPreferenceCard({this.name, this.onPressed});

  final String name;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(children: <Widget>[
        Text(
          "$name",
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.normal,
              fontFamily: "Nunito"),
        ),
        Spacer(),
        IconButton(
          icon: Icon(Icons.delete_outline),
          iconSize: 28,
          onPressed: onPressed,
        ),
        SizedBox(
          height: 5,
        ),
      ]),
    );
  }
}
