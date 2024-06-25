import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:v3_admin/common_widget/common_widgets.dart';
import 'package:v3_admin/common_widget/layout.dart';
import 'package:v3_admin/common_widget/naviagtion_helper.dart';
import 'package:v3_admin/screens/client_mgt/supplier_detail.dart';
import 'package:intl/intl.dart';

final NumberFormat currencyFormat = NumberFormat('#,##0', 'en_US');

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
  late TextEditingController memoController;

  // 문의내용
  final Map<String, String> inquiryInfo = {
    '품목': '사과',
    '품종': '부사',
    '등급': '상',
    '원산지': '경상북도',
    '단가': '1,500원',
    '공급물량': '12,520kg',
    '거래횟수': '',
    '공급기간': '2024-04-24 ~ 2024-10-10',
    '희망배송일': '2024-04-24',
    '총 금액': '18,780,000원',
    '담당자 연락처': '010-1234-1234',
    '통장사본':
        'https://firebasestorage.googleapis.com/v0/b/v3mvp-b9aa4.appspot.com/o/uploads%2Fregister%2Fclient%2FIdyZUA7S6CcsbeKu7h7Gj8k9zpB2%2Fbusiness_registration_image?alt=media&token=7a17324f-6e09-4520-b4ef-6d4ddc4c29ae'
  };

  // 기업정보
  final Map<String, String> memberInfo = {
    '업체명': '비굿컴퍼니',
    '사업자등록번호': '1234567890',
    '업태/종목': '도매/농업',
    '담당자명': '김현진',
    '담당자 연락처': '010-1234-1234',
    '이메일': 'abc@bgood.co.kr',
    '사업장 주소': '서울특별시 서초구 매헌로8길 39, D동 4층 406호(양재동, 희경재단) 테스트테스트테스트테스트',
  };

  // 공급처
  final List<Map<String, dynamic>> _data = [
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

  @override
  void initState() {
    super.initState();
    controllers = {
      for (var entry in inquiryInfo.entries)
        entry.key: TextEditingController(text: entry.value)
    };
    memoController = TextEditingController();
  }

  @override
  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    memoController.dispose();
    super.dispose();
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
                          inquiryInfo.updateAll(
                              (key, value) => controllers[key]!.text);
                        }
                        isEditing = !isEditing;
                      });
                    },
                  ),
                  SizedBox(
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
                  height: isEditing ? 1100 : 1000,
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
                                          side: BorderSide(
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
                              SizedBox(
                                height: 20,
                              ),

                              // 문의내용
                              TableBar(titleText: '문의내용'),
                              Container(
                                width: double.infinity,
                                height: 500,
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
                                                        Image.network(
                                                          entry.value,
                                                          height: 100,
                                                          fit: BoxFit.contain,
                                                        ),
                                                        if (isEditing)
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10.0),
                                                            child: CustomElevatedButton1(
                                                                backgroundColor:
                                                                    Color(
                                                                        0xFF5D75BF),
                                                                text: '파일선택',
                                                                onPressed:
                                                                    () {}),
                                                          ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              : isEditing
                                                  ? Container(
                                                      width: 350,
                                                      height: 45,
                                                      child: TextFormField(
                                                        controller: controllers[
                                                            entry.key],
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                        decoration:
                                                            InputDecoration(
                                                          hintText: entry.value,
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
                                                      entry.value,
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
                        SizedBox(
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
                                  SizedBox(
                                    width: 20,
                                  ),
                                  CustomElevatedButton1(
                                    backgroundColor: Color(0xFF5D75BF),
                                    text: '저장',
                                    onPressed: () {},
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 20,
                              ),

                              // 기업 정보
                              TableBar(titleText: '기업 정보'),
                              Container(
                                width: double.infinity,
                                height: 350,
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
                                  columnWidths: {
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
                              Container(
                                child: SuppliersButtons(
                                  suppliers: _data,
                                  isAdd: isEditing ? true : false,
                                  isSub: false,
                                ),
                              ),
                              SizedBox(
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
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// sub 공급처
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
                    onPressed: () {},
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


// 공급처 편집 
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
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '공급처 정보 편집',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
            ), ),
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
                            icon: Icon(
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
                      ),
                      SizedBox(height: 10),
                      customTextField(
                        '사업자등록번호',
                        '사업자등록번호를 입력하세요',
                        TextEditingController(
                          text: _tempSuppliers[index]['bizRegiNum'],
                        ),
                      ),
                      SizedBox(height: 10),
                      customTextField(
                        '원물가격',
                        '원물가격을 입력하세요',
                        TextEditingController(
                          text: _tempSuppliers[index]['cost'].toString(),
                        ),
                      ),
                      SizedBox(height: 10),
                      customTextField(
                        '공급물량',
                        '공급물량을 입력하세요',
                        TextEditingController(
                          text: _tempSuppliers[index]['volume'].toString(),
                        ),
                      ),
                      SizedBox(height: 10),
                      customTextField(
                        '총 금액',
                        '총 금액을 입력하세요',
                        TextEditingController(
                          text: _tempSuppliers[index]['totalAmount'].toString(),
                        ),
                      ),
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

//   Widget customTextField(String txt, String hint, TextEditingController controller) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           width: 120,
//           child: Text(
//             txt,
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         SizedBox(width: 20),
//         Container(
//           width: 350,
//           height: 45,
//           child: TextFormField(
//             controller: controller,
//             decoration: InputDecoration(
//               hintText: hint,
//               border: OutlineInputBorder(
//                 borderSide: BorderSide(
//                   color: Color(0xFFD1D1D1),
//                 ),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(
//                   color: Color(0xFFD1D1D1),
//                 ),
//               ),
//               contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
}
