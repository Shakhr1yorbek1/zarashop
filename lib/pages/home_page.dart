import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zarashop/pages/productview_page.dart';
import 'package:zarashop/pages/search_page.dart';

import '../model/product_model.dart';
import '../service/fire_database.dart';
import 'categoryview_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const SearchPage()));
                  },
                  child: Container(
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: const [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.search,
                            color: Colors.deepOrange,
                          ),
                          Text(
                            "Search",
                            style:
                                TextStyle(color: Colors.orange, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchPage()));
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.purpleAccent,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_a_photo_outlined),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
        flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
          Color.fromRGBO(248, 184, 225, 1.0),
          Color.fromRGBO(69, 172, 243, 1.0)
        ]))),
      ),
      body: RefreshIndicator(
        onRefresh: () => getProducts(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Super takliflar",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              // Ads
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 220,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Swiper(
                  loop: true,
                  duration: 1000,
                  autoplayDelay: 5000,
                  autoplay: true,
                  control: const SwiperControl(color: Colors.transparent),
                  itemBuilder: (BuildContext context, int index) {
                    return const Image(
                      image: AssetImage("assets/images/images.webp"),
                      fit: BoxFit.fill,
                    );
                  },
                  itemCount: 3,
                  pagination: const SwiperPagination(),
                ),
              ),

              //Categories
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //       children: items.map((e) {
              //         return itemOfProduct(e);
              //       }).toList()
              //   ),
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // children: categories.map((e) => itemOfCategory(e)).toList(),
                children: [
                  Column(
                    children: itemOfCategory,
                  ),
                  (isLoading) ?
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20),
                    child: const CircularProgressIndicator(),
                  ) : const SizedBox(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  List items = [];
  List categoryNames = [];
  bool isLoading = false;
  List<Map<String, dynamic>> categories = [];
  List<Widget> itemOfCategory = [];

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  Widget itemOfProduct(Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
              child: ProductViewPage(product: product),
              type: PageTransitionType.fade,
            ));
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 5)]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                ),
                child: product.imgUrls!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: product.imgUrls!.first,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.red,
                          highlightColor: Colors.yellow,
                          child: const Center(
                            child: Text(
                              'Zara shop',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Image(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/rasm.png"),
                        ),
                        fit: BoxFit.cover,
                      )
                    : const Image(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/rasm.png"),
                      )),
            Container(
              width: 180,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name!,
                    style: const TextStyle(
                      fontSize: 22,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    product.price!,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future<void> getProducts() async {
    setState(() {
      isLoading = true;
      categories = [];
      itemOfCategory = [];
    });
    await RTDBService.getCategory().then((value) => {
      setState(() {
        categoryNames = value;
      }),
    });
    for (int i = 0; i < categoryNames.length; i++) {
      await DataService.getOfCategory(categoryNames[i]).then((value) {
        if (value.isNotEmpty) {
          setState(() {
            categories.add({
              "name": categoryNames[i],
              "products": value,
            });
          });
        }
      });
      setState(() {
        final usersQuery = FirebaseFirestore.instance
            .collection('products')
            .where("category", isEqualTo: categories[i]["name"])
            .withConverter<Product>(
              fromFirestore: (snapshot, _) =>
                  Product.fromJson(snapshot.data()!),
              toFirestore: (product, _) => product.toJson(),
            );
        itemOfCategory.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      categories[i]["name"],
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => CategoryViewPage(
                              category: categories[i],
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "Yana",
                        style: TextStyle(color: Colors.orange, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 300,
                width: 400,
                child: FirestoreListView<Product>(
                  query: usersQuery,
                  scrollDirection: Axis.horizontal,
                  loadingBuilder: (context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  itemBuilder: (context, snapshot) {
                    Product product = snapshot.data();
                    return itemOfProduct(product);
                  },
                ),
              ),
            ],
          ),
        );
      });
    }
    setState(() {
      isLoading = false;
    });
  }
}
