import 'package:firebase_project/screens/splash/splash_screen.dart';
import 'package:firebase_project/utils/constants/app_routes.dart';
import 'package:firebase_project/utils/local_storage/storage.dart';
import 'package:firebase_project/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/localization/l10n.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => GestureDetector(
        onTap: () {
          if (MediaQuery.of(context).viewInsets.bottom != 0) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            FormBuilderLocalizations.delegate,
          ],
          builder: EasyLoading.init(),
          title: 'Flutter Demo',
          themeMode: ThemeMode.light,
          theme: AAppTheme.lightTheme,
          darkTheme: AAppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: Prefs.getBool("visited_onboarding")
              ? SplashScreen.routeName
              : '/',
          onGenerateRoute: AppRoutes.onGenerateRoute,
        ),
      ),
    );
  }
}
