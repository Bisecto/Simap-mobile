import 'package:flutter/material.dart';
import 'package:simap/res/app_colors.dart';
import 'package:simap/utills/app_utils.dart';
import 'package:simap/view/widgets/app_custom_text.dart';

class StoreFilter extends StatefulWidget {
  final ValueChanged<String> selectedFilterItems;

  const StoreFilter({
    super.key,
    required this.selectedFilterItems,
  });

  @override
  State<StoreFilter> createState() => _StoreFilterState();
}

class _StoreFilterState extends State<StoreFilter> {
  final List<String> filterItems = ['Recommended', 'All', 'Newly Added', 'Popular'];

  String selectedFilterItems = 'Recommended';
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: filterItems.length,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedFilterItems = filterItems[index];
                widget.selectedFilterItems(selectedFilterItems);
              });
              _scrollToIndex(index);
            },
            child: filterItemsContainer(filterItems: filterItems[index], context: context),
          );
        },
      ),
    );
  }

  void _scrollToIndex(int index) {
    double offset = (index * (AppUtils.deviceScreenSize(context).width / 3)) -
        (AppUtils.deviceScreenSize(context).width / 2) +
        (AppUtils.deviceScreenSize(context).width / 6);
    _scrollController.animateTo(
      offset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Widget filterItemsContainer({required String filterItems, required context}) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        height: 50,
        width: AppUtils.deviceScreenSize(context).width / 3,
        decoration: BoxDecoration(
          color:
          selectedFilterItems == filterItems ? AppColors.mainAppColor : AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: CustomText(
            text: filterItems,
            size: 16,
            weight: FontWeight.w600,
            color: selectedFilterItems == filterItems ? AppColors.white : AppColors.textColor,
          ),
        ),
      ),
    );
  }
}
