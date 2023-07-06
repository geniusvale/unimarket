import 'package:flutter/material.dart';

import '../../utilities/constants.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Nama'),
                    TextFormField(
                      controller: null,
                      decoration: formDecor(hint: 'Username'),
                    ),
                    formSpacer,
                    const Text('Email'),
                    TextFormField(
                      controller: null,
                      decoration: formDecor(hint: 'Email'),
                    ),
                    formSpacer,
                    
                    const Text('NIM'), //SHOULD DISABLED
                    TextFormField(
                      controller: null,
                      decoration: formDecor(hint: 'NIM'),
                    ),
                    formSpacer,
                    const Text('Nomor HP'),
                    TextFormField(
                      controller: null,
                      decoration: formDecor(hint: 'Nomor HP'),
                    ),
                    formSpacer,
                    const Text('Alamat'),
                    TextFormField(
                      controller: null,
                      decoration: formDecor(hint: 'Alamat'),
                    ),
                    formSpacer,
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[900],
                              foregroundColor: Colors.white,
                              textStyle: const TextStyle(color: Colors.white),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                            ),
                            child: const Text('Simpan'),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
