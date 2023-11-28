import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:proyecto_c2/features/AuthUsers/Presentation/widgets/common.dart';
import 'package:proyecto_c2/features/AuthUsers/Presentation/widgets/textfield_container.dart';
import 'package:proyecto_c2/features/AuthUsers/Presentation/widgets/theme/style.dart';
import 'package:proyecto_c2/page_const.dart';

class ForgetPassPage extends StatefulWidget {
  @override
  _ForgetPassPageState createState() => _ForgetPassPageState();
}

class _ForgetPassPageState extends State<ForgetPassPage> {
  TextEditingController _emailController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 32),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 292,
                height: 80,
              ),
              Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '¿Olvidaste tu contraseña?',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFAA5EB7)),
                  )),
              SizedBox(
                height: 50,
              ),
              Text(
                "¡No te preocupes! Solo introduce tu correo electrónico y el equipo de ARTTECH te mandará un enlace para reestablecerla.",
                style: TextStyle(
                  color: Color(0xFF6F6F6F),
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              SizedBox(
                height: 100,
              ),
              TextFieldContainer(
                controller: _emailController,
                prefixIcon: Icons.mail,
                keyboardType: TextInputType.emailAddress,
                hintText: 'Correo electrónico',
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  _submit();
                },
                child: Container(
                  width: 250,
                  height: 150,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 250,
                          height: 75,
                          decoration: ShapeDecoration(
                            color: Color(0xFFAA5EB7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 20,
                        left: 20,
                        top: 13,
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Text(
                            'Enviar correo de reestablecimiento',
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
                )),
              /*InkWell(
                onTap: () {
                  _submit();
                },
                
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                    color: darkPrimaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text(
                    'Enviar correo de reestablecimiento',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        /*fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white*/
                        color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0,
                        ),
                  ),
                ),
              ),*/
              SizedBox(
                height: 27,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¿Recuerdas la información de la cuenta? ',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    InkWell(
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
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    print('Place Holder');
    if (_emailController.text.isEmpty) {
      toast('Enter your email');
      return;
    }
  }
}
