import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:v3_admin/common_widget/common_widgets.dart';
import 'package:v3_admin/common_widget/layout.dart';
import 'package:v3_admin/common_widget/naviagtion_helper.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'dart:io';

final NumberFormat currencyFormat = NumberFormat('#,##0', 'en_US');

final List<Map<String, dynamic>> forward_inquiry = [
  {
    "Inquiry": {
      "category": "일반",
      "itemName": "딸기",
      "variety": "설향",
      "grade": "상",
      "origin": "우리집",
      "price": 100,
      "volume": null,
      "hPrice": 500,
      "hVolume": 20000,
      "unit": "string",
      "totalCount": null,
      "totalVolume": 10000,
      "hStartDate": "2024-07-10",
      "hEndDate": "2027-07-11",
      "hDeliveryDate": "2024-07-10",
      "startDate": "2024-05-25",
      "endDate": "2024-07-25",
      "date": "2024-07-10",
      "contact": "123123213",
      "status": "진행",
      "assignedAdmin": null,
      "memo": "으아아아악"
    }
  },
  {
    "Client": {
      "companyName": "에스앤이컴퍼니",
      "bizRegiNum": "12345611",
      "bizField": "업종",
      "bizType": "업태",
      "manager": "강현구",
      "contact": "1231424",
      "email": "hgkang@bgood.co.kr",
      "address": "서울",
      "bankImg": null
    }
  },
  {
    "Supplier": [
      {
        "supplier_id": "I5winMNcKwNVGHkC4O8H",
        "name": "채소회사",
        "cost": 1000,
        "volume": 18000,
        "totalAmount": 18000000
      }
    ]
  }
];

// 공급처 목록
final List<Map<String, dynamic>> suppliersList = [
  {
    'supplierName': 'a',
    "bizRegiNum": "123456789",
  },
  {
    'supplierName': 'b',
    "bizRegiNum": "123456789",
  },
  {
    'supplierName': 'c',
    "bizRegiNum": "123456789",
  },
  {
    'supplierName': 'd',
    "bizRegiNum": "123456789",
  },
  {
    'supplierName': 'e',
    "bizRegiNum": "123456789",
  },
  {
    'supplierName': 'f',
    "bizRegiNum": "123456789",
  },
];

// 등록된 공급처
List<Map<String, dynamic>> supplierInfo = [
  {
    'supplierName': '한결농산',
    "bizRegiNum": "123456789",
    'cost': 1600,
    'volume': 6000,
    'totalAmount': 9600000,
  },
  {
    'supplierName': '냠냠농산',
    "bizRegiNum": "123456789",
    'cost': 1800,
    'volume': 2000,
    'totalAmount': 3600000,
  },
  {
    'supplierName': '꿀꿀농산',
    "bizRegiNum": "123456789",
    'cost': 1800,
    'volume': 2000,
    'totalAmount': 3600000,
  },
];

class InquiryDetail extends StatefulWidget {
  const InquiryDetail({super.key});

  @override
  State<InquiryDetail> createState() => _InquiryDetailState();
}

