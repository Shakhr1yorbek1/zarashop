
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';

class ProductViewPage extends StatefulWidget {
  final Product? product;
  const ProductViewPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductViewPage> createState() => _ProductViewPageState();
}

class _ProductViewPageState extends State<ProductViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.deepOrange),
        title: Container(
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
      body:  Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  pagination:const SwiperPagination(),
                  itemBuilder: (BuildContext context,int index){
                    return  CachedNetworkImage(
                      imageUrl: widget.product!.imgUrls![index],
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              ),
              //description
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.product!.name!,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                    //price
                    Text(widget.product!.price!,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24, color: Colors.deepOrange),),
                    //descriptions
                    Text(widget.product!.content!,style: const TextStyle(fontSize: 24),)
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
                          onPressed: (){},
                          icon: Icon(Icons.shopping_cart_outlined,size: 40,),
                        ),
                        Text("Buy",style: TextStyle(fontSize: 30),),

                      ],
                    ),
                  ),
                ],
              )
            ],
          )

        ],
      )
    );
  }

}
