import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/product/product_model.dart';
import '../screens/product/detail_product.dart';
import 'constants.dart';

class ProductCard extends StatelessWidget {
  final int index;
  final AsyncSnapshot<List<ProductModel>> snapshot;
  const ProductCard({Key? key, required this.index, required this.snapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.3,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return DetailProduct(
                  index: index,
                  snapshot: snapshot,
                );
              },
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  child: CachedNetworkImage(
                    imageUrl: '${snapshot.data![index].img_url}',
                    // 'https://picsum.photos/id/${index + randomNumber}/200/200',
                    progressIndicatorBuilder: (context, url, downloadProgress) {
                      return CircularProgressIndicator(
                        value: downloadProgress.progress,
                      );
                    },
                    errorWidget: (context, url, error) {
                      return const Icon(
                        Icons.broken_image_outlined,
                      );
                    },
                  ),
                ),
              ),
            ),
            formSpacer,
            Padding(
              padding: formPadding,
              child: Text(
                snapshot.data?[index].name ?? '~Error',
              ),
            ),
            Padding(
              padding: formPadding,
              child: Text(
                numberCurrency.format(snapshot.data![index].price),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: formPadding,
              child: Row(
                children: [
                  CircleAvatar(
                    minRadius: 10,
                    backgroundImage: NetworkImage(
                        snapshot.data![index].profiles!.avatar_url!),
                    onBackgroundImageError: (exception, stackTrace) =>
                        const Icon(Icons.broken_image),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(snapshot.data![index].profiles!.username!)
                ],
              ),
            ),
            formSpacer,
          ],
        ),
      ),
    );
  }
}

class BlueButton extends StatelessWidget {
  String teks;
  VoidCallback onPressed;
  BlueButton({Key? key, required this.teks, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
              child: Text(teks),
              onPressed: onPressed,
            ),
          ),
        )
      ],
    );
  }
}
