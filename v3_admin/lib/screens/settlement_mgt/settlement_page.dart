import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:v3_admin/common_widget/common_widgets.dart';
import 'package:v3_admin/common_widget/layout.dart';
import 'package:v3_admin/common_widget/naviagtion_helper.dart';
import 'package:intl/intl.dart';

final NumberFormat currencyFormat = NumberFormat('#,##0', 'en_US');

class SettlementPage extends StatefulWidget {
  const SettlementPage({super.key});

  @override
  State<SettlementPage> createState() => _SettlementPageState();
}

class _SettlementPageState extends State<SettlementPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectIndex = 3; // GNB : 정산관리
  int selectedMenu = 1; // SUB : 정산관리 > 정산

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
                        label: '정산관리',
                        selectedMenu: selectedMenu,
                        onTap: (index) {
                          setState(() {
                            selectedMenu = index;
                          });
                          if (index == 1) {
                            context.go('/settlement');
                          } else if (index == 2) {
                            context.go('/taxbill');
                          } else if (index == 3) {
                            context.go('/settle-forward');
                          } else if (index == 4) {
                            context.go('/settle-market');
                          }
                        },
                        items: [
                          SubMenuItem(
                            label: '정산',
                            index: 1,
                          ),
                          SubMenuItem(
                            label: '세금계산서',
                            index: 2,
                          ),
                          SubMenuItem(
                            label: '선도주문',
                            index: 3,
                          ),
                          SubMenuItem(
                            label: '비굿마켓',
                            index: 4,
                          ),
                        ],
                        isExpanded: true,
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SettlementList(),
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

class SettlementList extends StatefulWidget {
  const SettlementList({super.key});

  @override
  State<SettlementList> createState() => _SettlementListState();
}

class _SettlementListState extends State<SettlementList> {
  int _rowsPerPage = 10;
  int _pageIndex = 0;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  late TextEditingController searchController;
  late List<Map<String, dynamic>> _filteredData;
  late List<bool> isSelected;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    _filteredData = _data;
    startDateController = TextEditingController();
    endDateController = TextEditingController();
    searchController = TextEditingController();
    selectedDate = DateTime.now();
    isSelected = [false, false, true];
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  //날짜 토글 옵션
    void _setDateRange(int index) {
    DateTime now = DateTime.now();
    DateTime startDate;
    DateTime endDate = now;

    switch (index) {
      case 0: // 지난달
        startDate = DateTime(now.year, now.month - 1, 1);
        endDate = DateTime(now.year, now.month, 0);
        break;
      case 1: // 이번달
        startDate = DateTime(now.year, now.month, 1);
        endDate = now;
        break;
      case 2: // 올해
        startDate = DateTime(now.year, 1, 1);
        endDate = now;
        break;
      default:
        startDate = now;
        endDate = now;
    }

    setState(() {
      startDateController.text = DateFormat('yyyy-MM-dd').format(startDate);
      endDateController.text = DateFormat('yyyy-MM-dd').format(endDate);
    });
  }

