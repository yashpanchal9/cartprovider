import 'package:cartprovider/Provider/CartProvider.dart';
import 'package:cartprovider/model/ProductModelClass.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Repo/DBHelper.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DBHelper? dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: cart.getData(),
              builder: (context, AsyncSnapshot<List<DataList>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text('Your cart is empty',
                              style: Theme.of(context).textTheme.headline5),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                              'Explore products and shop your\nfavourite items',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.subtitle2)
                        ],
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(11),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.2),
                                                spreadRadius: 10,
                                                blurRadius: 11,
                                                offset: const Offset(3, 3),
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(14.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    const Image(
                                                      height: 100,
                                                      width: 100,
                                                      image: NetworkImage(
                                                          "http://209.182.213.242/~mobile/MtProject/uploads/product_image/3.jpg"),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot
                                                                          .data?[
                                                                              index]
                                                                          .title
                                                                          .toString() ??
                                                                      '--',
                                                                  maxLines: 1,
                                                                  style: const TextStyle(
                                                                      fontSize: 16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ),
                                                              InkWell(
                                                                  onTap: () {
                                                                    dbHelper!.delete(
                                                                        snapshot
                                                                            .data![
                                                                                index]
                                                                            .id!);
                                                                    // cart.removerCounter();
                                                                    cart.removeTotalPrice(
                                                                        double.parse(snapshot
                                                                            .data![
                                                                                index]
                                                                            .price
                                                                            .toString()));
                                                                  },
                                                                  child: Image.asset(
                                                                    "images/delete.png",
                                                                    height: 30,
                                                                    width: 30,
                                                                  ))
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 12,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              const Text(
                                                                "Price:",
                                                                style: TextStyle(
                                                                    fontSize: 16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              Text(
                                                                // "\$10",
                                                                "\$" +
                                                                    snapshot
                                                                        .data![index]
                                                                        .productPrice
                                                                        .toString(),
                                                                style: const TextStyle(
                                                                    fontSize: 16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: const [
                                                              Text(
                                                                "Quantity:",
                                                                style: TextStyle(
                                                                    fontSize: 16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              Text(
                                                                "1",
                                                                style: TextStyle(
                                                                    fontSize: 16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),


                                    ],
                                  );
                                }),
                          ),
                          Container(
                            color: Colors.blue.withOpacity(0.5),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Text("Total Item:  "+ snapshot.data!.length.toString(),
                                  style: Theme.of(context).textTheme.subtitle2,
                                  ),
                                  Text("Grand Total: "+ cart.getTotalPrice().toStringAsFixed(2),style: Theme.of(context).textTheme.subtitle2,)
                                ],
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              ),
                            ),
                          ),

                        ],
                      ),
                    );
                  }
                }
                return const Text('');
              }),
        ],
      ),
    );
  }
}

