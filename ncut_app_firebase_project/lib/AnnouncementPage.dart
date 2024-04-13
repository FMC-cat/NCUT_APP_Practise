import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'main.dart';
import 'package:marquee_widget/marquee_widget.dart';

class AnnouncementPage extends StatefulWidget {const AnnouncementPage({Key? key}) : super(key: key);@override _AnnouncementPageState createState() => _AnnouncementPageState();}

class _AnnouncementPageState extends State<AnnouncementPage> {
  bool _showButton1 = true;
  bool _showButton2 = true;
  bool _showButton3 = true;

  int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: data(),
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {return Center(child: CircularProgressIndicator());}
          // else
          if (snapshot.hasError) {return Center(child: Text('Error: ${snapshot.error}'));}
          else {
            if (snapshot.hasData){
              final data = snapshot.data!;

              final theme = data['theme'] as List<String>;
              final content = data['content'] as List<dynamic>;
              final manuscriptSource = data['Manuscript_source'] as List<String>;
              final StudentTheme = data['StudentTheme'] as List<String>;
              final StudentContent = data['StudentContent'] as List<dynamic>;
              final StudentTime = data['StudentTime'] as List<String>;
              final TeacherTheme = data['TeacherTheme'] as List<String>;
              final TeacherContent = data['TeacherContent'] as List<dynamic>;
              final TeacherTime = data['TeacherTime'] as List<String>;

              int backDuration = 1;
              int j = 0;
              List<Widget> _buttonList(int index) {
                if (_showButton1) {
                  return [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        children: [
                          for(int i = 0; i<theme.length;i++) ...{
                            // const Divider(color: Colors.grey, thickness: 2,),
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    // 內容
                                    return AlertDialog(
                                      title: Text(theme[index+i]),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Text(manuscriptSource[index+i]),
                                            SizedBox(height: 20,),
                                            for (int j = 0; j < content[i].length; j++) ...{
                                              Text(content[i][j]),
                                              SizedBox(height: 10,),
                                            },
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Close'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10), // 設定圓角半徑
                                ),
                                backgroundColor: Colors.white54,
                                foregroundColor: Colors.black,
                              ),
                              // 外部
                              child: Row(
                                children: [
                                  Flexible(
                                      fit: FlexFit.loose,
                                      // 文次跑馬燈只跑一次
                                      child: ListTile(
                                        title: Marquee(
                                          direction: Axis.horizontal,
                                          animationDuration: Duration(seconds: manuscriptSource[index+i].length),
                                          backDuration: Duration(seconds: backDuration == 2 ? backDuration : 0),
                                          pauseDuration: const Duration(seconds: 1),
                                          child: Text(theme[index+i]),
                                        ),
                                        subtitle: Text(manuscriptSource[index+i]),
                                      )
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5)
                          }
                        ],
                      ),
                    )
                  ];
                }
                else if (_showButton2) {
                  return [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        children: [
                          for(int i = 0; i<TeacherTheme.length;i++) ...{
                            // Divider(color: Colors.grey[700], thickness: 2,),
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    // 內容
                                    return AlertDialog(
                                      title: Text(TeacherTheme[index+i]),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Text(manuscriptSource[index+i]),
                                            SizedBox(height: 20,),
                                            for (int j = 0; j < TeacherContent[i].length; j++) ...{
                                              Text(TeacherContent[i][j]),
                                              SizedBox(height: 10,),
                                            },
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Close'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10), // 設定圓角半徑
                                ),
                                backgroundColor: Colors.white54,
                                foregroundColor: Colors.black,
                              ),
                              // 外部
                              child: Row(
                                children: [
                                  Flexible(
                                      fit: FlexFit.loose,
                                      // 文次跑馬燈只跑一次
                                      child: ListTile(
                                        title: Marquee(
                                          direction: Axis.horizontal,
                                          animationDuration: Duration(seconds: manuscriptSource[index+i].length),
                                          backDuration: Duration(seconds: backDuration == 2 ? backDuration : 0),
                                          pauseDuration: const Duration(seconds: 1),
                                          child: Text(TeacherTheme[index+i]),
                                        ),
                                        subtitle: Text(TeacherTime[index+i]),
                                      )
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5)
                          }
                        ],
                      ),
                    )
                  ];
                }
                else if (_showButton3) {
                  return [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        children: [
                          for(int i = 0; i<StudentTheme.length;i++) ...{
                            // Divider(color: Colors.grey[700], thickness: 2,),
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    // 內容
                                    return AlertDialog(
                                      title: Text(StudentTheme[index+i]),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Text(manuscriptSource[index+i]),
                                            SizedBox(height: 20,),
                                            for (int j = 0; j < StudentContent[i].length; j++) ...{
                                              Text(StudentContent[i][j]),
                                              SizedBox(height: 10,),
                                            },
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Close'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10), // 設定圓角半徑
                                ),
                                backgroundColor: Colors.white54,
                                foregroundColor: Colors.black,
                              ),
                              // 外部
                              child: Row(
                                children: [
                                  Flexible(
                                      fit: FlexFit.loose,
                                      // 文次跑馬燈只跑一次
                                      child: ListTile(
                                        title: Marquee(
                                          direction: Axis.horizontal,
                                          animationDuration: Duration(seconds: manuscriptSource[index+i].length),
                                          backDuration: Duration(seconds: backDuration == 2 ? backDuration : 0),
                                          pauseDuration: const Duration(seconds: 1),
                                          child: Text(StudentTheme[index+i]),
                                        ),
                                        subtitle: Center(child: Text(StudentTime[index+i])),
                                      )
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5)
                          }
                        ],
                      ),
                    )
                  ];
                }
                else {
                  return [];
                }
              }
              List<Expanded> buttons = [];
              for (int i = 0; i < 3; i++) {
                buttons.add(
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showButton1 = i == 0;
                          _showButton2 = i == 1;
                          _showButton3 = i == 2;
                          _currentIndex = i;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black54,
                        backgroundColor: _currentIndex == i ? Colors.grey[400] : Colors.white60,
                        elevation: 5,
                      ),
                      child: Text(
                        i == 0 ? '科系公告' : (i == 1 ? '教師公告' : '學生公告'),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                );
              }

              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(),
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      // const Divider(color: Colors.grey, thickness: 2,),
                      const Center(child: Text("公告",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),)),
                      const SizedBox(height: 5),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 35,
                              child: Row(
                                children: [
                                  const SizedBox(width: 20,),
                                  buttons[0],
                                  buttons[1],
                                  buttons[2],
                                  // Expanded(
                                  //   flex: 1,
                                  //   child: ElevatedButton(
                                  //     onPressed: () {
                                  //       setState(() {
                                  //         _showButton1 = true;
                                  //         _showButton2 = false;
                                  //         _showButton3 = false;
                                  //         _currentIndex = 0;
                                  //       });
                                  //     },
                                  //     style: ElevatedButton.styleFrom(
                                  //       elevation: 5,
                                  //       foregroundColor: Colors.black54,
                                  //       backgroundColor: _currentIndex == 0 ? Colors.grey[400] : Colors.white60,
                                  //     ),
                                  //     child: const Text(
                                  //       '科系公告',
                                  //       style: TextStyle(
                                  //         fontSize: 18,
                                  //           fontWeight: FontWeight.bold,
                                  //         color: Colors.black87
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // Expanded(
                                  //   flex: 1,
                                  //   child: ElevatedButton(
                                  //     onPressed: () {
                                  //       setState(() {
                                  //         _showButton1 = false;
                                  //         _showButton2 = true;
                                  //         _showButton3 = false;
                                  //         _currentIndex = 1;
                                  //       });
                                  //     },
                                  //     style: ElevatedButton.styleFrom(
                                  //       elevation: 5,
                                  //       foregroundColor: Colors.black54,
                                  //       backgroundColor: _currentIndex == 1 ? Colors.grey[400] : Colors.white60,
                                  //     ),
                                  //     child: const Text(
                                  //       '教師公告',
                                  //       style: TextStyle(
                                  //           fontSize: 18,
                                  //           fontWeight: FontWeight.bold,
                                  //           color: Colors.black87
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // Expanded(
                                  //   flex: 1,
                                  //   child: ElevatedButton(
                                  //     onPressed: () {
                                  //       setState(() {
                                  //         _showButton1 = false;
                                  //         _showButton2 = false;
                                  //         _showButton3 = true;
                                  //         _currentIndex = 2;
                                  //       });
                                  //     },
                                  //     style: ElevatedButton.styleFrom(
                                  //       elevation: 5,
                                  //       foregroundColor: Colors.black54,
                                  //       backgroundColor: _currentIndex == 2 ? Colors.grey[400] : Colors.white60,
                                  //     ),
                                  //     child: const Text(
                                  //       '學校公告',
                                  //       style: TextStyle(
                                  //           fontSize: 18,
                                  //           fontWeight: FontWeight.bold,
                                  //           color: Colors.black87
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  const SizedBox(width: 20,),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Divider(color: Colors.grey, thickness: 2,),
                            // SizedBox(height: 35),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: _buttonList(0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            else {
              return Center(child: CircularProgressIndicator());}
          }
        },
      ),
    );
  }
}
