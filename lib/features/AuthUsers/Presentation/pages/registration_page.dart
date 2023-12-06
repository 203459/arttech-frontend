import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_c2/features/AuthUsers/Data/datasources/storage_provider.dart';
import 'package:proyecto_c2/features/AuthUsers/Domain/entities/user_entity.dart';
import 'package:proyecto_c2/features/AuthUsers/Presentation/cubit/auth/auth_cubit.dart';
import 'package:proyecto_c2/features/AuthUsers/Presentation/cubit/credential/credential_cubit.dart';
import 'package:proyecto_c2/features/AuthUsers/Presentation/widgets/common.dart';
import 'package:proyecto_c2/features/AuthUsers/Presentation/widgets/profile_widget.dart';
import 'package:proyecto_c2/features/AuthUsers/Presentation/widgets/textfield_container.dart';
import 'package:proyecto_c2/features/AuthUsers/Presentation/widgets/theme/style.dart';
import 'package:proyecto_c2/page_const.dart';
import 'home_page.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _examTypeController = TextEditingController();
  TextEditingController _passwordAgainController = TextEditingController();
  TextEditingController _numberController = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  //int _selectGender = -1;
  //int _selectExamType = -1;
  bool _isShowPassword = true;

  //File? _image;
  //String? _profileUrl;

  /*Future getImage() async {
    try {
      final pickedFile =
          await ImagePicker.platform.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          StorageProviderRemoteDataSource.uploadFile(file: _image!)
              .then((value) {
            print("profileUrl");
            setState(() {
              _profileUrl = value;
            });
          });
        } else {
          print('Sin imagen.');
        }
      });
    } catch (e) {
      toast("error $e");
    }
  }*/

  void dispose() {
    _examTypeController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _passwordAgainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      body: BlocConsumer<CredentialCubit, CredentialState>(
        listener: (context, credentialState) {
          if (credentialState is CredentialSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }
          if (credentialState is CredentialFailure) {
            snackBarNetwork(
                msg: "Correo inválido, revise por favor.",
                scaffoldState: _scaffoldState);
          }
        },
        builder: (context, credentialState) {
          if (credentialState is CredentialLoading) {
            return Scaffold(
              body: loadingIndicatorProgressBar(),
            );
          }
          if (credentialState is CredentialSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return HomePage(
                    id: authState.id,
                  );
                } else {
                  print("No autentificado");
                  return _bodyWidget();
                }
              },
            );
          }

          return _bodyWidget();
        },
      ),
    );
  }

  Widget _bodyWidget() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 35),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 292,
              height: 60,
            ),
            Container(
              child: Text(
                'Registro',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFAA5EB7),
                  fontSize: 36,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 2,
              endIndent: 15,
              indent: 15,
            ),
            SizedBox(
              height: 30,
            ),
            /*GestureDetector(
              onTap: () async {
                getImage();
              },
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(214, 241, 246, 1),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child: profileWidget(image: _image)),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Agregar una foto de perfil',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: darkPrimaryColor),
                  ),
                ],
              ),
            ),*/
            TextFieldContainer(
              controller: _usernameController,
              keyboardType: TextInputType.text,
              hintText: 'Nombre de usuario',
              prefixIcon: Icons.person,
            ),
            SizedBox(
              height: 30,
            ),
            TextFieldContainer(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              hintText: 'Correo electrónico',
              prefixIcon: Icons.mail,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 44,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: color747480.withOpacity(.2),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextField(
                obscureText: _isShowPassword,
                controller: _passwordController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Contraseña',
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isShowPassword =
                                _isShowPassword == false ? true : false;
                          });
                        },
                        child: Icon(_isShowPassword == false
                            ? Icons.remove_red_eye
                            : Icons.panorama_fish_eye))),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 44,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: color747480.withOpacity(.2),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextField(
                obscureText: _isShowPassword,
                controller: _passwordAgainController,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                    hintText: 'Contraseña (Repetir)',
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isShowPassword =
                                _isShowPassword == false ? true : false;
                          });
                        },
                        child: Icon(_isShowPassword == false
                            ? Icons.remove_red_eye
                            : Icons.panorama_fish_eye))),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            /* GestureDetector(
              onTap: _modalBottomSheetDate,
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                    color: color747480.withOpacity(.2),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: AbsorbPointer(
                  child: TextField(
                    controller: _dobController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.date_range),
                      hintText: 'Fecha de nacimiento',
                      suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ), 
            SizedBox(
              height: 10,
            ),*/
            
            /* GestureDetector(
              onTap: _genderModalBottomSheetMenu,
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                    color: color747480.withOpacity(.2),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: AbsorbPointer(
                  child: TextField(
                    controller: _genderController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.people_alt),
                      hintText: 'Género',
                      suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ), */
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                _submitSignUp();
              },
              child: Container(
                  width: 250,
                  height: 50,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 250,
                          height: 50,
                          decoration: ShapeDecoration(
                            color: Color(0xFFAA5EB7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 58.96,
                        top: 13,
                        child: SizedBox(
                          width: 139.17,
                          height: 25,
                          child: Text(
                            'Registrarme',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '¿Ya tienes cuenta? ',
                    style: TextStyle(color: Color(0xFF6F6F6F), fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, PageConst.loginPage, (route) => false);
                    },
                    child: Text(
                      'Inicia sesión',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFAA5EB7)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 150,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Al hacer click en "registrarme", aceptas ',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF6F6F6F)),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'los ',
                    style: TextStyle(
                        color: Color(0xFF6F6F6F),
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'términos y condiciones ',
                    style: TextStyle(
                        color: Color.fromARGB(255, 18, 148, 218),
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'de uso.',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF6F6F6F)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /* void _genderModalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Container(
                height: 300.0,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.close)),
                          Text(
                            'Género',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          Text('')
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 1,
                      height: 1,
                    ),
                    /* InkWell(
                      onTap: () {
                        setState(() {
                          _selectGender = 0;
                          _genderController.value =
                              TextEditingValue(text: "Femenino");
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 18, bottom: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Femenino',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                )),
                            Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: _selectGender == 0
                                    ? Colors.orange
                                    : Colors.transparent,
                                border: Border.all(color: Colors.black),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      height: 1,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectGender = 1;
                          _genderController.value =
                              TextEditingValue(text: "Masculino");
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 18, bottom: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Masculino',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                )),
                            Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: _selectGender == 1
                                    ? Colors.orange
                                    : Colors.transparent,
                                border: Border.all(color: Colors.black),
                              ),
                            )
                          ],
                        ),
                      ),
                    ), */
                    Divider(
                      thickness: 1,
                      height: 1,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectGender = 2;
                          _genderController.value =
                              TextEditingValue(text: "Otro");
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 18, bottom: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Otro',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                )),
                            Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: _selectGender == 2
                                    ? Colors.orange
                                    : Colors.transparent,
                                border: Border.all(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      height: 1,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                  ],
                ),
              );
            },
          );
        });
  } */

  /* void _modalBottomSheetDate() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
              height: 300.0,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Column(
                children: [
                  Container(
                    child: Container(
                      padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.close)),
                          Text(
                            'Fecha de nacimiento',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.done)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: CupertinoDatePicker(
                      use24hFormat: false,
                      mode: CupertinoDatePickerMode.date,
                      maximumDate: DateTime(DateTime.now().year + 1, 1, 1),
                      minimumDate: DateTime(1950, 1, 1),
                      onDateTimeChanged: (dateTime) {
                        print(dateTime);
                        setState(() {
                          _dobController.value = TextEditingValue(
                              text: DateFormat.yMMMMEEEEd().format(dateTime));
                        });
                      },
                    ),
                  ),
                ],
              ));
        });
  } */

  _submitSignUp() {
    if (_emailController.text.isEmpty) {
      toast('Ingresa un correo electronico');
      return;
    }
    if (_passwordController.text.isEmpty) {
      toast('Ingresa una contraseña');
      return;
    }

    if (_passwordAgainController.text.isEmpty) {
      toast('Repite la contraseña');
      return;
    }

    if (_passwordController.text == _passwordAgainController.text) {
    } else {
      toast("Ambas contraseñas deben ser iguales");
      return;
    }

    BlocProvider.of<CredentialCubit>(context).signUpSubmit(
      user: UserEntity(
        id: -1,
        email: _emailController.text,
        //profileUrl: _profileUrl!,
        password: _passwordController.text,
        isOnline: false,
        status: "Hola! Estoy usando esta aplicación :)",
      ),
    );
  }
}