class _InquiryDetailState extends State<InquiryDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectIndex = 2; // GNB : 운영관리
  int selectedMenu = 1; // SUB : 선도거래 > 문의/계약

  void _updateIndex(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        key: _scaffoldKey,
        selectedPageIndex: _selectIndex,
        onItemTapped: (index) =>
            NavigationHelper.onItemTapped(context, index, _updateIndex),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                // Left Navigation Bar (LNB)
                Container(
                  width: 200.0,
                  color: Color(0xFF292F3D),
                  child: Column(
                    children: [
                      ProfileWidget(),
                      SizedBox(height: 10),
                      SubMenuWidget(
                        label: '선도거래',
                        selectedMenu: selectedMenu,
                        onTap: (index) {
                          setState(() {
                            selectedMenu = index;
                          });
                          if (index == 1) {
                            context.go('/operation');
                          } else if (index == 2) {
                            context.go('/progress');
                          } else if (index == 3) {
                            context.go('/completed');
                          }
                        },
                        items: [
                          SubMenuItem(
                            label: '문의/계약',
                            index: 1,
                          ),
                          SubMenuItem(
                            label: '진행',
                            index: 2,
                          ),
                          SubMenuItem(
                            label: '완료',
                            index: 3,
                          ),
                        ],
                        isExpanded: true,
                      ),
                      SubMenuWidget(
                        label: '비굿마켓',
                        selectedMenu: selectedMenu,
                        onTap: (index) {
                          setState(() {
                            selectedMenu = index;
                          });
                          if (index == 4) {
                            context.go('/order');
                          } else if (index == 5) {
                            context.go('/cancel');
                          }
                        },
                        items: [
                          SubMenuItem(
                            label: '주문',
                            index: 4,
                          ),
                          SubMenuItem(
                            label: '반품/취소',
                            index: 5,
                          ),
                        ],
                        isExpanded: false,
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DetailView(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DetailView extends StatefulWidget {
  const DetailView({super.key});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  bool isEditing = false;
  late Map<String, TextEditingController> controllers;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  late TextEditingController memoController;

  Uint8List? _accountImgData;
  final ImagePicker picker = ImagePicker();

  Future<void> getAccountImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      final Uint8List fileBytes = await pickedFile.readAsBytes();
      setState(() {
        _accountImgData = fileBytes;
      });
    }
  }

  late Map<String, dynamic> inquiryInfo;
  late Map<String, dynamic> memberInfo;

  @override
  void initState() {
    super.initState();

    dynamic inquiry = forward_inquiry
        .firstWhere((element) => element.containsKey('Inquiry'))['Inquiry'];
    dynamic client = forward_inquiry
        .firstWhere((element) => element.containsKey('Client'))['Client'];

    String itemName = inquiry['itemName'] ?? '';
    String variety = inquiry['variety'] ?? '';
    String grade = inquiry['grade'] ?? '';
    String origin = inquiry['origin'] ?? '';
    int price = inquiry['status'] != '대기'
        ? (inquiry['price'] ?? 0)
        : (inquiry['hPrice'] ?? 0);
    int volume = inquiry['status'] != '대기'
        ? (inquiry['volume'] ?? 0)
        : (inquiry['hVolume'] ?? 0);
    int totalCount = inquiry['totalCount'] ?? 0;
    String startDate = inquiry['status'] != '대기'
        ? (inquiry['startDate'] ?? '')
        : (inquiry['hStartDate'] ?? '');
    String endDate = inquiry['status'] != '대기'
        ? (inquiry['endDate'] ?? '')
        : (inquiry['hEndDate'] ?? '');
    String hDeliveryDate = inquiry['hDeliveryDate'] ?? '';
    int totalAmount = inquiry['status'] != '대기'
        ? (inquiry['totalAmount'] ?? 0)
        : (inquiry['hTotalAmount'] ?? 0);
    String contact = inquiry['contact'] ?? '';
    String memo = inquiry['memo'] ?? '';
    String companyName = client['companyName'] ?? '';
    String bizRegiNum = client['bizRegiNum'] ?? '';
    String bizField = client['bizField'] ?? '';
    String bizType = client['bizType'] ?? '';
    String manager = client['manager'] ?? '';
    String mgrContact = client['contact'] ?? '';
    String email = client['email'] ?? '';
    String address = client['address'] ?? '';

    // 문의내용
    inquiryInfo = {
      '품목': itemName,
      '품종': variety,
      '등급': grade,
      '원산지': origin,
      '단가': price.toString(),
      '공급물량': volume.toString(),
      '거래횟수': totalCount.toString(),
      '공급기간': startDate + ' ~ ' + endDate,
      '희망배송일': hDeliveryDate,
      '총 금액': totalAmount.toString(),
      '담당자 연락처': contact,
      '통장사본':
          'https://firebasestorage.googleapis.com/v0/b/v3mvp-b9aa4.appspot.com/o/uploads%2Fregister%2Fclient%2FIdyZUA7S6CcsbeKu7h7Gj8k9zpB2%2Fbusiness_registration_image?alt=media&token=7a17324f-6e09-4520-b4ef-6d4ddc4c29ae'
    };

    // 기업정보
    memberInfo = {
      '업체명': companyName,
      '사업자등록번호': bizRegiNum,
      '업태/종목': bizField + ' / ' + bizType,
      '담당자명': manager,
      '담당자 연락처': mgrContact,
      '이메일': email,
      '사업장 주소': address,
    };

    controllers = {
      for (var entry in inquiryInfo.entries)
        entry.key: TextEditingController(text: entry.value)
    };
    startDateController = TextEditingController(text: startDate);
    endDateController = TextEditingController(text: endDate);
    memoController = TextEditingController(text: memo);
  }

  @override
  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    startDateController.dispose();
    endDateController.dispose();
    memoController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        controller.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  String getDisplayValue(String key, String value) {
    switch (key) {
      case '단가':
      case '총 금액':
        return value + '원';
      case '공급물량':
        return value + 'kg';
      case '거래횟수':
        return value + '회';
      default:
        return value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(30.0),
          color: Color(0xFFF9FCFE),
          child: Column(
            children: [
              // 디테일 페이지 상단 영역
              Row(
                children: [
                  const Text(
                    '{선도거래 타이틀(거래명)}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  CustomElevatedButton1(
                    backgroundColor: Color(0xFF5D75BF),
                    text: isEditing ? '저장' : '수정',
                    onPressed: () {
                      setState(() {
                        if (isEditing) {
                          inquiryInfo.updateAll((key, value) {
                            return controllers[key]!.text;
                          });
                          inquiryInfo['공급기간'] = startDateController.text +
                              ' ~ ' +
                              endDateController.text;
                        }

                        isEditing = !isEditing;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CustomElevatedButton2(
                    text: '목록',
                    backgroundColor: Colors.white,
                    textColor: Color(0xFF9A9A9A),
                    borderColor: Color(0xFFD6D6D6),
                    onPressed: () {
                      context.go('/operation');
                    },
                  ),
                ],
              ),

              // 디테일 페이지 내용 영역
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  width: double.infinity,
                  decoration: commonBoxDecoration,
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              // 담당자 지정
                              Container(
                                width: double.infinity,
                                height: 45,
                                color: Color(0xFFF9FCFE),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Text(
                                        '담당자 : 이준형',
                                        style: TextStyle(
                                          color: Color(0xFF323232),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    const Text(
                                      '2024-06-17',
                                      style: TextStyle(
                                        color: Color(0xFF323232),
                                        fontSize: 14,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: OutlinedButton(
                                        onPressed: () {},
                                        style: OutlinedButton.styleFrom(
                                          side: const BorderSide(
                                              color: Color(0xFFD6D6D6)),
                                          backgroundColor: Colors.white,
                                        ),
                                        child: const Text(
                                          '나에게 배정',
                                          style: TextStyle(
                                            color: Color(0xFF323232),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),

                              // 문의내용
                              TableBar(titleText: '문의내용'),
                              Container(
                                width: double.infinity,
                                child: Table(
                                  border: const TableBorder(
                                    top: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                    bottom: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                    verticalInside: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                    horizontalInside: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                  ),
                                  columnWidths: const {
                                    0: FractionColumnWidth(0.3),
                                    1: FractionColumnWidth(0.7),
                                  },
                                  children: inquiryInfo.entries.map((entry) {
                                    return TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 20),
                                          child: Text(
                                            entry.key,
                                            style: const TextStyle(
                                              color: Color(0xFF323232),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 20),
                                          child: entry.key == '통장사본'
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        _accountImgData != null
                                                            ? Image.memory(
                                                                _accountImgData!,
                                                                height: 100,
                                                                fit: BoxFit
                                                                    .contain,
                                                              )
                                                            : Image.network(
                                                                entry.value,
                                                                height: 100,
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                        if (isEditing)
                                                          Container(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          10.0),
                                                              child:
                                                                  CustomElevatedButton1(
                                                                      backgroundColor:
                                                                          const Color(
                                                                              0xFF5D75BF),
                                                                      text:
                                                                          '파일선택',
                                                                      onPressed:
                                                                          () {
                                                                        getAccountImage(
                                                                            ImageSource.gallery);
                                                                      }),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              : isEditing
                                                  ? entry.key == '공급기간'
                                                      ? Row(
                                                          children: [
                                                            Container(
                                                              width: 180,
                                                              height: 45,
                                                              child:
                                                                  CustomDatePickerField(
                                                                controller:
                                                                    startDateController,
                                                                onDateTap:
                                                                    _selectDate,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 10),
                                                            const Text('~'),
                                                            const SizedBox(
                                                                width: 10),
                                                            Container(
                                                              width: 180,
                                                              height: 45,
                                                              child:
                                                                  CustomDatePickerField(
                                                                controller:
                                                                    endDateController,
                                                                onDateTap:
                                                                    _selectDate,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : Container(
                                                          width: 350,
                                                          height: 45,
                                                          child: TextFormField(
                                                            controller:
                                                                controllers[
                                                                    entry.key],
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                            decoration:
                                                                InputDecoration(
                                                              hintText: entry
                                                                  .value
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          r'[^\d.]'),
                                                                      ''),
                                                              border:
                                                                  const OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFFD1D1D1),
                                                                ),
                                                              ),
                                                              enabledBorder:
                                                                  const OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFFD1D1D1),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                  : Text(
                                                      getDisplayValue(entry.key,
                                                          entry.value),
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFF323232),
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // 상태 변경
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const SizedBox(
                                    width: 90,
                                    child: Text(
                                      '상태 변경',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SelectBoxExample(
                                    initialValue: '대기중',
                                    options: const [
                                      '대기중',
                                      '진행중',
                                      '완료',
                                      '취소',
                                    ],
                                    onChanged: (String? newValue) {
                                      setState(() {});
                                    },
                                    custom_width: 220.0,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  CustomElevatedButton1(
                                    backgroundColor: Color(0xFF5D75BF),
                                    text: '저장',
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // 기업 정보
                              TableBar(titleText: '기업 정보'),
                              Container(
                                width: double.infinity,
                                child: Table(
                                  border: const TableBorder(
                                    top: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                    bottom: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                    verticalInside: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                    horizontalInside: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                  ),
                                  columnWidths: const {
                                    0: FractionColumnWidth(0.3),
                                    1: FractionColumnWidth(0.7),
                                  },
                                  children: memberInfo.entries.map((entry) {
                                    return TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 20),
                                          child: Text(
                                            entry.key,
                                            style: const TextStyle(
                                              color: Color(0xFF323232),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 20),
                                          child: Text(
                                            entry.value,
                                            style: const TextStyle(
                                              color: Color(0xFF323232),
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: SuppliersButtons(
                                  suppliers: supplierInfo,
                                  isAdd: isEditing ? true : false,
                                  isSub: false,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // 메모
                              TableBar(titleText: '메모'),
                              Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xFFD6D6D6),
                                  ),
                                ),
                                child: isEditing
                                    ? TextField(
                                        controller: memoController,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        expands: true,
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(8.0),
                                          border: InputBorder.none,
                                          hintText: '내용을 입력하세요',
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          memoController.text,
                                          style: const TextStyle(
                                            color: Color(0xFF323232),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// 공급처 영역
class SuppliersButtons extends StatefulWidget {
  final List<dynamic> suppliers;
  final bool isAdd;
  final bool isSub;

  SuppliersButtons(
      {required this.suppliers, required this.isAdd, required this.isSub});

  @override
  _SuppliersButtonsState createState() => _SuppliersButtonsState();
}

class _SuppliersButtonsState extends State<SuppliersButtons> {
  int _selectedSupplierIndex = 0;
  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditDialog(
          suppliers: widget.suppliers,
          onSave: (updatedSuppliers) {
            setState(() {});
          },
        );
      },
    );
  }

  void _showAddSupplierDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddSupplierDialog(
          onSupplierSelected: (selectedSupplier, cost, volume, totalAmount) {
            setState(() {
              supplierInfo.add({
                'supplierName': selectedSupplier['supplierName'],
                'bizRegiNum': selectedSupplier['bizRegiNum'],
                'cost': cost,
                'volume': volume,
                'totalAmount': totalAmount,
              });
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (widget.suppliers == null || widget.suppliers.isEmpty)
              const Expanded(
                child: Row(
                  children: [
                    Text(
                      '공급처 정보 없음',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                  ],
                ),
              )
            else
              Expanded(
                child: Row(
                  children:
                      List<Widget>.generate(widget.suppliers.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedSupplierIndex = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        alignment: Alignment.center,
                        width: 85,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                          border: Border.all(
                              color: _selectedSupplierIndex == index
                                  ? Color(0xFF5D75BF)
                                  : Color(0xFFD6D6D6)),
                        ),
                        child: Text(
                          '공급처${index + 1}',
                          style: TextStyle(
                            color: _selectedSupplierIndex == index
                                ? Color(0xFF5D75BF)
                                : Colors.black,
                            fontWeight: _selectedSupplierIndex == index
                                ? FontWeight.bold
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            if (widget.suppliers != null &&
                widget.suppliers.isNotEmpty &&
                widget.isAdd)
              TextButton(
                onPressed: () {
                  _showEditDialog();
                },
                child: const Text(
                  '편집',
                  style: TextStyle(
                    color: Color(0xFF5D75BF),
                    fontSize: 14,
                  ),
                ),
              ),
            widget.isAdd
                ? OutlinedButton(
                    onPressed: _showAddSupplierDialog,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(0xFFD6D6D6)),
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      '공급처 추가',
                      style: TextStyle(
                        color: Color(0xFF323232),
                        fontSize: 14,
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
        if (widget.suppliers != null && widget.suppliers.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(25.0),
            alignment: Alignment.center,
            height: 170,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              border: Border.all(color: Color(0xFFD6D6D6)),
            ),
            child: Column(
              children: [
                tabTextBox(
                    '업체명 :',
                    '${widget.suppliers[_selectedSupplierIndex!]['supplierName']} / ${widget.suppliers[_selectedSupplierIndex!]['bizRegiNum']}',
                    120),
                const SizedBox(
                  height: 12,
                ),
                tabTextBox(
                    '원물가격 :',
                    '${currencyFormat.format((widget.suppliers[_selectedSupplierIndex!]['cost']))}원',
                    120),
                const SizedBox(
                  height: 12,
                ),
                tabTextBox(
                    '공급물량 :',
                    '${currencyFormat.format(widget.suppliers[_selectedSupplierIndex!]['volume'])}kg',
                    120),
                const SizedBox(
                  height: 12,
                ),
                tabTextBox(
                    '총 금액 :',
                    '${currencyFormat.format(widget.suppliers[_selectedSupplierIndex!]['totalAmount'])}원',
                    120),
              ],
            ),
          ),
      ],
    );
  }
}

// 공급처 편집 팝업창
class EditDialog extends StatefulWidget {
  final List<dynamic> suppliers;
  final Function(List<Map<String, dynamic>>) onSave;

  EditDialog({required this.suppliers, required this.onSave});

  @override
  _EditDialogState createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  late List<Map<String, dynamic>> _tempSuppliers;

  @override
  void initState() {
    super.initState();
    _tempSuppliers = List.from(widget.suppliers);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        width: 570,
        padding: EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              '공급처 정보 편집',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _tempSuppliers.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Color(0xFF5D75BF),
                            ),
                            onPressed: () {
                              setState(() {
                                _tempSuppliers.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                      customTextField(
                          '업체명',
                          '업체명을 입력하세요',
                          TextEditingController(
                            text: _tempSuppliers[index]['supplierName'],
                          ),
                          120),
                      SizedBox(height: 10),
                      customTextField(
                          '사업자등록번호',
                          '사업자등록번호를 입력하세요',
                          TextEditingController(
                            text: _tempSuppliers[index]['bizRegiNum'],
                          ),
                          120),
                      SizedBox(height: 10),
                      customTextField(
                          '원물가격',
                          '원물가격을 입력하세요',
                          TextEditingController(
                            text: _tempSuppliers[index]['cost'].toString(),
                          ),
                          120),
                      SizedBox(height: 10),
                      customTextField(
                          '공급물량',
                          '공급물량을 입력하세요',
                          TextEditingController(
                            text: _tempSuppliers[index]['volume'].toString(),
                          ),
                          120),
                      SizedBox(height: 10),
                      customTextField(
                          '총 금액',
                          '총 금액을 입력하세요',
                          TextEditingController(
                            text:
                                _tempSuppliers[index]['totalAmount'].toString(),
                          ),
                          120),
                      SizedBox(height: 10),
                      const Divider(),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomElevatedButton2(
                  text: '취소',
                  backgroundColor: Colors.white,
                  textColor: Color(0xFF9A9A9A),
                  borderColor: Color(0xFFD6D6D6),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(width: 10),
                CustomElevatedButton1(
                  backgroundColor: Color(0xFF5D75BF),
                  text: '수정',
                  onPressed: () {
                    widget.onSave(_tempSuppliers);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 공급처 추가 팝업창
class AddSupplierDialog extends StatefulWidget {
  final void Function(Map<String, dynamic>, int, int, int) onSupplierSelected;

  const AddSupplierDialog({required this.onSupplierSelected});

  @override
  _AddSupplierDialogState createState() => _AddSupplierDialogState();
}

class _AddSupplierDialogState extends State<AddSupplierDialog> {
  Map<String, dynamic>? _selectedSupplier;
  late TextEditingController priceController; //원물가격
  late TextEditingController volumeController; //공급물량
  late TextEditingController amountController; //총 금액

  @override
  void initState() {
    super.initState();
    priceController = TextEditingController();
    volumeController = TextEditingController();
    amountController = TextEditingController();
  }

  @override
  void dispose() {
    priceController.dispose();
    volumeController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 570,
        padding: EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            const Text(
              '공급처 추가',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFD6D6D6)),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: ListView.builder(
                itemCount: suppliersList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      '${suppliersList[index]['supplierName']} (${suppliersList[index]['bizRegiNum']})',
                    ),
                    onTap: () {
                      setState(() {
                        _selectedSupplier = suppliersList[index];
                      });
                    },
                  );
                },
              ),
            ),
            if (_selectedSupplier != null) ...[
              SizedBox(height: 16),
              Container(
                width: 540,
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFD6D6D6)),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      '공급사명: ${_selectedSupplier!['supplierName']} / 사업자번호: ${_selectedSupplier!['bizRegiNum']}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    customTextField(
                        '원물가격', '(원) 단위로 숫자만 입력', priceController, 120),
                    SizedBox(height: 10),
                    customTextField(
                        '공급물량', '(kg) 단위로 숫자만 입력', volumeController, 120),
                    SizedBox(height: 10),
                    customTextField(
                        '총 금액', '(원) 단위로 숫자만 입력', amountController, 120),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ],
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomElevatedButton2(
                  text: '취소',
                  backgroundColor: Colors.white,
                  textColor: Color(0xFF9A9A9A),
                  borderColor: Color(0xFFD6D6D6),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(width: 10),
                CustomElevatedButton1(
                  backgroundColor: Color(0xFF5D75BF),
                  text: '등록',
                  onPressed: _selectedSupplier == null
                      ? () {
                          Navigator.of(context).pop();
                        }
                      : () {
                          widget.onSupplierSelected(
                            _selectedSupplier!,
                            int.tryParse(priceController.text) ?? 0,
                            int.tryParse(volumeController.text) ?? 0,
                            int.tryParse(amountController.text) ?? 0,
                          );
                          Navigator.of(context).pop();
                        },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
