import 'package:diamond_app/presentation/constants/app_bloc_provider.dart';
import 'package:diamond_app/presentation/constants/app_routes.dart';
import 'package:diamond_app/presentation/modules/home/result/result_screen.dart';
import 'package:diamond_app/utils/app_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharePref().init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: AppBlocProviders.providers,
          child: MaterialApp(
            navigatorKey: _navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(useMaterial3: true),
            home: ResultScreen(),
            onGenerateRoute: RouteGenerator().getRoute,
          ),
        );
      },
    );
  }
}