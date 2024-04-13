import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'main.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class PersonPage extends StatefulWidget {const PersonPage({Key? key}) : super(key: key);@override _PersonPageState createState() => _PersonPageState();}

List<String> timeList = [];
List<String> weekList = ['星期一', '星期二', '星期三', '星期四', '星期五', '星期六', '星期日'];
List<String> ch_num = ["一", "二", "三", "四", "五","六", "七", "八", "九", "十"];  // 中文数字列表
class _PersonPageState extends State<PersonPage> {
  int selectedWeekIndex = 0; // 添加一个变量来追踪选择的星期索引
  int n = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: data(),
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) { /* 正在加載數據，顯示進度指示器*/ return const Center(child: CircularProgressIndicator());}
          // else
          if (snapshot.hasError) { /* 加載數據時出錯，顯示錯誤信息*/ return Center(child: Text('Error: ${snapshot.error}'));}
          else {
            if (snapshot.hasData) {
              String todayWeek;
              int todayWeek_num;
              initializeDateFormatting(); // 將時間英文改中文
              // 數據加載成功，構建界面
              final data = snapshot.data!;
              final timeList = data['timeList'] as List<String>;final monList = data['monList'] as List<String>;
              final tueList = data['tueList'] as List<String>;final wedList = data['wedList'] as List<String>;
              final thuList = data['thuList'] as List<String>;final friList = data['friList'] as List<String>;
              final satList = data['satList'] as List<String>;final sunList = data['sunList'] as List<String>;

              todayWeek = DateFormat('EEEE','zh_CN').format(DateTime.now());
              todayWeek_num = weekList.indexOf(todayWeek);
              // print('星期二的位置是：$todayWeek_num');

              if (timeList.isNotEmpty) {
                return Container(
                    // color: Colors.red[100],
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        const Center(child: Text("課表",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),)),
                        SizedBox(height: 5),
                        const Divider(color: Colors.grey, thickness: 2,),
                        Row(
                          children: [
                            // SizedBox(width: 20,),
                            // Card(
                            //     elevation: 6,
                                // color: Colors.blue,
                                // child:
                                Column(
                                  children: [
                                    // SizedBox(height: 20,),
                                    Row(
                                      children: [
                                        Text(
                                          "當天日期： <"+DateFormat('EEEE','zh_CN').format(DateTime.now())+">",
                                          style: TextStyle(fontSize: 20), // 设置字体大小为20
                                        ),// 显示年月日
                                        SizedBox(width: 20,),
                                        Column(
                                          children: [
                                            Text(DateFormat('yyyy-MM-dd').format(DateTime.now()),),// 显示星期几
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 570,//480.0,
                                              width: 340,//300,
                                              child:Swiper( // 使用 Swiper 來滑動顯示星期
                                                itemCount: 7, // 星期的數量
                                                loop: false,
                                                // pagination: SwiperPagination(), // 顯示點狀指示器
                                                control: const SwiperControl(color: Colors.grey),
                                                index: todayWeek_num, // 顯示當天

                                                itemBuilder: (context, index) {
                                                  // 其他頁面顯示對應星期的課表
                                                  List<String> dayList;
                                                  switch (index) {
                                                    case 0:dayList = monList;break;
                                                    case 1:dayList = tueList;break;
                                                    case 2:dayList = wedList;break;
                                                    case 3:dayList = thuList;break;
                                                    case 4:dayList = friList;break;
                                                    case 5:dayList = satList;break;
                                                    case 6:dayList = sunList;break;
                                                    default:dayList = [];break;
                                                  }
                                                  switch (weekList[index]) {
                                                    case '星期一':n=0;break;
                                                    case '星期二':n=1;break;
                                                    case '星期三':n=2;break;
                                                    case '星期四':n=3;break;
                                                    case '星期五':n=4;break;
                                                    case '星期六':n=5;break;
                                                    case '星期日':n=6;break;
                                                  }
                                                  selectedWeekIndex = n;
                                                  // print(selectedWeekIndex);
                                                  // print(weekList[selectedWeekIndex]);
                                                  // 使用 ListView.builder 來動態生成 Text 部件
                                                  return ListView.builder(
                                                      itemCount: dayList.length,
                                                        itemBuilder: (context, index) {
                                                          if (index == 0){
                                                            return Column(
                                                              children: [
                                                                Card(
                                                                    elevation: 8,
                                                                    child: ListTile(
                                                                      title: Center(child:Text(weekList[selectedWeekIndex],style: TextStyle(fontSize: 24),)),
                                                                    )
                                                                ),
                                                                Card(
                                                                  elevation: 8,
                                                                  child: ListTile(
                                                                      title: Center(child:Text(dayList[index]),),
                                                                      subtitle: Center(child:Text("第${ch_num[index]}節 ${timeList[index]}"),)
                                                                  ),
                                                                )
                                                              ],
                                                            );
                                                          }
                                                          else {
                                                            return Column(
                                                              children: [
                                                                Card(
                                                                  elevation: 8,
                                                                  child: ListTile(
                                                                      title: Center(child:Text(dayList[index]),),
                                                                      subtitle: Center(child:Text("第${ch_num[index]}節 ${timeList[index]}"),)
                                                                  ),
                                                                )
                                                              ],
                                                            );
                                                          }
                                                        },
                                                      );
                                                },
                                              ),
                                            )
                                          ],
                                        )
                                    ),
                                  ],
                                )
                            // )
                          ],
                        ),
                      ],
                    ),
                );
              }
              else {return Text('清單為空');}
            }
            else {return Center(child: CircularProgressIndicator());}
          }
        },
      ),
    );
  }
}