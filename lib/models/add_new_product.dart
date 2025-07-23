
class ProductModel {
  final String? id;
  final String? ProductName;
  final String? ProductCode;
  final String? image;
  final String? UnitPrice;
  final String? Qty;
  final String? TotalPrice;
  final String? CreatedData;

  ProductModel({
    this.id,
    this.ProductName,
    this.ProductCode,
    this.image,
    this.UnitPrice,
    this.Qty,
    this.TotalPrice,
    this.CreatedData,
  });


  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString(),
      ProductName: json['ProductName'],
      ProductCode: json['ProductCode'],
      image: json['Img'],
      UnitPrice: json['UnitPrice'],
      Qty: json['Qty'],
      TotalPrice: json['TotalPrice'],
      CreatedData: json['CreatedDate'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "ProductName": ProductName,
      "ProductCode": ProductCode,
      "Img": image,
      "UnitPrice": UnitPrice,
      "Qty": Qty,
      "TotalPrice": TotalPrice,
    };
  }
}
