import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unimarket/models/address/city_model.dart';
import 'package:unimarket/utilities/widgets.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../controller/profile_provider.dart';
import '../../utilities/constants.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController nimC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  TextEditingController? cityIdC = TextEditingController();
  TextEditingController? cityNameC = TextEditingController();
  TextEditingController? cityTypeC = TextEditingController();
  bool? isLoading;

  @override
  void initState() {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    usernameC.text = profileProvider.loggedUserData!.username!;
    emailC.text = profileProvider.loggedUserData!.email!;
    nimC.text = profileProvider.loggedUserData!.nim ?? '';
    phoneC.text = profileProvider.loggedUserData!.phone ?? '';
    addressC.text = profileProvider.loggedUserData!.address?.alamat ?? '';
    cityIdC?.text = profileProvider.loggedUserData!.address?.city_id ?? '';
    cityNameC?.text = profileProvider.loggedUserData!.address?.city_name ?? '';
    cityTypeC?.text = profileProvider.loggedUserData!.address?.type ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Username'),
              TextFormField(
                controller: usernameC,
                decoration: formDecor(hint: 'Username'),
              ),
              formSpacer,
              const Text('Email'),
              TextFormField(
                enabled: false,
                controller: emailC,
                decoration: formDecor(hint: 'Email'),
                validator: (value) => !EmailValidator.validate(value!)
                    ? 'Format Email Salah!'
                    : null,
              ),
              formSpacer,
              const Text('NIM'), //SHOULD DISABLED
              TextFormField(
                enabled: false,
                controller: nimC,
                style: const TextStyle(color: Colors.grey),
                decoration: formDecor(hint: 'NIM'),
              ),
              formSpacer,
              const Text('Nomor HP'),
              TextFormField(
                controller: phoneC,
                decoration: formDecor(hint: 'Nomor HP'),
                validator: (value) {
                  if (value!.length < 10) {
                    return 'Format Salah!';
                  }
                  return null;
                },
              ),
              formSpacer,
              const Text('Alamat'),
              TextFormField(
                controller: addressC,
                decoration: formDecor(hint: 'Alamat'),
                validator: (value) {
                  return null;
                },
              ),
              formSpacer,
              const Text('Kota'),
              DropdownSearch<CityModel>(
                asyncItems: (String filter) async {
                  final response = await Dio().get(
                    "https://api.rajaongkir.com/starter/city",
                    options: Options(headers: {'key': rajaOngkirKey}),
                  );
                  final list = response.data['rajaongkir']['results'] as List;
                  List<CityModel> data =
                      list.map((e) => CityModel.fromJson(e)).toList();
                  print(response);
                  return data;
                },
                onChanged: (CityModel? data) {
                  cityIdC?.text = data!.city_id!;
                  cityNameC?.text = data!.city_name!;
                  cityTypeC?.text = data!.type!;
                  print(data);
                },
                selectedItem: CityModel(
                  city_id:
                      profileProvider.loggedUserData!.address?.city_id ?? '',
                  city_name: cityNameC?.text ?? '',
                  type: cityTypeC?.text ?? '',
                ),
                dropdownBuilder: (context, selectedItem) {
                  return Text(
                    '${selectedItem?.type} ${selectedItem?.city_name}',
                  );
                },
                itemAsString: (item) => '${item.type} ${item.city_name!}',
                popupProps: const PopupProps.dialog(
                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(hintText: 'Cari Kota...'),
                  ),
                ),
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration:
                      InputDecoration(hintText: 'Pilih kota...'),
                ),
              ),
              formSpacer,
              BlueButton(
                padding: 0,
                teks: 'Simpan',
                onPressed: () async {
                  try {
                    isLoading = true;
                    showGeneralDialog(
                      context: context,
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          loadingIndicator,
                    );
                    await profileProvider.updateProfileData(
                      username: usernameC.text,
                      email: emailC.text,
                      phone: phoneC.text,
                      alamat: addressC.text,
                      cityId: cityIdC?.text ?? '',
                      cityName: cityNameC?.text ?? '',
                      cityType: cityTypeC?.text ?? '',
                    );
                    isLoading = false;
                    Navigator.of(context, rootNavigator: true).pop();
                    Navigator.pop(context);
                    setState(() {});
                    snackbar(context, 'Berhasil Update Data!', Colors.black);
                  } catch (e) {
                    rethrow;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
