import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'AnnouncementPage.dart';
import 'ChatPage.dart';
import 'HomePage.dart';
import 'PersonPage.dart';

void main() {
  runApp(const MaterialApp(
    title:'勤益小幫手',
    home:MyApp(),
    debugShowCheckedModeBanner:false,
  ));
}
// Get json ====================================================================
Future<String> getJsonFromFirebaseRestAPI(String url) async {
  http.Response response = await http.get(Uri.parse(url));
  return response.body;
}

String getTitle(String json, String value, int index) {
  final jsonResponse = convert.jsonDecode(json);
  return jsonResponse[index][value];
}

Future<Map<String, dynamic>> data() async {
  String urlSchedule = "https://ncut-proj-default-rtdb.firebaseio.com/schedule.json";
  String urlBusRoute = "https://ncut-proj-default-rtdb.firebaseio.com/bus_route.json";
  String urlAnnouncement = "https://ncut-proj-default-rtdb.firebaseio.com/announcement.json";
  String urlStudentAnnouncement = "https://ncut-proj-default-rtdb.firebaseio.com/student_announcement.json";
  String urlTeacherAnnouncement = "https://ncut-proj-default-rtdb.firebaseio.com/teacher_announcement.json";

  String jsonSchedule = await getJsonFromFirebaseRestAPI(urlSchedule);
  String jsonBusRoute = await getJsonFromFirebaseRestAPI(urlBusRoute);
  String jsonAnnouncement = await getJsonFromFirebaseRestAPI(urlAnnouncement);
  String jsonStudentAnnouncement = await getJsonFromFirebaseRestAPI(urlStudentAnnouncement);
  String jsonTeacherAnnouncement = await getJsonFromFirebaseRestAPI(urlTeacherAnnouncement);

  // 解析處理 schedule.json 的數據
  List<String> monList = [], tueList = [], wedList = [], thuList = [], friList = [], satList = [], sunList = [];

  for (int i = 0; i < 8; i++) {
    timeList.add(getTitle(jsonSchedule, "Data", i));monList.add(getTitle(jsonSchedule, "星期一", i).replaceFirst('x', ''));
    tueList.add(getTitle(jsonSchedule, "星期二", i).replaceFirst('x', ''));wedList.add(getTitle(jsonSchedule, "星期三", i).replaceFirst('x', ''));
    thuList.add(getTitle(jsonSchedule, "星期四", i).replaceFirst('x', ''));friList.add(getTitle(jsonSchedule, "星期五", i).replaceFirst('x', ''));
    satList.add(getTitle(jsonSchedule, "星期六", i).replaceFirst('x', ''));sunList.add(getTitle(jsonSchedule, "星期日", i).replaceFirst('x', ''));
  }

  // 解析處理 bus_route.json 的數據
  final jsonResponseBusRoute = convert.jsonDecode(jsonBusRoute);
  // List<String> zhCnName = [], direction = [], enName = [], routeName = [];
  // List<int> stationSequence = [];
  // List<String> stringStationSequence = stationSequence.map((int value) => value.toString()).toList();
  // List<double> longitude = [], latitude = [];
  // List<String> stringLongitude = stationSequence.map((int value) => value.toString()).toList();
  // List<String> stringLatitude = stationSequence.map((int value) => value.toString()).toList();
  // List<dynamic> route = [];
  // List<String> stringRoute = stationSequence.map((int value) => value.toString()).toList();
  // // 使用集合來過濾相同的文字和數字
  Set<dynamic> uniqueRoutes = <dynamic>{};
  // print(jsonResponseBusRoute);
  // for (var item in jsonResponseBusRoute) {
    // zhCnName.add(item['中文站點名稱']);
    // stationSequence.add(item['站序']);
  //   longitude.add(item['經度']);
  //   latitude.add(item['緯度']);
  //   enName.add(item['英文站點名稱']);
  //   dynamic routeItem = item['路線'];
  //   // 如果項目尚未存在於 uniqueRoutes 集合中，將其加入 route 清單和 uniqueRoutes 集合
  //   if (!uniqueRoutes.contains(routeItem)) {
  //     route.add(routeItem);
  //     uniqueRoutes.add(routeItem);
  //     stringRoute.add(routeItem.toString());
  //   }
  //   routeName.add(item['路線名稱']);
  //   direction.add(item['方向']);
  // }

  var routeArrays = {};
  var directionG = [];
  var directionB = [];
  List<String> zhCnName = [], enName = [];
  List<int> stationSequence = [];
  List<String> stringStationSequence = stationSequence.map((int value) => value.toString()).toList();
  List<double> longitudeG = [], latitudeG = [],longitudeB = [], latitudeB = [];
  List<String> stringLongitude = stationSequence.map((int value) => value.toString()).toList();
  List<String> stringLatitude = stationSequence.map((int value) => value.toString()).toList();
  List<dynamic> route = [];
  List<String> stringRoute = stationSequence.map((int value) => value.toString()).toList();

  List<String> zhCnNameG = [];
  List<String> zhCnNameB = [];
  for (var item in jsonResponseBusRoute) {
    dynamic routeItem = item['路線'];
    stationSequence.add(item['站序']);
    enName.add(item['英文站點名稱']);
    zhCnName.add(item['中文站點名稱']);
    if (!uniqueRoutes.contains(routeItem)) {
      route.add(routeItem);
      uniqueRoutes.add(routeItem);
      stringRoute.add(routeItem.toString());

      routeArrays[routeItem] = {
        '去程': {
          '中文站點名稱': [],
          // '經度': [],
          // '緯度': []
        },
        '回程': {
          '中文站點名稱': [],
          // '經度': [],
          // '緯度': []
        },
      }; // 创建空数组
    }
    if (item['方向'] == '去程') {
      zhCnNameG.add(item['中文站點名稱']);
      longitudeG.add(item['經度']);
      latitudeG.add(item['緯度']);
      routeArrays[routeItem]['去程']['中文站點名稱'].add(zhCnNameG);
      // routeArrays[routeItem]['去程']['經度'].add(longitudeG);
      // routeArrays[routeItem]['去程']['緯度'].add(latitudeG);

    }
    if (item['方向'] == '回程') {
      zhCnNameB.add(item['中文站點名稱']);
      longitudeB.add(item['經度']);
      latitudeB.add(item['緯度']);
      routeArrays[routeItem]['回程']['中文站點名稱'].add(zhCnNameB);
      // routeArrays[routeItem]['回程']['經度'].add(longitudeB);
      // routeArrays[routeItem]['回程']['緯度'].add(latitudeB);
    }
  }

  // print(routeArrays[41]['去程']['中文站點名稱'][0][0]);
  // print(routeArrays.length);


  // 解析處理 announcement.json 的數據
  final jsonResponseAnnouncement = convert.jsonDecode(jsonAnnouncement);
  List<String> theme = [];
  List<List<String>> content = [];
  List<String> manuscriptSource = [];

  for (var item in jsonResponseAnnouncement) {
    theme.add(item['主題']);
    if (item['內容'] is List) {
      List<String> subContentItem = []; // 創建子內容列表
      for (var subItem in item['內容']) {
        if (subItem is Map && subItem['內容'] is String) {
          subContentItem.add(subItem['內容']); // 將子內容加入子內容列表
        }
      }
      if (subContentItem.isNotEmpty) {
        content.add(subContentItem); // 將子內容列表加入內容列表
      }
    }
    manuscriptSource.add(item['稿源']);
  }

  // 解析處理 student_announcement.json 的數據
  final jsonResponseStudentAnnouncement = convert.jsonDecode(jsonStudentAnnouncement);
  List<String> StudentTheme = [];
  List<List<String>> StudentContent = [];
  List<String> StudentTime = [];
  for (var item in jsonResponseStudentAnnouncement) {
    StudentTheme.add(item['主題']);
    if (item['內容'] is List) {
      List<String> subContentItem = []; // 創建子內容列表
      for (var subItem in item['內容']) {
        if (subItem is Map && subItem['內容'] is String) {
          subContentItem.add(subItem['內容']); // 將子內容加入子內容列表
        }
      }
      if (subContentItem.isNotEmpty) {
        StudentContent.add(subContentItem); // 將子內容列表加入內容列表
      }
    }
    StudentTime.add(item['時間']);
  }

  // 解析處理 student_announcement.json 的數據
  final jsonResponseTeacherAnnouncement = convert.jsonDecode(jsonTeacherAnnouncement);
  List<String> TeacherTheme = [];
  List<List<String>> TeacherContent = [];
  List<String> TeacherTime = [];
  for (var item in jsonResponseTeacherAnnouncement) {
    TeacherTheme.add(item['主題']);
    if (item['內容'] is List) {
      List<String> subContentItem = []; // 創建子內容列表
      for (var subItem in item['內容']) {
        if (subItem is Map && subItem['內容'] is String) {
          subContentItem.add(subItem['內容']); // 將子內容加入子內容列表
        }
      }
      if (subContentItem.isNotEmpty) {
        TeacherContent.add(subContentItem); // 將子內容列表加入內容列表
      }
    }
    TeacherTime.add(item['時間']);
  }

  Map<String, dynamic> result = {
    'timeList': timeList, 'monList': monList, 'tueList': tueList, 'wedList': wedList,
    'thuList': thuList, 'friList': friList, 'satList': satList, 'sunList': sunList,

    'zh_CN_name':zhCnName,
    // 'direction':direction,'Station_sequence':stringStationSequence,
    // 'longitude':stringLongitude,'latitude':stringLatitude,'en_name':enName,
    // 'String_route':stringRoute, 'route_name':routeName,

    'routeArrays': routeArrays,

    'theme': theme, 'content': content, 'Manuscript_source': manuscriptSource,

    'StudentTheme': StudentTheme, 'StudentContent': StudentContent,'StudentTime': StudentTime,

    'TeacherTheme': TeacherTheme, 'TeacherContent': TeacherContent,'TeacherTime': TeacherTime,
  };
  return result;
}
// MyApp =======================================================================
class MyApp extends StatefulWidget {const MyApp({Key? key}) : super(key: key);@override _MyAppState createState() => _MyAppState();}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  // final List<String> _titles = ['Home', 'Announcement', 'Chat', 'Person'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(/*leading: IconButton(icon: const Icon(Icons.menu),onPressed: () {/* 執行選單功能*/},),*/title: /*Text(_titles[_currentIndex])*/Center(child: Text("國立勤益科技大學")),backgroundColor: Colors.black54,),

      body: IndexedStack(index: _currentIndex,children: const [HomePage(),AnnouncementPage(),ChatPage(),PersonPage(),],),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {setState(() {_currentIndex = index;});},
        items: const[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black12,
            ),
            label: 'Home',
            // activeIcon-->當被選擇的這個icon是什麼樣子
            activeIcon: Icon(
              Icons.home,
              color: Colors.black87,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.announcement,
              color: Colors.black12,
            ),
            label: 'Announcement',
            // activeIcon-->當被選擇的這個icon是什麼樣子
            activeIcon: Icon(
              Icons.announcement,
              color: Colors.black87,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.map,
              color: Colors.black12,
            ),
            label: 'Chat',
            // activeIcon-->當被選擇的這個icon是什麼樣子
            activeIcon: Icon(
              Icons.map,
              color: Colors.black87,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.black12,
            ),
            label: 'Person',
            // activeIcon-->當被選擇的這個icon是什麼樣子
            activeIcon: Icon(
              Icons.person,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
