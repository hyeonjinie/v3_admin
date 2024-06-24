/*
- layout : GNB, Profile, SubMenu(LNB)
- etc : Url_func
*/
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:v3_admin/common_widget/naviagtion_helper.dart';

// GNB
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final int selectedPageIndex;
  final Function(int) onItemTapped;

  const CustomAppBar({
    Key? key,
    this.scaffoldKey,
    required this.selectedPageIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 2 * kToolbarHeight,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () =>
                NavigationHelper.onItemTapped(context, 0, onItemTapped),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/admin_bi.png',
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    '통합관리자',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 80,
          ),
          Row(
            children: [
              _buildNavItem(context, 1, '회원관리'),
              _buildNavItem(context, 2, '운영관리'),
              _buildNavItem(context, 3, '정산관리'),
              _buildNavItem(context, 4, '상품관리'),
              _buildNavItem(context, 5, '거래처관리'),
              _buildNavItem(context, 6, '통계데이터'),
            ],
          ),
          Spacer(),
          TextButton(
            onPressed: () {
              const url = 'https://app.bgood.co.kr/admin/provider/catalog';
              _launchURL(url);
            },
            child: Text(
              '기존 관리자 이동 >',
              style: TextStyle(
                  color: Color(0xFF474747),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: Colors.grey[300],
          height: 1.0,
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, String title) {
    return GestureDetector(
      onTap: () => NavigationHelper.onItemTapped(context, index, onItemTapped),
      child: Row(
        children: [
          const SizedBox(width: 20),
          Text(
            title,
            style: TextStyle(
                color: selectedPageIndex == index
                    ? Color(0xFF4470F6)
                    : Color(0xFF474747),
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

// Profile
class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  bool isFolded = true; // isFolded 필드를 인스턴스 변수로 변경

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      color: Color(0xFF292F3D),
      child: Column(
        children: [
          ListTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 10.0),
                  child: Image.asset(
                    'assets/images/person.png',
                    height: 40.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '김현진',
                      style: TextStyle(
                        color: Color(0xFFEDEDED),
                        fontSize: 16,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isFolded ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                        color: Color(0xFFEDEDED),
                      ),
                      onPressed: () {
                        setState(() {
                          isFolded = !isFolded;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            onTap: () {
              setState(() {
                isFolded = !isFolded;
              });
            },
          ),
          if (!isFolded)
            Container(
              color: Color(0xFF15181E),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email: example@example.com',
                    style: TextStyle(
                      color: Color(0xFFEDEDED),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      Text(
                        '마이페이지',
                        style: TextStyle(
                          color: Color(0xFFEDEDED),
                        ),
                      ),
                      Text(
                        '   |   ',
                        style: TextStyle(
                          color: Color(0xFFEDEDED),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.go('/login');
                        },
                        child: Text(
                          '로그아웃',
                          style: TextStyle(
                            color: Color(0xFFEDEDED),
                          ),
                        ),
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

// SubMenu(LNB) - single
class SingleMenuWidget extends StatelessWidget {
  final String label;
  final int selectedMenu;
  final int index;
  final VoidCallback onTap;

  SingleMenuWidget({
    required this.label,
    required this.selectedMenu,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: selectedMenu == index ? Color(0xFF1B1E24) : Colors.transparent,
        border: Border(
          left: BorderSide(
            color:
                selectedMenu == index ? Color(0xFFF9FCFE) : Colors.transparent,
            width: selectedMenu == index ? 3.0 : 0.0,
          ),
        ),
      ),
      child: ListTile(
        title: Text(
          label,
          style: TextStyle(
            color: Color(0xFFEDEDED),
            fontSize: 16,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

// SubMenu(LNB) - folding
class SubMenuWidget extends StatefulWidget {
  final String label;
  final int selectedMenu;
  final Function(int) onTap;
  final List<SubMenuItem> items;
  final isExpanded;

  SubMenuWidget({
    required this.label,
    required this.selectedMenu,
    required this.onTap,
    required this.items,
    required this.isExpanded,
  });

  @override
  _SubMenuWidgetState createState() => _SubMenuWidgetState();
}

class _SubMenuWidgetState extends State<SubMenuWidget> {
  
  late bool isExpanded;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: widget.items
                        .any((item) => item.index == widget.selectedMenu)
                    ? Color(0xFFF9FCFE)
                    : Colors.transparent,
                width: 3.0,
              ),
            ),
          ),
          child: GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              color:
                  widget.items.any((item) => item.index == widget.selectedMenu)
                      ? Color(0xFF1B1E24)
                      : Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.label,
                    style: TextStyle(
                      color: Color(0xFFEDEDED),
                      fontSize: 16,
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Color(0xFFEDEDED),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (isExpanded)
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              final item = widget.items[index];
              return ListTile(
                title: Text(
                  ' - ${item.label}',
                  style: TextStyle(
                    color: widget.selectedMenu == item.index
                        ? Color(0xFFEDEDED)
                        : Color(0xFF929EA6),
                    fontSize: 14,
                  ),
                ),
                contentPadding: EdgeInsets.only(left: 20.0), 
                onTap: () {
                  widget.onTap(item.index);
                },
              );
            },
          ),
      ],
    );
  }
}

class SubMenuItem {
  final String label;
  final int index;

  SubMenuItem({
    required this.label,
    required this.index,
  });
}

// URL
void _launchURL(String urlString) async {
  final Uri url = Uri.parse(urlString);
  // print(url);
  try {
    if (await canLaunchUrl(url)) {
      bool launched = await launchUrl(url);
      if (!launched) {
        print('Launching URL failed.');
      }
    } else {
      print('URL cannot be launched.');
    }
  } catch (e) {
    print('Error launching URL: $e');
  }
}
