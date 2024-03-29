import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:unimarket/env/env.dart';
import 'package:xendit/xendit.dart';
import 'package:dio/dio.dart';

final supabase = Supabase.instance.client;
final dio = Dio();
final xendit = Xendit(
  apiKey: Env.xndDevKey,
);
const rajaOngkirKey = Env.rajaOngkirKey;

Map<String, dynamic> templateParams(
    {String? namaPembeli, namaPenjual, emailPembeli, emailPenjual}) {
  return {
    'from_name': namaPembeli,
    'to_name': namaPenjual,
    'message': 'Silahkan Cek Aplikasi Anda Untuk Melihat Detail Pesanan',
    'penjual_email': emailPenjual,
    'pembeli_email': emailPembeli,
  };
}

Map<String, dynamic> adminShipmentTemplateParams(
    {String? namaPembeli, namaPenjual, emailPembeli, emailAdmin}) {
  return {
    'from_name': namaPembeli,
    'to_name': namaPenjual,
    'message':
        'Silahkan Cek Aplikasi Anda Untuk Melihat Detail Pesanan Untuk Dikirim',
    'admin_email': emailAdmin,
    'pembeli_email': emailPembeli,
  };
}

const formPadding = EdgeInsets.symmetric(vertical: 0, horizontal: 16);
const formSpacer = SizedBox(width: 16, height: 16);
const borderRadiusStd = BorderRadius.all(Radius.circular(8));
const titleText = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

const loadingIndicator = Center(child: CircularProgressIndicator());

final numberCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');

String capitalizeOnlyFirstLetter(String text) {
  if (text.trim().isEmpty) return "";

  return "${text[0].toUpperCase()}${text.substring(1)}";
}

hargaValidator(String value) {
  final n = int.tryParse(value);

  if (value.isEmpty) {
    return 'Harga Tidak Boleh Kosong';
  } else if (n == null || n < 10000) {
    return 'Harga Minimal 10,000';
  } else {
    return null;
  }
}

final handleBar = Container(
  width: 50,
  height: 5,
  decoration: const BoxDecoration(
    borderRadius: borderRadiusStd,
    color: Colors.grey,
  ),
);

formDecor({required String hint, label, labelText}) {
  return InputDecoration(
    border: const OutlineInputBorder(borderRadius: borderRadiusStd),
    hintText: hint,
    label: label == null ? null : Text('$label'),
    // labelText: labelText,
  );
}

final appBarz = AppBar();

final giantHeader = SizedBox(
  width: 400,
  height: 250,
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        width: 150,
        height: 130,
        child: Image.asset(
          'assets/icons/unimarketLogo.png',
          fit: BoxFit.cover,
        ),
      ),
      const Text('by'),
      formSpacer,
      formSpacer,
      Image.asset('assets/images/ucic.png', width: 100),
    ],
  ),
);

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
