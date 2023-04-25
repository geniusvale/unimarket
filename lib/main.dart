import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:unimarket/screens/auth/login.dart';
import 'package:unimarket/utilities/constants.dart';

import 'controller/home_provider.dart';
import 'controller/product_provider.dart';
import 'controller/profile_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String baseUrl = 'https://fwmovcrrdkhnyaabpnhy.supabase.co';
  String anonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZ3bW92Y3JyZGtobnlhYWJwbmh5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODE4MDE4MjksImV4cCI6MTk5NzM3NzgyOX0.XypAY3lJI6bhE6AMmBP3r1tvxvySrk35JajkhuDsCcI';
  await Supabase.initialize(
    url: baseUrl,
    anonKey: anonKey,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UniMarket.',
        theme: appTheme,
        home: const Login(),
      ),
    );
  }
}
