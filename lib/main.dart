import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:unimarket/controller/cart_provider.dart';
import 'package:unimarket/controller/manage_shipment_receipt_provider.dart';
import 'package:unimarket/controller/seller_request_provider.dart';
import 'package:unimarket/controller/transaction_provider.dart';
import 'package:unimarket/screens/auth/login.dart';
import 'package:unimarket/utilities/constants.dart';

import 'controller/auth_provider.dart';
import 'controller/home_provider.dart';
import 'controller/product_provider.dart';
import 'controller/profile_provider.dart';
import 'controller/store_provider.dart';
import 'controller/wishlist_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String baseUrl = 'https://fwmovcrrdkhnyaabpnhy.supabase.co';
  String anonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZ3bW92Y3JyZGtobnlhYWJwbmh5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODE4MDE4MjksImV4cCI6MTk5NzM3NzgyOX0.XypAY3lJI6bhE6AMmBP3r1tvxvySrk35JajkhuDsCcI';
  await Supabase.initialize(
    url: baseUrl,
    anonKey: anonKey,
  );
  // final _authSubscription = supabase.auth.onAuthStateChange.listen((data) {
  //   final AuthChangeEvent event = data.event;
  //   if (event == AuthChangeEvent.passwordRecovery) {
  //     // goToNamed(
  //     //   SetNewPasswordScreen.ROUTE_NAME,
  //     //   replace: true,
  //     // );
  //   }
  // });
  // _authSubscription.cancel();
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
        ChangeNotifierProvider(create: (_) => StoreProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
        ChangeNotifierProvider(create: (_) => SellerRequestProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ManageShipmentReceiptProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UniMarket.',
        theme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          // primaryColor: Colors.blue[900],
          // primarySwatch: Colors.blue[900],
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: const Login(),
      ),
    );
  }
}
