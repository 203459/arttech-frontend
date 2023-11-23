import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:proyecto_c2/features/AuthUsers/Presentation/cubit/auth/auth_cubit.dart';
import 'package:proyecto_c2/features/AuthUsers/Presentation/cubit/credential/credential_cubit.dart';
import 'package:proyecto_c2/features/AuthUsers/Presentation/cubit/user/user_cubit.dart';
import 'package:proyecto_c2/features/AuthUsers/Presentation/pages/home_page.dart';
import 'package:proyecto_c2/features/AuthUsers/Presentation/pages/login_page.dart';
import 'package:proyecto_c2/features/AuthUsers/Presentation/widgets/theme/style.dart';
import 'on_generate_route.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ARTECH",
      debugShowCheckedModeBanner: false,
      color: primaryColor,
      home: SplashScreen(), // Mostrar SplashScreen como la pantalla principal
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simula un tiempo de carga antes de navegar a la pantalla principal
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyAppBody()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo_artech.png', // Reemplaza con la ruta de tu imagen
              width: 200.0, // Ajusta el ancho según tus necesidades
              height: 200.0, // Ajusta la altura según tus necesidades
            ),
            SizedBox(height: 16.0), // Espacio entre la imagen y el texto
            Text(
              'ARTECH',
              style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold, fontFamily: 'Inter',),
            ),
          ],
        ),
      ),
    );
  }
}

class MyAppBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => di.sl<AuthCubit>()..appStarted(),
        ),
        BlocProvider<CredentialCubit>(
          create: (_) => di.sl<CredentialCubit>(),
        ),
        BlocProvider<UserCubit>(
          create: (_) => di.sl<UserCubit>()..getUsers(),
        ),
      ],
      child: MaterialApp(
        title: "ArtTeCH",
        debugShowCheckedModeBanner: false,
        color: primaryColor,
        initialRoute: '/',
        onGenerateRoute: OnGenerateRoute.route,
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return HomePage(uid: authState.uid);
                } else
                  return LoginPage();
              },
            );
          }
        },
      ),
    );
  }
}
