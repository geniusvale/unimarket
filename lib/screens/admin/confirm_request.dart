import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart' as providers;
import 'package:unimarket/controller/profile_provider.dart';
import 'package:unimarket/models/seller_request/seller_request_model.dart';
import 'package:unimarket/utilities/constants.dart';
import '../../controller/seller_request_provider.dart';
import '../../utilities/widgets.dart';

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
      appBar: AppBar(
        title: const Text('Konfirmasi Request Penjual'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: FutureBuilder<List<SellerRequestModel>>(
          future: sellerRequestProvider.getSellerRequestList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: sellerRequestProvider.allRequest?.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: ClipOval(
                        child:
                            snapshot.data![index].profiles!.avatar_url == null
                                ? SvgPicture.asset('assets/images/blankpp.svg')
                                : Image.network(
                                    snapshot.data![index].profiles!.avatar_url!,
                                    fit: BoxFit.fill,
                                  ),
                      ),
                    ),
                    title: Text(snapshot.data![index].profiles!.username!),
                    subtitle: Text(snapshot.data![index].nim!),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () async {
                            try {
                              await sellerRequestProvider.declineSellerRequest(
                                snapshot.data![index].profiles!.id,
                              );
                              snackbar(context, 'Request Ditolak', Colors.red);
                              setState(() {});
                            } catch (e) {
                              snackbar(context, 'error', Colors.red);
                            }
                          },
                          icon: const Icon(
                            Icons.cancel_outlined,
                            color: Colors.red,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            try {
                              await sellerRequestProvider.acceptSellerRequest(
                                nim: snapshot.data![index].nim!,
                                userId: snapshot.data![index].profiles!.id,
                                phone: snapshot.data![index].phone,
                                alamat: snapshot.data![index].alamat,
                                cityId: snapshot.data![index].city_id,
                                cityName: snapshot.data![index].city_name,
                                cityType: snapshot.data![index].type,
                              );
                              snackbar(context, 'Konfirmasi Berhasil!',
                                  Colors.green);
                              setState(() {});
                            } catch (e) {
                              snackbar(context, e.toString(), Colors.black);
                            }
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
      ),
    );
  }
}
