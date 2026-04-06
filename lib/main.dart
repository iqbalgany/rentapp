import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentapp/data/remote_datasources/auth_remote_datasource.dart';
import 'package:rentapp/data/remote_datasources/car_remote_datasource.dart';
import 'package:rentapp/firebase_options.dart';
import 'package:rentapp/presentations/cubits/auth/auth_cubit.dart';
import 'package:rentapp/presentations/cubits/car/car_cubit.dart';
import 'package:rentapp/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(AuthRemoteDatasource())),
        BlocProvider(create: (context) => CarCubit(CarRemoteDatasource())),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
          ),
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.firaSansTextTheme(),
        ),
        routerConfig: AppRoutes.router,
      ),
    );
  }
}
