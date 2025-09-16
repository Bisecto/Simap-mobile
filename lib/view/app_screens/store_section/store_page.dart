import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/store_bloc/store_bloc.dart';
import '../../../bloc/store_bloc/store_event.dart';
import '../../../bloc/store_bloc/store_state.dart';
import '../../../model/store_model/store.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final int _selectedTabIndex = 0;
  final String _selectedCategory = 'All Products';

  @override
  void initState() {
    super.initState();
    // Load recommended products by default
    context.read<StoreBloc>().add(LoadAllProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          '#UHS20220147',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blue[700],
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedCategory,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.amber[400],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Products List
          Expanded(
            child: BlocConsumer<StoreBloc, StoreState>(
              listener: (context, state) {
                if (state is StoreError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: ${state.message}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (state is ProductAddedToCart) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${state.product.name} added to cart!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is StoreLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is StoreLoaded) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      return _buildProductCard(product);
                    },
                  );
                } else if (state is StoreError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Failed to load products',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            context.read<StoreBloc>().add(LoadAllProducts());
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                return const Center(
                  child: Text('No products available'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: product.name.toLowerCase().contains('bag')
                ? const Icon(
                    Icons.work_outline,
                    size: 80,
                    color: Colors.grey,
                  )
                : const Icon(
                    Icons.water_drop_outlined,
                    size: 80,
                    color: Colors.blue,
                  ),
          ),

          const SizedBox(height: 16),

          // Product Details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '₦${product.priceAsDouble.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Stock: ${product.stockQuantity}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<StoreBloc>().add(AddToCart(product));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Add to cart',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// import 'package:simap/res/app_images.dart';
// import 'package:simap/utills/app_utils.dart';
// import 'package:simap/view/app_screens/store_section/store_containers/store_filter.dart';
// import 'package:simap/view/widgets/app_custom_text.dart';
// import 'package:simap/view/widgets/drop_down.dart';
//
// import '../../../model/class_model.dart';
// import '../../../model/student_profile.dart';
// import '../../../res/app_colors.dart';
// import '../../widgets/appBar_widget.dart';
// import 'cart_page.dart';
//
// class StorePage extends StatefulWidget {
//   StudentProfile studentProfile;
//   ClassModel classModel;
//
//   StorePage({required this.studentProfile,required this.classModel});
//
//   @override
//   _StorePageState createState() => _StorePageState();
// }
//
// class _StorePageState extends State<StorePage> {
//   final List<Map<String, dynamic>> products = [
//     {
//       "name": "NHS Customized Bag",
//       "price": 12500,
//       "inCart": false,
//       "image":
//       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSfbSvolBUrb1YtbDVRgej4J3evZIMUnnqDA&s",
//     },
//     {
//       "name": "NHS Water Bottle",
//       "price": 3500,
//       "inCart": false,
//       "image":
//       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDPrSDGnbZux1HkCaKmcbZJKiYLamGoZ8ATg&s",
//     },
//     {
//       "name": "Children school shoes",
//       "price": 7500,
//       "inCart": false,
//       "image":
//       "https://sothebys-md.brightspotcdn.com/dims4/default/c634f32/2147483647/strip/true/crop/3441x3441+0+0/resize/800x800!/quality/90/?url=http%3A%2F%2Fsothebys-brightspot.s3.amazonaws.com%2Fmedia-desk%2F4e%2F49%2F52f631944e72a6873844d9f04334%2F366sneakers-bv2dx-06.jpg",
//     },
//   ];
//
//   List<Map<String, dynamic>> cartItems = [];
//
//   void toggleCart(int index) {
//     setState(() {
//       if (products[index]["inCart"]) {
//         cartItems
//             .removeWhere((item) => item["name"] == products[index]["name"]);
//         products[index]["inCart"] = false;
//       } else {
//         cartItems.add(products[index]);
//         products[index]["inCart"] = true;
//       }
//     });
//   }
//
//   void navigateToCart() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => CartPage(
//         cartItems: cartItems, studentProfile: widget.studentProfile, classModel: widget.classModel,)),
//     );
//   }
//
//   String selectedValue = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFCFCFC),
//       body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   MainAppBar(
//                       isBackKey: true, studentProfile: widget.studentProfile, classModel: widget.classModel,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         StoreFilter(
//                           selectedFilterItems: (String value) {},
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           // crossAxisAlignment: CrossAxisAlignment.start,
//
//                           children: [
//                             DropDown(
//                                 selectedValue: selectedValue,
//                                 width:
//                                 AppUtils
//                                     .deviceScreenSize(context)
//                                     .width / 2.5,
//                                 hint: "All Categories",
//                                 showLabel: false,
//                                 borderRadius: 10,
//                                 items: const [
//                                   'item 1',
//                                   'item 2',
//                                   'item 3',
//                                   'item 4'
//                                 ]),
//                             InkWell(
//                               onTap: navigateToCart,
//                               child: Row(
//                                 // mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Container(
//                                     height: 50,
//                                     width: 50,
//                                     decoration: BoxDecoration(
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.black.withOpacity(0.15),
//                                           spreadRadius: 0,
//                                           blurRadius: 10,
//                                           offset: const Offset(0, 4),
//                                         ),
//                                       ],
//                                       color: AppColors.yellow,
//                                       borderRadius: BorderRadius.circular(15),
//                                     ),
//                                     child: Stack(
//                                       children: [
//                                         if(products
//                                             .where((product) =>
//                                         product['inCart'] == true)
//                                             .isNotEmpty)
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 right: 8.0, top: 5),
//                                             child: Align(
//                                               alignment: Alignment.topRight,
//                                               child: CustomText(
//                                                 text:
//                                                 '${products
//                                                     .where((product) =>
//                                                 product['inCart'] == true)
//                                                     .length}',
//                                                 color: AppColors.red,
//                                                 weight: FontWeight.bold,
//                                                 size: 12,
//                                               ),
//                                             ),
//                                           ),
//                                         const Center(
//                                             child:
//                                             Icon(Icons.shopping_cart_outlined)),
//                                       ],
//                                     ),
//                                   ),
//                                   // const CustomText(
//                                   //   text: " My Cart",
//                                   //   color: AppColors.black,
//                                   //   weight: FontWeight.w600,
//                                   // )
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Container(
//                           height: (products.length * 380) + 100,
//                           child: ListView.builder(
//                               itemCount: products.length,
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemBuilder: (context, index) {
//                                 final product = products[index];
//                                 return productConatiner(
//                                     product['image'],
//                                     product['name'],
//                                     "₦${product['price']}",
//                                     product['inCart'],
//                                     index);
//                               }),
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           )),
//     );
//   }
//
//   Widget productConatiner(String image, String name, String price, bool inCart,
//       int index) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Container(
//         height: 370,
//         width: AppUtils
//             .deviceScreenSize(context)
//             .width,
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.15),
//               spreadRadius: 0,
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//           color: AppColors.white,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.network(
//               image,
//               height: 300,
//               width: AppUtils
//                   .deviceScreenSize(context)
//                   .width,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CustomText(
//                         text: name,
//                         color: AppColors.black,
//                         weight: FontWeight.w700,
//                       ),
//                       CustomText(
//                         text: price,
//                       ),
//                     ],
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       toggleCart(index);
//                     },
//                     child: Container(
//                       height: 40,
//                       width: 90,
//                       decoration: BoxDecoration(
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.15),
//                             spreadRadius: 0,
//                             blurRadius: 10,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                         color: inCart ? Colors.red : Colors.green,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Center(
//                         child: CustomText(
//                           text: inCart ? "Remove" : "Add to cart",
//                           weight: FontWeight.w700,
//                           color: AppColors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                   // IconButton(
//                   //   icon: Icon(
//                   //     inCart ? Icons.love : Icons.shopping_cart,
//                   //     color: inCart ? Colors.red : Colors.green,
//                   //   ),
//                   //   onPressed: () => toggleCart(index),
//                   // )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
