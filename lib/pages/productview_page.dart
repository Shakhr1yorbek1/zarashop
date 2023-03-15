import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';

class ProductViewPage extends StatefulWidget {
  final Product? product;

  const ProductViewPage({Key? key, this.product}) : super(key: key);

  @override
  State<ProductViewPage> createState() => _ProductViewPageState();
}

class _ProductViewPageState extends State<ProductViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width,
                  // margin: const EdgeInsets.symmetric(horizontal: 10),
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                      // color: Colors.black,
                      ),
                  child: Swiper(
                    loop: true,
                    itemCount: widget.product!.imgUrls!.length,
                    pagination: const SwiperPagination(),
                    itemBuilder: (BuildContext context, int index) {
                      return CachedNetworkImage(
                        imageUrl: widget.product!.imgUrls![index],
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) {
                          return Icon(
                            Icons.warning,
                            color: Colors.red,
                            size: 160,
                          );
                        },
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_back_ios_sharp)),
                    )
                  ],
                )
              ],
            ),
            //description
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product!.name!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  //price
                  Text(
                    widget.product!.price!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.deepOrange),
                  ),
                  //star
                  Row(
                    children: [
                      Image(
                        image: AssetImage("assets/images/star.jpg"),
                        width: 150,
                      ),
                      Text(
                        "4.9",
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                  //descriptions
                  Text(
                    "Description",
                    style: TextStyle(
                      fontSize: (30),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    widget.product!.content!,
                    style: const TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.shopping_cart_outlined,
                          size: 40,
                        ),
                      ),
                      Text(
                        "Buy",
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        )
      ],
    ));
  }
}
