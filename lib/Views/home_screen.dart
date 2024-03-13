import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_test/Widgets/heart_container.dart';
import 'package:practice_test/models/product_model.dart';

import '../provider/future_provider.dart';
import '../provider/provider.dart';
import 'fav_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(
    BuildContext context,WidgetRef ref

  ) {
    List<Products> list=  ref.watch(listFavProvider);

    return Scaffold(
      // floatingActionButton: HeartWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FavScreen(),
            ),
          );
        },
        child: Text(list.length.toString(),style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Product List'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.favorite)),
        ],
      ),
      body: Consumer(builder: (_, WidgetRef ref, __) {
        final dataResponse = ref.watch(productList);
        return dataResponse.when(
          data: (responseValue) {
            print('the response is ${responseValue}');
            List<Products>? responseCode = responseValue.products;
            print('the responseCode is ${responseCode}');
            return ListView.builder(
              itemCount: responseCode?.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Card(
                        surfaceTintColor: Colors.teal,
                        borderOnForeground: true,
                        shadowColor: Colors.blue,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.network(
                                  responseCode![index].thumbnail.toString()),
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                    'Description',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                      textAlign: TextAlign.justify,
                                      responseCode![index]
                                          .description
                                          .toString()),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Price',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          responseCode[index].price.toString(),
                                          style: const TextStyle(
                                              fontSize: 16, color: Colors.teal),
                                        ),
                                        // const SizedBox(width: 10,),
                                        const Text(
                                          'Brand',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        // const SizedBox(width: 10,),
                                        Text(
                                          responseCode[index].brand.toString(),
                                          style: const TextStyle(
                                              fontSize: 16, color: Colors.teal),
                                        )
                                      ]),
                                  Flexible(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        const Text(
                                          'Title',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        Text(responseCode[index].title.toString(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.teal)),
                                        // const SizedBox(width: 10,),
                                        const Text(
                                          overflow: TextOverflow.visible,
                                          'Category',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        // const SizedBox(width: 10,),
                                        Text(
                                            responseCode[index]
                                                .category
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.teal)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Rating',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Text(responseCode[index].rating.toString(),
                                          style: const TextStyle(
                                              fontSize: 16, color: Colors.teal)),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        'Discount',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                          responseCode[index]
                                              .discountPercentage
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 16, color: Colors.teal)),
                                    ],
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.teal.shade300)),
                                    child: const Text(
                                      "Add to favorite",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      ref
                                          .read(listFavProvider.notifier)
                                          .addToFav(responseCode[index]);

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        backgroundColor: Colors.blue,
                                        content: Text('Added to Favorite'),
                                        duration: Duration(seconds: 1),
                                        // action: SnackBarAction(
                                        //   label: 'ACTION',
                                        //   onPressed: () { },
                                        // ),
                                      ));
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          error: (error, _) {
            debugPrint("the error is $error");
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.red,
            ));
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          },
        );
      }),
    );
  }

}
