import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as providers;
import 'package:unimarket/controller/profile_provider.dart';
import 'package:unimarket/models/seller_request/seller_request_model.dart';
import 'package:unimarket/utilities/constants.dart';
import '../controller/seller_request_provider.dart';

class ConfirmSellerRequest extends StatefulWidget {
  const ConfirmSellerRequest({Key? key}) : super(key: key);

  @override
  State<ConfirmSellerRequest> createState() => _ConfirmSellerRequestState();
}

class _ConfirmSellerRequestState extends State<ConfirmSellerRequest> {
  @override
  Widget build(BuildContext context) {
    final sellerRequestProvider =
        providers.Provider.of<SellerRequestProvider>(context, listen: false);
    final profileProvider =
        providers.Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<SellerRequestModel>>(
        future: sellerRequestProvider.getSellerRequestList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: sellerRequestProvider.allRequest?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(),
                  title: Text(snapshot.data![index].users_id!),
                  subtitle: Text(snapshot.data![index].nim!),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.cancel_outlined,
                          color: Colors.red,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // profileProvider.getProfileById(
                          //   snapshot.data![index].users_id!,
                          // );
                          profileProvider.getAllProfile();
                          // print(snapshot.data![index].users_id!);
                        },
                        icon: const Icon(
                          Icons.check_circle_outlined,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return loadingIndicator;
          }
        },
      ),
    );
  }
}
