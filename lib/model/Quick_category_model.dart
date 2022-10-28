class QuickCategoryModel {
  QuickCategoryModel({
    this.id,
    this.shopName,
    this.shopAddress,
    this.shopImage,
    this.userImage,
    this.latitude,
    this.longitude,
    this.openingTime,
    this.clossingTime,
    this.breakfastOpen,
    this.breakfastClose,
    this.lunchOpen,
    this.lunchClose,
    this.dinnerOpen,
    this.dinnerClose,
    this.deliveryTime,
    this.deliveryArea,
    this.deliveryType,
    this.deliveryDay,
    // this.subscriptionId,
    this.distance,
    this.description,
    this.products,
  });

  QuickCategoryModel.fromJson(dynamic json) {
    id = json['id'];

    shopName = json['shop_name'];
    shopAddress = json['shop_address'];
    shopImage = json['shop_image'];

    userImage = json['user_image'];
    latitude = json['latitude'];
    longitude = json['longitude'];

    openingTime = json['opening_time'];
    clossingTime = json['clossing_time'];
    breakfastOpen = json['breakfast_open'];
    breakfastClose = json['breakfast_close'];
    lunchOpen = json['lunch_open'];
    lunchClose = json['lunch_close'];
    dinnerOpen = json['dinner_open'];
    dinnerClose = json['dinner_close'];
    deliveryTime = json['delivery_time'];
    deliveryArea = json['delivery_area'];
    deliveryType = json['delivery_type'];
    deliveryDay = json['delivery_day'];
    description = json['description'];

    distance = json['distance'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
  }

  String? id;

  String? status;
  String? createdAt;
  String? updatedAt;
  String? deviceToken;
  String? shopName;
  String? shopAddress;
  String? shopImage;

  String? userImage;

  String? latitude;
  String? longitude;

  String? openingTime;
  String? clossingTime;
  String? breakfastOpen;
  String? breakfastClose;
  String? lunchOpen;
  String? lunchClose;
  String? dinnerOpen;
  String? dinnerClose;
  String? deliveryTime;
  String? deliveryArea;
  String? deliveryType;
  String? deliveryDay;

  String? distance;
  String? description;
  List<Products>? products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;

    map['shop_name'] = shopName;
    map['shop_address'] = shopAddress;
    map['shop_image'] = shopImage;

    map['user_image'] = userImage;
    map['latitude'] = latitude;
    map['longitude'] = longitude;

    map['opening_time'] = openingTime;
    map['clossing_time'] = clossingTime;
    map['breakfast_open'] = breakfastOpen;
    map['breakfast_close'] = breakfastClose;
    map['lunch_open'] = lunchOpen;
    map['lunch_close'] = lunchClose;
    map['dinner_open'] = dinnerOpen;
    map['dinner_close'] = dinnerClose;
    map['delivery_time'] = deliveryTime;
    map['delivery_area'] = deliveryArea;
    map['delivery_type'] = deliveryType;
    map['delivery_day'] = deliveryDay;
    map['description'] = description;

    map['distance'] = distance;
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Products {
  Products({
    this.id,
    this.name,
    this.vendorId,
    this.categoryId,
    this.qty,
    this.leftqty,
    this.price,
    this.discount,
    this.discountStatus,
    this.description,
    this.thumbnail,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.isQty,
    this.isSelected,
  });

  Products.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    vendorId = json['vendor_id'];
    categoryId = json['category_id'];
    qty = json['qty'];
    leftqty = json['left_qty'];
    price = json['price'];
    discount = json['discount'];
    discountStatus = json['discount_status'];
    description = json['description'];
    thumbnail = json['thumbnail'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isSelected = false;
    isQty = 0;
  }

  String? id;
  String? name;
  String? vendorId;
  String? categoryId;
  String? qty;
  String? leftqty;
  String? price;
  String? discount;
  String? discountStatus;
  String? description;
  String? thumbnail;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? isQty;
  bool? isSelected;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['vendor_id'] = vendorId;
    map['category_id'] = categoryId;
    map['qty'] = qty;
    map['left_qty'] = leftqty;
    map['price'] = price;
    map['discount'] = discount;
    map['discount_status'] = discountStatus;
    map['description'] = description;
    map['thumbnail'] = thumbnail;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['false'] = isSelected;
    map['0'] = isQty;
    return map;
  }
}