class Client {
  final String companyName;
  final String bizRegiNum;
  final String bizField;
  final String bizType;
  final String manager;
  final String contact;
  final String email;
  final String address;
  final String? bankImg;

  Client({
    required this.companyName,
    required this.bizRegiNum,
    required this.bizField,
    required this.bizType,
    required this.manager,
    required this.contact,
    required this.email,
    required this.address,
    this.bankImg,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      companyName: json['companyName'],
      bizRegiNum: json['bizRegiNum'],
      bizField: json['bizField'],
      bizType: json['bizType'],
      manager: json['manager'],
      contact: json['contact'],
      email: json['email'],
      address: json['address'],
      bankImg: json['bankImg'],
    );
  }
}