  final List<Map<String, dynamic>> _data = [
    {
      '거래명': '[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)',
      '거래유형': '선도거래',
      '업체명': '넉넉한 사람들',
      '구분': '공급처',
      '금액': 2500000,
      '정산일자': '2024-05-23',
    },
    {
      '거래명': '[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)',
      '거래유형': '선도거래',
      '업체명': '넉넉한 사람들',
      '구분': '공급처',
      '금액': 2500000,
      '정산일자': '2024-05-23',
    },
    {
      '거래명': '[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)',
      '거래유형': '선도거래',
      '업체명': '넉넉한 사람들',
      '구분': '공급처',
      '금액': 2500000,
      '정산일자': '2024-05-23',
    },
    {
      '거래명': '[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)',
      '거래유형': '선도거래',
      '업체명': '넉넉한 사람들',
      '구분': '공급처',
      '금액': 2500000,
      '정산일자': '2024-05-23',
    },
    {
      '거래명': '[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)',
      '거래유형': '선도거래',
      '업체명': '넉넉한 사람들',
      '구분': '공급처',
      '금액': 2500000,
      '정산일자': '2024-05-23',
    },
    {
      '거래명': '[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)',
      '거래유형': '선도거래',
      '업체명': '넉넉한 사람들',
      '구분': '공급처',
      '금액': 2500000,
      '정산일자': '2024-05-23',
    },
    {
      '거래명': '[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)',
      '거래유형': '선도거래',
      '업체명': '넉넉한 사람들',
      '구분': '공급처',
      '금액': 2500000,
      '정산일자': '2024-05-23',
    },
    {
      '거래명': '[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)',
      '거래유형': '선도거래',
      '업체명': '넉넉한 사람들',
      '구분': '공급처',
      '금액': 2500000,
      '정산일자': '2024-05-23',
    },
    {
      '거래명': '[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)',
      '거래유형': '선도거래',
      '업체명': '넉넉한 사람들',
      '구분': '공급처',
      '금액': 2500000,
      '정산일자': '2024-05-23',
    },
    {
      '거래명': '[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)',
      '거래유형': '선도거래',
      '업체명': '넉넉한 사람들',
      '구분': '공급처',
      '금액': 2500000,
      '정산일자': '2024-05-23',
    },
    {
      '거래명': '[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)',
      '거래유형': '선도거래',
      '업체명': '넉넉한 사람들',
      '구분': '공급처',
      '금액': 2500000,
      '정산일자': '2024-05-23',
    },
    {
      '거래명': '[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)',
      '거래유형': '선도거래',
      '업체명': '넉넉한 사람들',
      '구분': '공급처',
      '금액': 2500000,
      '정산일자': '2024-05-23',
    },
    {
      '거래명': '[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)',
      '거래유형': '선도거래',
      '업체명': '넉넉한 사람들',
      '구분': '공급처',
      '금액': 2500000,
      '정산일자': '2024-05-23',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final int firstRowIndex = _pageIndex * _rowsPerPage;
    final int lastRowIndex = (_pageIndex + 1) * _rowsPerPage;

    return Container(
      padding: EdgeInsets.all(30.0),
      color: Color(0xFFF9FCFE),
      child: Column(
        children: [
          // 상단 타이틀 영역
          TitleSection(
              mainTitle: '정산', breadcrumb1: ' > 정산관리 > ', breadcrumb2: '정산'),

          // 검색 영역
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 280,
                    decoration: commonBoxDecoration,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 50.0,
                        left: 30,
                        right: 30,
                        bottom: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              textBox('• 거래일'),
                              CustomDatePickerField(
                                controller: startDateController,
                                onDateTap: _selectDate,
                              ),
                              const Text(
                                '  -  ',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              CustomDatePickerField(
                                controller: endDateController,
                                onDateTap: _selectDate,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(maxHeight: 40),
                                child: ToggleButtons(
                                  isSelected: isSelected,
                                  selectedColor: Colors.white,
                                  fillColor: Colors.transparent,
                                  borderColor: Colors.grey,
                                  selectedBorderColor: Color(0xFF4470F6),
                                  borderRadius: BorderRadius.circular(5),
                                  children: <Widget>[
                                    buildToggleButton('지난달', isSelected[0]),
                                    buildToggleButton('이번달', isSelected[1]),
                                    buildToggleButton('올해', isSelected[2]),
                                  ],
                                  onPressed: (int index) {
                                    setState(() {
                                      for (int i = 0;
                                          i < isSelected.length;
                                          i++) {
                                        isSelected[i] = i == index;
                                      }
                                      _setDateRange(index);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 120,
                                child: Text(
                                  '• 검색',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SelectBoxExample(
                                initialValue: '전체',
                                options: const [
                                  '전체',
                                  '거래명',
                                  '업체명',
                                  '거래유형',
                                ],
                                onChanged: (String? newValue) {
                                  setState(() {});
                                },
                                custom_width: 220.0,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 350,
                                height: 45,
                                child: TextFormField(
                                  controller: searchController,
                                  decoration: const InputDecoration(
                                    hintText: '검색어를 입력하세요',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFD1D1D1),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFD1D1D1),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomElevatedButton1(
                                backgroundColor: Color(0xFF5D75BF),
                                text: '검색',
                                onPressed: () {},
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomElevatedButton2(
                                text: '초기화',
                                backgroundColor: Colors.white,
                                textColor: Color(0xFF9A9A9A),
                                borderColor: Color(0xFFD6D6D6),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 280,
                    decoration: commonBoxDecoration,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 30.0,
                        left: 30,
                        right: 30,
                        bottom: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              const SizedBox(
                                width: 150,
                                child: Text(
                                  '매출합계',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                width: 350,
                                height: 45,
                                color: Color(0xFFFFF3F2),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              const SizedBox(
                                width: 150,
                                child: Text(
                                  '매입합계',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                width: 350,
                                height: 45,
                                color: Color(0xFFFFF3F2),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              const SizedBox(
                                width: 150,
                                child: Text(
                                  '기타비용 합계',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                width: 350,
                                height: 45,
                                color: Color(0xFFFFF3F2),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              const SizedBox(
                                width: 150,
                                child: Text(
                                  '매출이익',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                width: 350,
                                height: 45,
                                color: Color(0xFFFFF3F2),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),

          // 표 상단 영역
          Row(
            children: [
              const Text(
                ' 총 n개',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Spacer(),
              CustomElevatedButton1(
                backgroundColor: Color(0xFF5D75BF),
                text: '등록',
                onPressed: () {
                  _showSettlementDialog(context);
                },
              ),
            ],
          ),
          const SizedBox(height: 10),

          // 테이블
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            width: double.infinity,
            height: 650,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color(0xFFD6D6D6),
                )),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: DataTable(
                          columns: const [
                            DataColumn(
                              label: Text(
                                '거래명',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '거래유형',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '업체명',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '구분',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '금액',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '정산일자',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                          rows: _filteredData
                              .skip(firstRowIndex)
                              .take(_rowsPerPage)
                              .map((item) {
                            int itemIndex = _filteredData.indexOf(item);
                            return DataRow(cells: [
                              DataCell(
                                GestureDetector(
                                  onTap: () {
                                    // context.go('/order-detail');
                                  },
                                  child: Text(
                                    item['거래명']!.length > 12
                                        ? item['거래명']!.substring(0, 12) +
                                            '... >'
                                        : item['거래명']! + ' >',
                                    style: const TextStyle(
                                      color: Color(0xFF4470F6),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(Text(item['거래유형']!)),
                              DataCell(Text(item['업체명']!)),
                              DataCell(Text(item['구분']!)),
                              DataCell(Text(
                                  currencyFormat.format(item['금액']) + '원')),
                              DataCell(Text(item['정산일자']!)),
                            ]);
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),

                // 페이징
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: _pageIndex > 0
                          ? () {
                              setState(() {
                                _pageIndex--;
                              });
                            }
                          : null,
                    ),
                    Text('${_pageIndex + 1}'),
                    IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: (lastRowIndex < _filteredData.length)
                          ? () {
                              setState(() {
                                _pageIndex++;
                              });
                            }
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 수동 정산입력창 생성
void _showSettlementDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
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
              const SizedBox(height: 10),
              const Text(
                '기타 정산 등록',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SettlementForm(onSubmit: (newSettlement) {
                Navigator.of(context).pop();
              }),
              const SizedBox(height: 16),
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
                  const SizedBox(width: 15),
                  CustomElevatedButton1(
                    backgroundColor: Color(0xFF5D75BF),
                    text: '제출',
                    onPressed: () {
                      // OrderForm.of(context).submitForm();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

// 정산 입력 폼 
class SettlementForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;

  SettlementForm({required this.onSubmit});

  static SettlementFormState of(BuildContext context) =>
      context.findAncestorStateOfType<SettlementFormState>()!;

  @override
  SettlementFormState createState() => SettlementFormState();
}

class SettlementFormState extends State<SettlementForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController orderNmController;
  late TextEditingController orderTypeController;
  late TextEditingController companyNmController;
  late TextEditingController typeController;
  late TextEditingController amountController;
  // String settlementDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    orderNmController = TextEditingController();
    orderTypeController = TextEditingController();
    companyNmController = TextEditingController();
    typeController = TextEditingController();
    amountController = TextEditingController();
  }

  @override
  void dispose() {
    orderNmController.dispose();
    orderTypeController.dispose();
    companyNmController.dispose();
    typeController.dispose();
    amountController.dispose();
    super.dispose();
  }

  
  void submitForm() {
    if (_formKey.currentState!.validate()) {
      final newSettlement = {
        '거래명': int.parse(orderNmController.text),
        '거래유형': int.parse(orderTypeController.text),
        '업체명': companyNmController.text,
        '구분': typeController.text,
        '금액': amountController.text,
        '정산일자': DateTime.now().toIso8601String().split('T')[0],
      };
      widget.onSubmit(newSettlement);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              customTextField('거래명', '', orderNmController, 120),
              const SizedBox(height: 10),
              customTextField('거래유형', 'B2B 또는 B2V 등 입력', orderTypeController, 120),
              const SizedBox(height: 10),
              customTextField('업체명', '', companyNmController, 120),
              const SizedBox(height: 10),
              customTextField('구분', '매출 또는 매입 등 입력', typeController, 120),
              const SizedBox(height: 10),
              customTextField('금액', '(원) 단위로 숫자만 입력', amountController, 120),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
