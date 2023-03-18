import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:custom_bottom_sheet/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';

class ProductViewPage extends StatefulWidget {
  final Product? product;

  const ProductViewPage({Key? key, this.product}) : super(key: key);

  @override
  State<ProductViewPage> createState() => _ProductViewPageState();
}

class _ProductViewPageState extends State<ProductViewPage> {
  bool isLiked = true;

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
                      borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                  )),
                  child: Swiper(
                    loop: true,
                    itemCount: widget.product!.imgUrls!.length,
                    pagination: const SwiperPagination(),
                    itemBuilder: (BuildContext context, int index) {
                      return CachedNetworkImage(
                        imageUrl: widget.product!.imgUrls![index],
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) {
                          return const Icon(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.grey.shade200,
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back_ios_sharp,
                                        color: Colors.black54,
                                      )),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey.shade200,
                                  child: IconButton(
                                    onPressed: () {
                                      // setState((){
                                      //   post.isLiked = !post.isLiked;
                                      // });
                                      // DataService.likePost(post, post.isLiked);
                                    },
                                    icon: (isLiked == true)
                                        ? const Icon(
                                            Icons.favorite_border,
                                            color: Colors.red,
                                          )
                                        : const Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            //description
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(50))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product!.name!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  //star
                  Row(
                    children: const [
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
                  const Text(
                    "Description",
                    style: TextStyle(
                      fontSize: (30),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
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
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade300,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    width: 120,
                    height: 20 + 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 15),
                    width: 250,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                      onPressed: () {
                        customBottomSheet(context);
                      },
                      child: Text(
                        "${widget.product!.price} Add to card",
                        style: const TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        )
      ],
    ));
  }

  void customBottomSheet(BuildContext context) {
    SlideDialog.showSlideDialog(
      context: context,
      backgroundColor: Colors.white,
      pillColor: Colors.yellow,
      transitionDuration: const Duration(milliseconds: 300),
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("size"),
          ],
        ),
      ),
    );
  }
}
