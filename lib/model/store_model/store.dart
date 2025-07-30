class StoreResponse {
  final PageObject pageObj;
  final String pageName;

  StoreResponse({
    required this.pageObj,
    required this.pageName,
  });

  factory StoreResponse.fromJson(Map<String, dynamic> json) {
    return StoreResponse(
      pageObj: PageObject.fromJson(json['page_obj']),
      pageName: json['page_name'],
    );
  }
}

class PageObject {
  final List<Product> objectList;
  final int number;
  final int numPages;
  final bool hasNext;
  final bool hasPrevious;
  final int? nextPageNumber;
  final int? previousPageNumber;

  PageObject({
    required this.objectList,
    required this.number,
    required this.numPages,
    required this.hasNext,
    required this.hasPrevious,
    this.nextPageNumber,
    this.previousPageNumber,
  });

  factory PageObject.fromJson(Map<String, dynamic> json) {
    return PageObject(
      objectList: (json['object_list'] as List)
          .map((item) => Product.fromJson(item))
          .toList(),
      number: json['number'],
      numPages: json['num_pages'],
      hasNext: json['has_next'],
      hasPrevious: json['has_previous'],
      nextPageNumber: json['next_page_number'],
      previousPageNumber: json['previous_page_number'],
    );
  }
}

class Product {
  final int id;
  final String name;
  final String namePlural;
  final String description;
  final String unitMeasurement;
  final int unitQuantity;
  final String unitPrice;
  final DateTime dateAdded;
  final int stockQuantity;
  final bool hidden;
  final List<int> categories;
  final List<int> tags;

  Product({
    required this.id,
    required this.name,
    required this.namePlural,
    required this.description,
    required this.unitMeasurement,
    required this.unitQuantity,
    required this.unitPrice,
    required this.dateAdded,
    required this.stockQuantity,
    required this.hidden,
    required this.categories,
    required this.tags,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      namePlural: json['name_plural'],
      description: json['description'],
      unitMeasurement: json['unit_measurement'],
      unitQuantity: json['unit_quantity'],
      unitPrice: json['unit_price'],
      dateAdded: DateTime.parse(json['date_added']),
      stockQuantity: json['stock_quantity'],
      hidden: json['hidden'],
      categories: List<int>.from(json['categories']),
      tags: List<int>.from(json['tags']),
    );
  }

  double get priceAsDouble => double.parse(unitPrice);
}