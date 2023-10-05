import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:store_api_flutter_course/consts/global_color.dart';
import 'package:store_api_flutter_course/screen/user_screen.dart';

import '../model/product_model.dart';
import '../services/api_handler.dart';
import '../widgets/category_widget.dart';
import '../widgets/feeds_grid.dart';
import '../widgets/sale_widget.dart';
import 'category_screen.dart';
import 'feed_screen.dart';
class HomeScreen extends StatefulWidget{
  const HomeScreen({Key ? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  late TextEditingController _textEditingController;


  @override
  void initState() {
    _textEditingController =TextEditingController();
    super.initState();
  }


  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
  return GestureDetector(
onTap: (){
    FocusScope.of(context).unfocus();
},
    child: Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: AppBarIcons(
          function : (){
            Navigator.push(context,PageTransition(type:PageTransitionType.fade,
                child: const CategoriesScreen(),


            ),
            );
          },
            icon: IconlyBold.category,
      
        ),
        actions: [
          AppBarIcons(
            function:(){
                   Navigator.push(context, PageTransition(type: PageTransitionType.fade,
                       child: const UsersScreen(),
                   ),
                   );
            },
            icon: IconlyBold.user3,
          ),

        ],

      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 18,),
            TextField(
               controller:  _textEditingController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Search",
                fillColor: Theme.of(context).cardColor,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(context).cardColor,

                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 1,
                    color: Theme.of(context).colorScheme.secondary,

                  ),
                ),
                suffixIcon: Icon(IconlyLight.search,
                color: lightIconsColor,),
              ),
            ),
            const SizedBox(height: 18,),
            Expanded(child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height:
                    size.height*0.25,
                  child: Swiper(
                    itemCount: 3,
                      itemBuilder: (BuildContext ctx, Index){
                      return const SaleWidget();

                      },
                    autoplay: true,
                    pagination: const SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: DotSwiperPaginationBuilder(
                        color: Colors.white,
                        activeColor: Colors.red,
                      )
                    ),
                  ),),
                  Padding(padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      const Text("Latest Product",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),),
                      const Spacer(),
                      AppBarIcons(function: (){
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade,
                            child: FeedsScreen()));
                      },
                      icon: IconlyBold.arrowRight2),
                    ],
                  ),),
                  FutureBuilder<List<ProductsModel>>(
                    future: APIHandler.getAllProducts(limit: "3"),
                    builder: (( BuildContext context , snapshot){
                      if(snapshot.connectionState==
                      ConnectionState.waiting){
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }else if (snapshot.hasError){
                        Center(
                          child: Text("An errorwa occcured ${snapshot.error}"),
                        );
                      }
                      return FeedsGridWidget(
                        productsList: snapshot.data!,
                      );
                    }),

                  )
                ],
              ),
            ))
          ],
        ),
      ),
    ),
  );

  }
  
}

AppBarIcons({required Null Function() function, required IconData icon}) {
}