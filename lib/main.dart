import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:scan_track/features/home/view%20model/home_cubit.dart';
import 'package:scan_track/features/home/views/nav_bar_view.dart';
import 'package:scan_track/features/login/view%20model/auth_cubit.dart';
import 'package:scan_track/features/login/views/login_view.dart';
import 'package:scan_track/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();

  await Supabase.initialize(
    url: "https://wldulnnsorcgrzzuylsf.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndsZHVsbm5zb3JjZ3J6enV5bHNmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDAzODQ1NDUsImV4cCI6MjA1NTk2MDU0NX0.Y9mZBw1JWffjTJi9h_0wfxmUb1bTag_de1biCKm2va8",
  );
  return runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const ScanTrackApp(),
    ),
  );
}

class ScanTrackApp extends StatelessWidget {
  const ScanTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
      ],
      child: GetMaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: false,
        home: sharedPreferences!.getBool('isSignedIn') == true
            ? NavBarView()
            : LoginView(),
      ),
    );
  }
}
