import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/common/models/usermodel.dart';
import 'package:todo/common/routes/routes.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/features/auth/controllers/user_controller.dart';
import 'package:todo/features/onboarding/screens/onboarding.dart';
import 'package:todo/features/todo/screens/homepage.dart';
import 'package:todo/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  static final defaultLightColorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.blue);
  static final defaultDarkColorScheme = ColorScheme.fromSwatch(
      brightness: Brightness.dark, primarySwatch: Colors.blue);

  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(userProviedr.notifier).refresh();
    List<UserModel> users = ref.watch(userProviedr);
    return ScreenUtilInit(
      useInheritedMediaQuery: true, // avoid overlay of keyboard in textfiels
      designSize: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height,
      ),
      minTextAdapt: true,
      builder: (context, child) {
        return DynamicColorBuilder(
          builder: (lightColorScheme, darkColorScheme) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'TaskTrove',
              theme: ThemeData(
                scaffoldBackgroundColor: AppConstants.kbkDark,
                colorScheme: lightColorScheme ?? defaultLightColorScheme,
                useMaterial3: true,
              ),
              darkTheme: ThemeData(
                scaffoldBackgroundColor: AppConstants.kbkDark,
                colorScheme: darkColorScheme ?? defaultDarkColorScheme,
                useMaterial3: true,
              ),
              onGenerateRoute: Routes.onGenerateRoute,
              themeMode: ThemeMode.dark,
              home: users.isEmpty ? const OnBoarding() : const HomePage(),
            );
          },
        );
      },
    );
  }
}
