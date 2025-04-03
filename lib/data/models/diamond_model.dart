// To parse this JSON data, do
//
//     final diamondModel = diamondModelFromJson(jsonString);

import 'dart:convert';

DiamondModel diamondModelFromJson(String str) => DiamondModel.fromJson(json.decode(str));

String diamondModelToJson(DiamondModel data) => json.encode(data.toJson());

class DiamondModel {
  int? qty;
  int? lotId;
  String? size;
  double? carat;
  String? lab;
  String? shape;
  String? color;
  String? clarity;
  String? cut;
  String? polish;
  String? symmetry;
  String? fluorescence;
  double? discount;
  double? perCaratRate;
  double? finalAmount;
  String? keyToSymbol;
  String? labComment;
  bool inCart;

  DiamondModel({
    this.qty,
    this.lotId,
    this.size,
    this.carat,
    this.lab,
    this.shape,
    this.color,
    this.clarity,
    this.cut,
    this.polish,
    this.symmetry,
    this.fluorescence,
    this.discount,
    this.perCaratRate,
    this.finalAmount,
    this.keyToSymbol,
    this.labComment,
    this.inCart = false,
  });

  factory DiamondModel.fromJson(Map<String, dynamic> json) => DiamondModel(
    qty: json["qty"],
    lotId: json["lotId"],
    size: json["size"],
    carat: json["carat"],
    lab: json["lab"],
    shape: json["shape"],
    color: json["color"],
    clarity: json["clarity"],
    cut: json["cut"],
    polish: json["polish"],
    symmetry: json["symmetry"],
    fluorescence: json["fluorescence"],
    discount: json["discount"],
    perCaratRate: json["perCaratRate"],
    finalAmount: json["finalAmount"],
    keyToSymbol: json["keyToSymbol"],
    labComment: json["labComment"],
    inCart: json["inCart"],
  );

  Map<String, dynamic> toJson() => {
    "qty": qty,
    "lotId": lotId,
    "size": size,
    "carat": carat,
    "lab": lab,
    "shape": shape,
    "color": color,
    "clarity": clarity,
    "cut": cut,
    "polish": polish,
    "symmetry": symmetry,
    "fluorescence": fluorescence,
    "discount": discount,
    "perCaratRate": perCaratRate,
    "finalAmount": totalAmount,
    "keyToSymbol": keyToSymbol,
    "labComment": labComment,
    "inCart": inCart,
  };

  double get totalAmount {
    double calculatedAmount = (carat ?? 0) * (perCaratRate ?? 0);
    return calculatedAmount;
  }

  static double calculateTotalCarat(List<DiamondModel> diamonds) {
    return diamonds
        .where((diamond) => diamond.inCart)  // Filter items in cart
        .fold(0.0, (sum, diamond) => sum + (diamond.carat ?? 0)); // Sum carats
  }
  static double calculateTotalDiscount(List<DiamondModel> diamonds) {
    return diamonds
        .where((diamond) => diamond.inCart)  // Filter items in cart
        .fold(0.0, (sum, diamond) => sum + (diamond.discount ?? 0)); // Sum carats
  }
  static double calculateAmount(List<DiamondModel> diamonds) {
    return diamonds
        .where((diamond) => diamond.inCart)  // Filter items in cart
        .fold(0.0, (sum, diamond) => sum + (diamond.perCaratRate ?? 0)); // Sum carats
  }
 static double calculateTotalAmount(List<DiamondModel> diamonds) {
    return diamonds
        .where((diamond) => diamond.inCart)  // Filter items in cart
        .fold(0.0, (sum, diamond) => sum + (diamond.totalAmount)); // Sum carats
  }
}
