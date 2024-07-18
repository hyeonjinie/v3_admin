class Supplier {
  final SupplierInfo supplierInfo;
  final AccountInfo accountInfo;
  final ManagerInfo managerInfo;

  Supplier({
    required this.supplierInfo,
    required this.accountInfo,
    required this.managerInfo,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      supplierInfo: SupplierInfo.fromJson(json['supplier_info']),
      accountInfo: AccountInfo.fromJson(json['account_info']),
      managerInfo: ManagerInfo.fromJson(json['manager_info']),
    );
  }
}

class SupplierInfo {
  final String companyNm;
  final String representativeNm;
  final String bizRegiType;
  final String bizRegiNum;
  final String bizField;
  final String bizItem;
  final String bizContact;
  final String bizEmail;
  final String? bizFax;
  final String? bizZipCd;
  final String bizAddr;
  final String bizRegiImg;
  final String? memo;

  SupplierInfo({
    required this.companyNm,
    required this.representativeNm,
    required this.bizRegiType,
    required this.bizRegiNum,
    required this.bizField,
    required this.bizItem,
    required this.bizContact,
    required this.bizEmail,
    this.bizFax,
    this.bizZipCd,
    required this.bizAddr,
    required this.bizRegiImg,
    this.memo,
  });

  factory SupplierInfo.fromJson(Map<String, dynamic> json) {
    return SupplierInfo(
      companyNm: json['company_nm'],
      representativeNm: json['representative_nm'],
      bizRegiType: json['biz_regi_type'],
      bizRegiNum: json['biz_regi_num'],
      bizField: json['biz_field'],
      bizItem: json['biz_item'],
      bizContact: json['biz_contact'],
      bizEmail: json['biz_email'],
      bizFax: json['biz_fax'],
      bizZipCd: json['biz_zip_cd'],
      bizAddr: json['biz_addr'],
      bizRegiImg: json['biz_regi_img'],
      memo: json['memo'],
    );
  }
}

class AccountInfo {
  final String bankNm;
  final String acntOwner;
  final String acntNum;
  final String acntImg;

  AccountInfo({
    required this.bankNm,
    required this.acntOwner,
    required this.acntNum,
    required this.acntImg,
  });

  factory AccountInfo.fromJson(Map<String, dynamic> json) {
    return AccountInfo(
      bankNm: json['bank_nm'],
      acntOwner: json['acnt_owner'],
      acntNum: json['acnt_num'],
      acntImg: json['acnt_img'],
    );
  }
}

class ManagerInfo {
  final String mngrNm;
  final String mngrEmail;
  final String mngrContact;
  final String mngrDept;

  ManagerInfo({
    required this.mngrNm,
    required this.mngrEmail,
    required this.mngrContact,
    required this.mngrDept,
  });

  factory ManagerInfo.fromJson(Map<String, dynamic> json) {
    return ManagerInfo(
      mngrNm: json['mngr_nm'],
      mngrEmail: json['mngr_email'],
      mngrContact: json['mngr_contact'],
      mngrDept: json['mngr_dept'],
    );
  }
}