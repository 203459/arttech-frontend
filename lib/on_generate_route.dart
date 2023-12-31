import 'package:flutter/material.dart';
import 'package:proyecto_c2/features/AuthUsers/Presentation/pages/forgot_page.dart';
import 'package:proyecto_c2/features/AuthUsers/Presentation/pages/login_page.dart';
import 'package:proyecto_c2/features/AuthUsers/Presentation/pages/registration_page.dart';

import 'package:proyecto_c2/page_const.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case PageConst.loginPage:
        {
          return materialBuilder(
            widget: LoginPage(),
          );
          break;
        }
      case PageConst.forgotPage:
        {
          return materialBuilder(
            widget: ForgetPassPage(),
          );
          break;
        }
      case PageConst.loginPage:
        {
          return materialBuilder(
            widget: LoginPage(),
          );
          break;
        }
      case PageConst.registrationPage:
        {
          return materialBuilder(
            widget: RegistrationPage(),
          );
          break;
        }
      case PageConst.phoneRegistrationPage:
      default:
        return materialBuilder(
          widget: ErrorPage(),
        );
    }
  }
}

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("error"),
      ),
      body: Center(
        child: Text("error"),
      ),
    );
  }
}

MaterialPageRoute materialBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}
