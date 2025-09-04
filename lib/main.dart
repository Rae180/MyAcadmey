import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/config/routes/app_router.dart';
import 'package:start/core/locator/service_locator.dart';
import 'package:start/core/utils/services/shared_preferences.dart';
import 'package:start/features/app/my_app.dart';
import 'package:start/features/theme/bloc/theme_bloc.dart';
import 'package:start/features/util/shared_preferences.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.init();
  await SharedPref.init();
  await setupLocator();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
      ],
      child: MainApp(
        appRouter: AppRouter(),
      ),
    ),
  );
}
