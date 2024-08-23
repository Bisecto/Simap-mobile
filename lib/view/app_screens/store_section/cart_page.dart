import 'package:flutter/material.dart';

import '../../../res/app_colors.dart';
import '../../../utills/app_utils.dart';
import '../../widgets/appBar_widget.dart';
import '../../widgets/app_custom_text.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartPage({super.key, required this.cartItems});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFC),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const MainAppBar(
                    isBackKey: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: (widget.cartItems.length * 380) + 100,
                          child: ListView.builder(
                              itemCount: widget.cartItems.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final product = widget.cartItems[index];
                                return productConatiner(
                                    product['image'],
                                    product['name'],
                                    "₦${product['price']}",
                                    product['inCart'],
                                    index);
                              }),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget productConatiner(
      String image, String name, String price, bool inCart, int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 370,
        width: AppUtils.deviceScreenSize(context).width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              image,
              height: 300,
              width: AppUtils.deviceScreenSize(context).width,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: name,
                        color: AppColors.black,
                        weight: FontWeight.w700,
                      ),
                      CustomText(
                        text: price,
                      ),
                    ],
                  ),
                  SizedBox(),
                 
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}
