import 'package:flutter/material.dart';
import 'package:v3_admin/common_widget/layout.dart';
import 'package:v3_admin/screens/main_screen.dart';

class DashboardPage extends StatefulWidget {
  final Function(int) onCategorySelected;
  const DashboardPage({Key? key, required this.onCategorySelected})
      : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                ProfileWidget(),
                Expanded(
                  child: Dashboard(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30.0),
      decoration: BoxDecoration(
        color: Color(0xFFF9FCFE),
        border: Border(
          top: BorderSide(
            color: Color.fromARGB(255, 227, 227, 227),
          ),
        ),
      ),
      child: Column(
        children: [
          // 상단 타이틀 영역
          Row(
            children: [
              Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              children: [
                Container(
                  width: 740,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color(0xFFD1D1D1),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '선도거래 주문/정산',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            buildColumnContainer(
                              title: '주문',
                              color: Color(0xFF5C75BF),
                              data: '문의\n진행\n완료\n',
                              count: 'n 건\nn 건\nn 건\n',
                            ),
                            SizedBox(width: 30),
                            buildColumnContainer(
                              title: '정산',
                              color: Color(0xFFEF8169),
                              data: '거래처\n공급처\n물류\n기타',
                              count: 'n 건\nn 건\nn 건\nn 건',
                            ),
                            SizedBox(width: 30),
                            buildColumnContainer(
                              title: '세금계산서',
                              color: Color(0xFF52B98E),
                              data: '거래처\n공급처\n물류\n기타',
                              count: 'n 건\nn 건\nn 건\nn 건',
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 500,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color(0xFFD1D1D1),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '비굿마켓 주문/정산',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            buildColumnContainer(
                              title: '주문',
                              color: Color(0xFF5C75BF),
                              data: '문의\n진행\n완료\n',
                              count: 'n 건\nn 건\nn 건\n',
                            ),
                            SizedBox(width: 30),
                            buildColumnContainer(
                              title: '정산',
                              color: Color(0xFFEF8169),
                              data: '거래처\n공급처\n물류\n기타',
                              count: 'n 건\nn 건\nn 건\nn 건',
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget buildColumnContainer({
  required String title,
  required Color color,
  required String data,
  required String count,
}) {
  return Container(
    width: 200,
    child: Column(
      children: [
        Row(
          children: [
            Container(
              width: 200,
              height: 30,
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: title == '세금계산서' ? 110 : 80,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: color),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          title,
                          style: TextStyle(
                            color: color,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        width: 80,
                        height: 30,
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Total   ',
                          style: TextStyle(
                            color: Color(0xFF323232),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    left: 20,
                    bottom: 0,
                    child: Container(
                      width: 180,
                      height: 1,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          width: 200,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Text(
                  data,
                  style: TextStyle(
                    color: Color(0xFF282828),
                    fontSize: 14,
                    height: 2.2,
                  ),
                ),
                Expanded(
                  child: Text(
                    count,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF4F4F4F),
                      fontSize: 14,
                      height: 2.2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
