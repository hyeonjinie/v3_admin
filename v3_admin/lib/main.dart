import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:v3_admin/screens/client_mgt/regist_sup.dart';
import 'package:v3_admin/screens/client_mgt/supplier_detail.dart';
import 'package:v3_admin/screens/client_mgt/supplier_page.dart';
import 'package:v3_admin/screens/login.dart';
import 'package:v3_admin/screens/main_screen.dart';
import 'package:v3_admin/screens/member_mgt/admin_add.dart';
import 'package:v3_admin/screens/member_mgt/admin_detail.dart';
import 'package:v3_admin/screens/member_mgt/admin_page.dart';
import 'package:v3_admin/screens/member_mgt/member_detail.dart';
import 'package:v3_admin/screens/member_mgt/member_page.dart';
import 'package:v3_admin/screens/operation_mgt/forward_comp_detail.dart';
import 'package:v3_admin/screens/operation_mgt/forward_completed.dart';
import 'package:v3_admin/screens/operation_mgt/forward_inquiry.dart';
import 'package:v3_admin/screens/operation_mgt/forward_inquiry_detail.dart';
import 'package:v3_admin/screens/operation_mgt/forward_inquiry_edit.dart';
import 'package:v3_admin/screens/operation_mgt/forward_prog_detail.dart';
import 'package:v3_admin/screens/operation_mgt/forward_progress.dart';
import 'package:v3_admin/screens/operation_mgt/forward_test.dart';
import 'package:v3_admin/screens/operation_mgt/market_cancel.dart';
import 'package:v3_admin/screens/operation_mgt/market_order.dart';
import 'package:v3_admin/screens/operation_mgt/market_order_detail.dart';
import 'package:v3_admin/screens/product_mgt/category.dart';
import 'package:v3_admin/screens/product_mgt/prod_detail.dart';
import 'package:v3_admin/screens/product_mgt/regist_prod.dart';
import 'package:v3_admin/screens/settlement_mgt/settlement_page.dart';
import 'package:v3_admin/screens/statistics_data/statistics_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// 메뉴 상태를 관리할 ChangeNotifier 클래스
class MenuState extends ChangeNotifier {
  int _selectedPageIndex = 0;

  int get selectedPageIndex => _selectedPageIndex;

  void selectPage(int index) {
    _selectedPageIndex = index;
    notifyListeners();
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MenuState()),
      ],
      child: WithRouter(),
    );
  }
}

class WithRouter extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) {
          return MainScreen();
        },
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return LoginPage();
        },
      ),
      GoRoute( // 회원관리 > 일반회원 
        path: '/member',
        builder: (BuildContext context, GoRouterState state) {
          return MemberManagementPage();
        },
      ),
      GoRoute( // 회원관리 > 일반회원 > 회원상세 
        path: '/member-detail',
        builder: (BuildContext context, GoRouterState state) {
          return MemberDetail();
        },
      ),
      GoRoute( // 회원관리 > 운영자 
        path: '/admin',
        builder: (BuildContext context, GoRouterState state) {
          return AdminPage();
        },
      ),
      GoRoute( // 회원관리 > 운영자 > 운영자 상세 
        path: '/admin-detail',
        builder: (BuildContext context, GoRouterState state) {
          return AdminDetail();
        },
      ),
      GoRoute( // 회원관리 > 운영자 > 운영자 등록/수정 
        path: '/admin-reg',
        builder: (BuildContext context, GoRouterState state) {
          return AdminAdd();
        },
      ),
      GoRoute( // 운영관리 > 선도거리 > 문의/계약 
        path: '/operation',
        builder: (BuildContext context, GoRouterState state) {
          return OperationPage();
        },
      ),
      GoRoute( // 운영관리 > 선도거리 > 문의/계약 > 상세 
        path: '/inquiry-detail',
        builder: (BuildContext context, GoRouterState state) {
          return InquiryDetail();
        },
      ),
      // GoRoute( // 운영관리 > 선도거리 > 문의/계약 > 수정 
      //   path: '/inquiry-edit',
      //   builder: (BuildContext context, GoRouterState state) {
      //     return EditInquiry();
      //   },
      // ),
      GoRoute( // 운영관리 > 선도거리 > 진행
        path: '/progress',
        builder: (BuildContext context, GoRouterState state) {
          return Progress();
        },
      ),
      GoRoute( // 운영관리 > 선도거리 > 진행 > 상세 
        path: '/progress-detail',
        builder: (BuildContext context, GoRouterState state) {
          return ProgressDetail();
        },
      ),
      GoRoute( // 운영관리 > 선도거리 > 완료 
        path: '/completed',
        builder: (BuildContext context, GoRouterState state) {
          return Completed();
        },
      ),
      GoRoute( // 운영관리 > 선도거리 > 완료 > 상세 
        path: '/completed-detail',
        builder: (BuildContext context, GoRouterState state) {
          return CompletedDetail();
        },
      ),
      GoRoute( // 운영관리 > 비굿마켓 > 주문
        path: '/order',
        builder: (BuildContext context, GoRouterState state) {
          return MarketOrder();
        },
      ),
      GoRoute( // 운영관리 > 비굿마켓 > 주문 > 상세
        path: '/order-detail',
        builder: (BuildContext context, GoRouterState state) {
          return OrderDetail();
        },
      ),
      GoRoute( // 운영관리 > 비굿마켓 > 반품/취소
        path: '/cancel',
        builder: (BuildContext context, GoRouterState state) {
          return MarketCancel();
        },
      ),
      GoRoute( // 운영관리 > 비굿마켓 > 반품/취소 > 상세
        path: '/cancel-detail',
        builder: (BuildContext context, GoRouterState state) {
          return MarketCancel();
        },
      ),
      GoRoute( // 정산관리 > 
        path: '/settlement',
        builder: (BuildContext context, GoRouterState state) {
          return SettlementPage();
        },
      ),
      GoRoute( // 상품관리 > 상품등록 
        path: '/product',
        builder: (BuildContext context, GoRouterState state) {
          return ProdPage();
        },
      ),
      GoRoute( // 상품관리 > 상품상세 
        path: '/product-detail',
        builder: (BuildContext context, GoRouterState state) {
          return ProdDetail();
        },
      ),
      GoRoute( // 상품관리  > 카테고리 
        path: '/category',
        builder: (BuildContext context, GoRouterState state) {
          return CategoryPage();
        },
      ),
      GoRoute( // 거래처관리 > 공급사 관리 
        path: '/client',
        builder: (BuildContext context, GoRouterState state) {
          return ClientManagement();
        },
      ),
      GoRoute( // 거래처관리 > 공급사 관리 > 공급사 상세 
        path: '/supplier',
        builder: (BuildContext context, GoRouterState state) {
          return SupplierDetail();
        },
      ),
      GoRoute( // 거래처관리 > 공급사 관리 > 공급사 등록/수정 
        path: '/regist-supplier',
        builder: (BuildContext context, GoRouterState state) {
          return RegistSupplier();
        },
      ),
      GoRoute( // 통계데이터 
        path: '/statistics',
        builder: (BuildContext context, GoRouterState state) {
          return StatisticsPage();
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "NanumGothic"),
    );
  }
}
