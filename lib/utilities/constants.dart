import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

final appTheme = ThemeData(
  useMaterial3: true,
  textTheme: GoogleFonts.poppinsTextTheme(),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
  ),
);

const formPadding = EdgeInsets.symmetric(vertical: 0, horizontal: 16);
const formSpacer = SizedBox(width: 16, height: 16);
const borderRadiusStd = BorderRadius.all(Radius.circular(8));
const titleText = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

formDecor({required String hint}) {
  return InputDecoration(
    border: const OutlineInputBorder(borderRadius: borderRadiusStd),
    hintText: hint,
  );
}

// final showDialog = showDialog(context: context, builder: builder)

dialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return const AlertDialog(
        title: Text('Warning!'),
        content: FlutterLogo(),
      );
    },
  );
}

modal(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
          // height: 50,
          );
    },
  );
}
