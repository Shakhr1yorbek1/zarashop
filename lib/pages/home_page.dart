import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => const SearchPage()));
                  },
                  child: Container(
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:  Container(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: const [
                          SizedBox(width: 10,),
                          Icon(Icons.search, color: Colors.deepOrange,),
                          Text("Search", style: TextStyle(color: Colors.orange, fontSize: 16),),
                        ],
                      ),

                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchPage()));
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.orange,
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
                  children:  const[
                    Text(
                      "Super takliflar",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),

              // Ads
              const SizedBox(height: 10,),
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
                  control: const SwiperControl(
                      color: Colors.transparent
                  ),
                  itemBuilder: (BuildContext context,int index){
                    return const Image(
                      image: AssetImage("assets/images/images.webp"),
                      fit: BoxFit.fill,
                    );
                  },
                  itemCount: 3,
                  pagination:const SwiperPagination(),
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
                children: items.map((e) => itemOfCategory(e)).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  List items = [];
  List category=[];

  Widget itemOfCategory(Map category) {
    List<Product> list = category["products"];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 10,left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Text(
                category["name"],
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              TextButton(
                onPressed:   () {
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => CategoryViewPage(category: category,)));
                },
                child: const Text(
                  "Yana",
                  style: TextStyle(color: Colors.orange, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: list.map((e) => itemOfProduct(e)).toList()
          ),
        ),
      ],
    );
  }

  Widget itemOfProduct(Product product) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(builder: (context) => ProductViewPage(product: product)));
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(color: Colors.grey, blurRadius: 5)
            ]
        ),
        child: Column(
          children: [
            Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                ),
                child: CachedNetworkImage(
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
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
            ),
            Container(
              width: 180,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name!,
                    style: const TextStyle(fontSize: 22, overflow: TextOverflow.ellipsis,),
                  ),
                  const SizedBox(height: 10,),
                  Text(product.price!, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getProducts() async {
    await DataService.getProduct().then((value) => {
      print(value),
      setState((){
        items=value;
      })
    });
  }


  void getCategory() async {
    await RTDBService.getCategory().then((value) => {
      setState((){
        category=value;
      })
    });
  }


}








