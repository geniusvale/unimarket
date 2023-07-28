import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart' as providers;
import 'package:unimarket/controller/profile_provider.dart';
import 'package:unimarket/models/seller_request/seller_request_model.dart';
import '../../controller/seller_request_provider.dart';
import '../../utilities/constants.dart';
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
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text('Tidak Ada Request Penjual'),
              );
            } else {
              return ListView.builder(
                itemCount: sellerRequestProvider.allRequest?.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (ctx) {
                          return SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(
                                bottom: MediaQuery.of(ctx).viewInsets.bottom,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(child: handleBar),
                                        formSpacer,
                                        Text(
                                          'Nama : ${snapshot.data![index].profiles!.username!}',
                                        ),
                                        Text(
                                          'NIM : ${snapshot.data![index].nim}',
                                        ),
                                        Text(
                                          'Alamat : ${snapshot.data![index].profiles!.address!.alamat!}',
                                        ),
                                        Text(
                                          'Kota : ${snapshot.data![index].profiles!.address!.type} ${snapshot.data![index].profiles!.address!.city_name}',
                                        ),
                                        Text(
                                          'Email : ${snapshot.data![index].profiles!.email}',
                                        ),
                                        Text(
                                          'No HP : ${snapshot.data![index].profiles!.phone}',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
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
                    subtitle: Text('NIM : ${snapshot.data![index].nim!}'),
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
            }
          },
        ),
      ),
    );
  }
}
