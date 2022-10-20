import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healio/blocs/article/article_bloc.dart';
import 'package:healio/blocs/auth/auth_bloc.dart';
import 'package:healio/blocs/health/health_bloc.dart';
import 'package:healio/blocs/heart_disease/heart_disease_bloc.dart';
import 'package:healio/blocs/page/page_cubit.dart';
import 'package:healio/blocs/user/user_bloc.dart';
import 'package:healio/pages/all_blood_oxygen_page.dart';
import 'package:healio/pages/all_heart_rate_page.dart';
import 'package:healio/pages/article_page.dart';
import 'package:healio/pages/blood_oxygen_information_page.dart';
import 'package:healio/pages/blood_oxygen_page.dart';
import 'package:healio/pages/heart_disease_check_page.dart';
import 'package:healio/pages/heart_rate_information_page.dart';
import 'package:healio/pages/heart_rate_page.dart';
import 'package:healio/pages/main_page.dart';
import 'package:healio/pages/sign_in_page.dart';
import 'package:healio/pages/sign_up_page.dart';
import 'package:healio/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PageCubit(),
        ),
        BlocProvider(
          create: (context) => HealthBloc(),
        ),
        BlocProvider(
          create: (context) => ArticleBloc(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
        BlocProvider(
          create: (context) => HeartDiseaseBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/main': (context) => const MainPage(),
          '/sign-in': (context) => const SignInPage(),
          '/sign-up': (context) => const SignUpPage(),
          '/article': (context) => const ArticlePage(),
          '/heart-rate': (context) => const HeartRatePage(),
          '/all-heart-rate': (context) => const AllHeartRatePage(),
          '/all-blood-oxygen': (context) => const AllBloodOxygenPage(),
          '/heart-rate-information': (context) =>
              const HeartRateInformationPage(),
          '/blood-oxygen': (context) => const BloodOxygenPage(),
          '/blood-oxygen-information': (context) =>
              const BloodOxygenInformationPage(),
          '/heart-disease-check': (context) => const HeartDiseaseCheckPage(),
        },
      ),
    );
  }
}
