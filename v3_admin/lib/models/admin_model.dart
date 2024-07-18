class Admin {
  final String name;
  final String contact;
  final String email;
  final String status;
  final String joinDate;
  final String permission;
  final String division;

  Admin({
    required this.name,
    required this.contact,
    required this.email,
    required this.status,
    required this.joinDate,
    required this.permission,
    required this.division,
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      name: json['name'],
      contact: json['contact'],
      email: json['email'],
      status: json['status'],
      joinDate: json['join_date'],
      permission: json['permission'],
      division: json['div'],
    );
  }
}
