import 'dart:ffi';

import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:store_api_flutter_course/consts/global_color.dart';

import '../model/product_model.dart';
import '../services/api_handler.dart';

class ProductDetails extends StatefulWidget{
  const ProductDetails({Key? key, required this.id}): super(key: key);

  final String id;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}
class _ProductDetailsState extends State<ProductDetails>{
  final titleStyle = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold
  );
  ProductsModel? productModel;
  bool isError = false;
  String errorStr = "";
  Future<void> getProductInfo()async{
    try{
      productModel = await APIHandler.getProductById(id: widget.id);

    }catch(error){
      isError = true;
      errorStr = error.toString();
      log("error $error");
    }
    setState(() {

    });
  }

  @override
  void didChangeDependencies(){
    getProductInfo();
    super.didChangeDependencies();
  }



  @override
  Widget build(BuildContext context) {
    var size;
    return Scaffold(
      body: SafeArea(
        child: isError?
        Center(
          child: Text("An occured $errorStr",
          style: const TextStyle(
            fontSize: 25, fontWeight: FontWeight.w500
          ),),

        )
            : productModel == null
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 18,),
              const BackButton(),
              Padding(padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productModel!.category!.name.toString(),
                    style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height:  18,),
                  Row(
                    mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: Text(
                        productModel!.title.toString(),
                        textAlign: TextAlign.start,
                        style: titleStyle,
                      ),
                      flex: 3,),

                      Flexible(
                          flex: 1,
                          child: RichText(
                        text: TextSpan(
                          text: '\$',
                          style: TextStyle(
                            fontSize: 25,
                            color: Color.fromRGBO(33, 150, 245, 1)
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: productModel!.price.toString(),
                              style: TextStyle(
                                color: lightTextColor,
                                fontWeight: FontWeight.bold,
                              )
                            )
                          ]

                        ),
                      ))
                    ],
                  ),
                  const SizedBox(height: 18,),
                ],
              ),),
              SizedBox(height: size.height *0.4,
              child: Swiper(
                itemBuilder: (BuildContext context , int index){
                  return FancyShimmerImage(imageUrl:
                  productModel!.images![index].toString(),
                  boxFit: BoxFit.fill,);
                },
                autoplay: true,
                itemCount: 3,
                pagination:  const SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.white,
                    activeColor: Colors.red,
                  )
                ),
              ),),
              const SizedBox(
                height: 18,
              ),
              Padding(padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Description', style: titleStyle,),
                    SizedBox(height: 18,),
                    Text(
                      productModel!.description.toString(),
                      textAlign: TextAlign.start,
                      style: const TextStyle(fontSize: 25),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }


}