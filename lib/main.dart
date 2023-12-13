import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_nd/data/repository/authen_repository.dart';
import 'package:flutter_nd/data/repository/dataproduct_repository.dart';
import 'package:flutter_nd/data/repository/authen_repos.dart';
import 'package:flutter_nd/generated/codegen_loader.g.dart';
import 'package:flutter_nd/presentation/blocs/authen_bloc/authen_bloc.dart';
import 'package:flutter_nd/presentation/blocs/bloc/dataproduct_bloc.dart';
import 'package:flutter_nd/presentation/pages/splash_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('kk'), Locale('ru')],
      path: 'assets/translations', 
      fallbackLocale: Locale('en'),
      assetLoader: CodegenLoader(),
      child: MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository = AuthRepository(AuthService());
  final Dio dio = Dio(); 

  MyApp() {
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(authRepository),
          ),
          BlocProvider(
            create: (context) => DataProductBloc(apiService: CosmeticApiService(dio)), 
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: SplashScreen(),
        ),
     ),
     );
  }
}