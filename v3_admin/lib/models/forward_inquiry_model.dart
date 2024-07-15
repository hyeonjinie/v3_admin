class ForwardInquiry {
  final String category;
  final String variety;
  final String grade;
  final String origin;
  final int price;
  final int volume;
  final int hPrice;
  final int hVolume;
  final String unit;
  final int totalCount;
  final int totalVolume;
  final String hStartDate;
  final String hEndDate;
  final String hDeliveryDate;
  final String startDate;
  final String endDate;
  final String date;
  final String contact;
  final String status;
  final String assignedAdmin;
  final String memo;
  final String companyName;
  final String bizRegiNum;
  final String bizField;
  final String bizType;
  final String manager;
  final String mgr_contact;
  final String email;
  final String address;
  final String bankImg;


  ForwardInquiry({
    required this.category,
    required this.variety,
    required this.grade,
    required this.origin,
    required this.price,
    required this.volume,
    required this.hPrice,
    required this.hVolume,
    required this.unit,
    required this.totalCount,
    required this.totalVolume,
    required this.hStartDate,
    required this.hEndDate,
    required this.hDeliveryDate,
    required this.startDate,
    required this.endDate,
    required this.date,
    required this.contact,
    required this.status,
    required this.assignedAdmin,
    required this.memo,
    required this.companyName,
    required this.bizRegiNum,
    required this.bizField,
    required this.bizType,
    required this.manager,
    required this.mgr_contact,
    required this.email,
    required this.address,
    required this.bankImg,
  });

  factory ForwardInquiry.fromJson(Map<String, dynamic> json) {
    return ForwardInquiry(
      category: json['category'] ?? '', 
      variety: json['variety'] ?? '', 
      grade: json['grade'] ?? '', 
      origin:json['origin'] ?? '', 
      price: json['price'] ?? '', 
      volume: json['volume'] ?? '', 
      hPrice: json['hPrice'] ?? '',  
      hVolume: json['hVolume'] ?? '', 
      unit: json['unit'] ?? '',  
      totalCount: json['totalCount'] ?? '', 
      totalVolume: json['totalVolume'] ?? '', 
      hStartDate: json['hStartDate'] ?? '', 
      hEndDate: json['hEndDate'] ?? '', 
      hDeliveryDate: json['hDeliveryDate'] ?? '', 
      startDate: json['startDate'] ?? '', 
      endDate: json['endDate'] ?? '', 
      date: json['date'] ?? '', 
      contact: json['contact'] ?? '', 
      status: json['status'] ?? '',  
      assignedAdmin: json['assignedAdmin'] ?? '', 
      memo: json['memo'] ?? '', 
      companyName: json['companyName'] ?? '', 
      bizRegiNum: json['bizRegiNum'] ?? '', 
      bizField: json['bizField'] ?? '', 
      bizType: json['bizType'] ?? '', 
      manager: json['manager'] ?? '', 
      mgr_contact: json['mgr_contact'] ?? '', 
      email: json['email'] ?? '', 
      address: json['address'] ?? '',  
      bankImg: json['bankImg'] ?? '', 
      );
  }

  

}