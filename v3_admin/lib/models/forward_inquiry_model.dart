import 'package:v3_admin/models/client_model.dart';

class ForwardInquiry {
  final Inquiry inquiry;
  final Client client;
  final List<SupplierInquiry> suppliers;

  ForwardInquiry({
    required this.inquiry,
    required this.client,
    required this.suppliers,
  });

  factory ForwardInquiry.fromJson(List<Map<String, dynamic>> json) {
    return ForwardInquiry(
      inquiry: Inquiry.fromJson(json[0]['Inquiry']),
      client: Client.fromJson(json[1]['Client']),
      suppliers: List<SupplierInquiry>.from(
        json[2]['SupplierInquiry'].map((supplier) => SupplierInquiry.fromJson(supplier)),
      ),
    );
  }
}


class Inquiry {
  final String category;
  final String itemName;
  final String variety;
  final String grade;
  final String origin;
  final int price;
  final int? volume;
  final int hPrice;
  final int hVolume;
  final String unit;
  final int? totalCount;
  final int totalVolume;
  final String hStartDate;
  final String hEndDate;
  final String hDeliveryDate;
  final String startDate;
  final String endDate;
  final String date;
  final String contact;
  final String status;
  final String? assignedAdmin;
  final String memo;

  Inquiry({
    required this.category,
    required this.itemName,
    required this.variety,
    required this.grade,
    required this.origin,
    required this.price,
    this.volume,
    required this.hPrice,
    required this.hVolume,
    required this.unit,
    this.totalCount,
    required this.totalVolume,
    required this.hStartDate,
    required this.hEndDate,
    required this.hDeliveryDate,
    required this.startDate,
    required this.endDate,
    required this.date,
    required this.contact,
    required this.status,
    this.assignedAdmin,
    required this.memo,
  });

  factory Inquiry.fromJson(Map<String, dynamic> json) {
    return Inquiry(
      category: json['category'],
      itemName: json['itemName'],
      variety: json['variety'],
      grade: json['grade'],
      origin: json['origin'],
      price: json['price'],
      volume: json['volume'],
      hPrice: json['hPrice'],
      hVolume: json['hVolume'],
      unit: json['unit'],
      totalCount: json['totalCount'],
      totalVolume: json['totalVolume'],
      hStartDate: json['hStartDate'],
      hEndDate: json['hEndDate'],
      hDeliveryDate: json['hDeliveryDate'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      date: json['date'],
      contact: json['contact'],
      status: json['status'],
      assignedAdmin: json['assignedAdmin'],
      memo: json['memo'],
    );
  }
}

class SupplierInquiry {
  final String supplierId;
  final String name;
  final int cost;
  final int volume;
  final int totalAmount;

  SupplierInquiry({
    required this.supplierId,
    required this.name,
    required this.cost,
    required this.volume,
    required this.totalAmount,
  });

  factory SupplierInquiry.fromJson(Map<String, dynamic> json) {
    return SupplierInquiry(
      supplierId: json['supplier_id'],
      name: json['name'],
      cost: json['cost'],
      volume: json['volume'],
      totalAmount: json['totalAmount'],
    );
  }
}
