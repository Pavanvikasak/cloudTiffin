
class KitchenModel {
  KitchenModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.phone,
    this.location,
    this.gender,
    this.otp,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deviceToken,
    this.shopName,
    this.shopAddress,
    this.shopImage,
    this.wallet,
    this.lastActive,
    this.phoneVerify,
    this.emailVerify,
    this.aadhar,
    this.aadharFront,
    this.aadharBack,
    this.pincode,
    this.commision,
    this.userImage,
    this.homeOrder,
    this.latitude,
    this.longitude,
    this.vacination,
    this.serviceCount,
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
    this.subscriptionId,
    this.products,});

  KitchenModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    location = json['location'];
    gender = json['gender'];
    otp = json['otp'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deviceToken = json['device_token'];
    shopName = json['shop_name'];
    shopAddress = json['shop_address'];
    shopImage = json['shop_image'];
    wallet = json['wallet'];
    lastActive = json['last_active'];
    phoneVerify = json['phone_verify'];
    emailVerify = json['email_verify'];
    aadhar = json['aadhar'];
    aadharFront = json['aadhar_front'];
    aadharBack = json['aadhar_back'];
    pincode = json['pincode'];
    commision = json['commision'];
    userImage = json['user_image'];
    homeOrder = json['home_order'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    vacination = json['vacination'];
    serviceCount = json['service_count'];
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
    subscriptionId = json['subscription_id'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
  }
  String? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? location;
  String? gender;
  String? otp;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? deviceToken;
  String? shopName;
  String? shopAddress;
  String? shopImage;
  dynamic wallet;
  dynamic lastActive;
  String? phoneVerify;
  dynamic emailVerify;
  String? aadhar;
  String? aadharFront;
  String? aadharBack;
  String? pincode;
  String? commision;
  String? userImage;
  dynamic homeOrder;
  String? latitude;
  String? longitude;
  dynamic vacination;
  String? serviceCount;
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
  String? subscriptionId;
  List<Products>? products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;
    map['phone'] = phone;
    map['location'] = location;
    map['gender'] = gender;
    map['otp'] = otp;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['device_token'] = deviceToken;
    map['shop_name'] = shopName;
    map['shop_address'] = shopAddress;
    map['shop_image'] = shopImage;
    map['wallet'] = wallet;
    map['last_active'] = lastActive;
    map['phone_verify'] = phoneVerify;
    map['email_verify'] = emailVerify;
    map['aadhar'] = aadhar;
    map['aadhar_front'] = aadharFront;
    map['aadhar_back'] = aadharBack;
    map['pincode'] = pincode;
    map['commision'] = commision;
    map['user_image'] = userImage;
    map['home_order'] = homeOrder;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['vacination'] = vacination;
    map['service_count'] = serviceCount;
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
    map['subscription_id'] = subscriptionId;
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