import 'package:badges/badges.dart';
import 'package:cartprovider/Provider/CartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'CartScreen.dart';
import '../Repo/DBHelper.dart';
import '../model/ProductModelClass.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  DBHelper? dbHelper = DBHelper();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<CartProvider>(context, listen: false);
    provider.getProductData(context);
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Shopping Mall'),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CartScreen()));
              },
              child: Center(
                child: Badge(
                  position: const BadgePosition(top: 3, end: 0),
                  showBadge: true,
                  badgeContent: Consumer<CartProvider>(
                    builder: (context, value, child) {
                      return Text(value.getCounter().toString(),
                          style: const TextStyle(color: Colors.white));
                    },
                  ),
                  animationType: BadgeAnimationType.fade,
                  animationDuration: const Duration(milliseconds: 300),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 13),
                      child: Image.asset(
                        "images/ic_cart.png",
                        color: Colors.white,
                      )),
                ),
              ),
            ),
            const SizedBox(width: 20.0)
          ],
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            return cart.isLoading
                ? const Center(
                    child: SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                            color: Colors.blue, strokeWidth: 2.5)))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      cart.product.isNotEmpty
                          ? Expanded(
                              child: GridView.builder(
                                shrinkWrap: true,
                                primary: false,
                                physics: const BouncingScrollPhysics(),
                                itemCount: cart.product.length,
                                gridDelegate: orientation ==
                                        Orientation.landscape
                                    ? const SliverGridDelegateWithFixedCrossAxisCount(

                                        crossAxisCount: 2,
                                        mainAxisSpacing: 1,
                                        crossAxisSpacing: 15,
                                        childAspectRatio: 2,
                                    mainAxisExtent: 21*9)
                                    : const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 0,
                                        crossAxisSpacing: 1,
                                        childAspectRatio: 1,
                                  mainAxisExtent: 21*9
                                      ),
                                itemBuilder: (context, pos) {
                                  DataList model = cart.product[pos];
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, left: 12, right: 12),
                                    child: Column(
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(11),
                                              border: Border.all(
                                                  width: 0.8,
                                                  color: Colors.grey),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.11),
                                                  spreadRadius: 10,
                                                  blurRadius: 11,
                                                  offset: const Offset(2, 1),
                                                ),
                                              ],
                                            ),

                                            child: Column(
                                              children: [
                                                Container(
                                                  color: Colors.transparent,
                                                  child: Image.network(
                                                    model.image.toString(),
                                                    fit: BoxFit.contain,
                                                    height: 115,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          "${model.title}",
                                                          maxLines: 1,
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {
                                                            dbHelper
                                                                ?.insert(
                                                                    DataList(
                                                                        id: model
                                                                            .id,
                                                                        slug: model
                                                                            .slug
                                                                            .toString(),
                                                                        title: model
                                                                            .title
                                                                            .toString(),
                                                                        description: model
                                                                            .description
                                                                            .toString(),
                                                                        price: model
                                                                            .price,
                                                                        productPrice:
                                                                            model
                                                                                .price,
                                                                        image: model
                                                                            .image
                                                                            .toString(),
                                                                        status: model
                                                                            .status
                                                                            .toString()
                                                                        ))
                                                                .then((value) {
                                                              cart.addTotalPrice(
                                                                  double.parse(model
                                                                      .price
                                                                      .toString()));
                                                              cart.addCounter();
                                                              const snackBar =
                                                                  SnackBar(
                                                                backgroundColor:
                                                                    Colors
                                                                        .green,
                                                                content: Text(
                                                                    'Product is added to cart.'),
                                                                duration:
                                                                    Duration(
                                                                        seconds:
                                                                            1),
                                                              );
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      snackBar);
                                                            }).onError((error,
                                                                    stackTrace) {
                                                              const snackBar = SnackBar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                  content: Text(
                                                                      'Product is already added in cart.'),
                                                                  duration:
                                                                      Duration(
                                                                          seconds:
                                                                              1));
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      snackBar);
                                                            });
                                                          },
                                                          child: Image.asset(
                                                            "images/ic_cart.png",
                                                            height: 24,
                                                            width: 24,
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                              ],
                                            )),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          : Center(
                              child: Column(
                                children: const [
                                  Text(
                                    "No data found",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            )
                    ],
                  );
          },
        ));
  }
}
