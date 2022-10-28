/// id : "1"
/// name : "Lunch"
/// slog : null
/// thumbnail : "https://cloudtiffin.com/uploads/thumbnails/category_thumbnails/depositphotos_314274818-stock-photo-abstract-photo-with-stacked-coins.jpeg"
/// status : "1"
/// created_at : "2022-03-26 12:14:21"
/// updated_at : null

class CategoryModel {
  CategoryModel({
      this.id, 
      this.name, 
      this.slog, 
      this.thumbnail, 
      this.status, 
      this.createdAt, 
      this.updatedAt,});

  CategoryModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    slog = json['slog'];
    thumbnail = json['thumbnail'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  String? id;
  String? name;
  dynamic slog;
  String? thumbnail;
  String? status;
  String? createdAt;
  dynamic updatedAt;
CategoryModel copyWith({  String? id,
  String? name,
  dynamic slog,
  String? thumbnail,
  String? status,
  String? createdAt,
  dynamic updatedAt,
}) => CategoryModel(  id: id ?? this.id,
  name: name ?? this.name,
  slog: slog ?? this.slog,
  thumbnail: thumbnail ?? this.thumbnail,
  status: status ?? this.status,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['slog'] = slog;
    map['thumbnail'] = thumbnail;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}