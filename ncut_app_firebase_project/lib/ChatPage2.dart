import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // Required for specifying coordinates
import 'main.dart';

class ChatPage extends StatefulWidget {const ChatPage({Key? key}) : super(key: key);@override _ChatPageState createState() => _ChatPageState();}

class _ChatPageState extends State<ChatPage> {
  LatLng currentLocation = LatLng(24.09249, 120.721684);

  String a='0' ;

  @override
  Widget build(BuildContext context) {
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.5;// 設置最高高度
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.04;// 設置最低高度


    return Scaffold(
        body: FutureBuilder<Map<String, dynamic>>(
            future: data(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                if (snapshot.hasData) {
                  final data = snapshot.data!;
                  final routeArrays = data['routeArrays'];
                  List<String> keysRoute1 = [];
                  List<String> valueRoute1 = [];
                  List<String> keysRoute2 = [];
                  List<String> valueRoute2 = [];
                  List<String> keysRoute3 = [];
                  List<String> valueRoute3 = [];

                  if (routeArrays.isNotEmpty) {
                    List<String> all = [];
                    for (var outerEntry in routeArrays.entries) {
                      all.add(outerEntry.toString());
                      var oneKey = outerEntry.key;
                      var oneValue = outerEntry.value;
                      keysRoute1.add(oneKey.toString());
                      valueRoute1.add(oneValue.toString());
                      if (oneValue is Map) {
                        for (var twoEntry in oneValue.entries) {
                          var twoKey = twoEntry.key;
                          var twoValue = twoEntry.value;
                          keysRoute2.add(twoKey.toString());
                          valueRoute2.add(twoValue.toString());
                          if (twoValue is Map) {
                            for (var threeEntry in twoValue.entries) {
                              var threeKey = threeEntry.key;
                              var threeValue = threeEntry.value;
                              keysRoute3.add(threeKey.toString());
                              valueRoute3.add(threeValue.toString());
                            }
                          }
                        }
                      }
                    }
                    print(valueRoute2);
                  }
                  return SlidingUpPanel(
                      maxHeight: panelHeightOpen,
                      minHeight: panelHeightClosed,
                      parallaxEnabled: true,// 跟隨移動
                      parallaxOffset: .5,// 跟隨多少
                      borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                      body: Column(
                          children: [
                            Expanded(
                              child: FlutterMap(
                                options: MapOptions(
                                  center: currentLocation,
                                  zoom: 13.0,
                                ),
                                layers: [
                                  TileLayerOptions(
                                    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                    subdomains: ['a', 'b', 'c'],
                                  ),
                                  MarkerLayerOptions(
                                    markers: [
                                      Marker(
                                        width: 40.0,
                                        height: 40.0,
                                        point: currentLocation,
                                        builder: (ctx) => Container(
                                          child: Icon(
                                            Icons.location_on,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ]
                      ),
                      panelBuilder: (controller) => PanelWidget(controller: controller,routeArrays:routeArrays,keysRoute1:keysRoute1,valueRoute3:valueRoute3)
                  );
                }
                else {return Center(child: CircularProgressIndicator());}
              }
            }
        )
    );
  }
}

class PanelWidget extends StatefulWidget {
  final ScrollController controller;
  var routeArrays;
  List<String> keysRoute1;
  List<String> valueRoute3;

  PanelWidget({
    Key? key,
    required this.controller,
    required this.routeArrays,
    required this.keysRoute1,
    required this.valueRoute3,
  }) : super(key: key);
  @override
  _PanelWidgetState createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  int nKey = 0;
  bool isCardVisible=false;
  bool isCardVisible2=false;
  int GorB =0;
  @override
  Widget build(BuildContext context) {


    return ListView(
      padding: EdgeInsets.zero,
      controller: widget.controller,
      children: <Widget>[
        const SizedBox(height: 10),
        buildDragHandle(),
        // const SizedBox(height: 36),
        // buildAboutContent(),
        // const SizedBox(height: 24),
        const SizedBox(height: 10),
        Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(1, (index) {
                  if (widget.routeArrays.isNotEmpty) {
                    return Container(
                      child: Row(
                        children: [
                          for (int i = 0; i < widget.keysRoute1.length; i++)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0), // 设置按钮的水平间距
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    nKey = i;
                                    isCardVisible = true;
                                    print("Button position: $i");
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: nKey == i ? Colors.grey[700] : Colors.grey[300],
                                  foregroundColor: nKey == i ? Colors.grey[300] : Colors.grey[700],
                                ),
                                child: Text(widget.keysRoute1[i]),
                              ),
                            )
                        ],
                      ),
                    );
                  }
                  else {
                    return Text("");
                  }
                }),
              ),
            ),
            if(isCardVisible)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        GorB = 0;
                        isCardVisible2 = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(175, 10),
                      backgroundColor: GorB==0 ? Colors.grey[700] : Colors.grey[300],
                      foregroundColor: GorB==0 ? Colors.grey[300] : Colors.grey[700],
                    ),
                    child: Text("去程"),
                  ),
                  SizedBox(width: 10,),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        GorB = 1;
                        isCardVisible2 = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(175, 10),
                      backgroundColor: GorB==1 ? Colors.grey[700] : Colors.grey[300],
                      foregroundColor: GorB==1 ? Colors.grey[300] : Colors.grey[700],
                    ),
                    child: Text("回程"),
                  ),

                ],
              ),
            if(isCardVisible2)
              if(GorB==0)
                if(nKey==0)
                  Column(
                    children: List.generate(10, (index) {
                      String cardText = widget.valueRoute3[GorB].split(',')[index+nKey*10];
                      if (index == 0) {
                        cardText = cardText.substring(2); // Skip the opening square bracket for the first card
                      }
                      return Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Card(
                          elevation: 8,
                          color: Colors.lightGreen[100],
                          child: Center(
                            child: Text(cardText,style: TextStyle(fontSize: 20),),
                          ),
                        ),
                      );
                    }),
                  ),
            if(nKey==1)
              Column(
                children: List.generate(10, (index) {
                  String cardText = widget.valueRoute3[GorB].split(',')[index+nKey*10];
                  if (index == 0) {
                    cardText = cardText.substring(2); // Skip the opening square bracket for the first card
                  }
                  return Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Card(
                      elevation: 8,
                      color: Colors.lightGreen[100],
                      child: Center(
                        child: Text(cardText,style: TextStyle(fontSize: 20),),
                      ),
                    ),
                  );
                }),
              ),
            if(nKey==2)
              Column(
                children: List.generate(10, (index) {
                  String cardText = widget.valueRoute3[GorB].split(',')[index+nKey*10];
                  if (index == 0) {
                    cardText = cardText.substring(2); // Skip the opening square bracket for the first card
                  }
                  return Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Card(
                      elevation: 8,
                      color: Colors.lightGreen[100],
                      child: Center(
                        child: Text(cardText,style: TextStyle(fontSize: 20),),
                      ),
                    ),
                  );
                }),
              ),
            if(nKey==3)
              Column(
                children: List.generate(10, (index) {
                  String cardText = widget.valueRoute3[GorB].split(',')[index+nKey*10];
                  if (index == 0) {
                    cardText = cardText.substring(2); // Skip the opening square bracket for the first card
                  }
                  return Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Card(
                      elevation: 8,
                      color: Colors.lightGreen[100],
                      child: Center(
                        child: Text(cardText,style: TextStyle(fontSize: 20),),
                      ),
                    ),
                  );
                }),
              ),
            if(nKey==4)
              Column(
                children: List.generate(10, (index) {
                  String cardText = widget.valueRoute3[GorB].split(',')[index+nKey*10];
                  if (index == 0) {
                    cardText = cardText.substring(2); // Skip the opening square bracket for the first card
                  }
                  return Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Card(
                      elevation: 8,
                      color: Colors.lightGreen[100],
                      child: Center(
                        child: Text(cardText,style: TextStyle(fontSize: 20),),
                      ),
                    ),
                  );
                }),
              )
            else if(GorB==1)
              if(nKey==0)
                Column(
                  children: List.generate(10, (index) {
                    String cardText = widget.valueRoute3[GorB].split(',')[index+nKey*10];
                    if (index == 0) {
                      cardText = cardText.substring(2); // Skip the opening square bracket for the first card
                    }
                    return Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Card(
                        elevation: 8,
                        color: Colors.lightGreen[100],
                        child: Center(
                          child: Text(cardText,style: TextStyle(fontSize: 20),),
                        ),
                      ),
                    );
                  }),
                ),
            if(nKey==1)
              Column(
                children: List.generate(10, (index) {
                  String cardText = widget.valueRoute3[GorB].split(',')[index+nKey*10];
                  if (index == 0) {
                    cardText = cardText.substring(2); // Skip the opening square bracket for the first card
                  }
                  return Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Card(
                      elevation: 8,
                      color: Colors.lightGreen[100],
                      child: Center(
                        child: Text(cardText,style: TextStyle(fontSize: 20),),
                      ),
                    ),
                  );
                }),
              ),
            if(nKey==2)
              Column(
                children: List.generate(10, (index) {
                  String cardText = widget.valueRoute3[GorB].split(',')[index+nKey*10];
                  if (index == 0) {
                    cardText = cardText.substring(2); // Skip the opening square bracket for the first card
                  }
                  return Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Card(
                      elevation: 8,
                      color: Colors.lightGreen[100],
                      child: Center(
                        child: Text(cardText,style: TextStyle(fontSize: 20),),
                      ),
                    ),
                  );
                }),
              ),
            if(nKey==3)
              Column(
                children: List.generate(10, (index) {
                  String cardText = widget.valueRoute3[GorB].split(',')[index+nKey*10];
                  if (index == 0) {
                    cardText = cardText.substring(2); // Skip the opening square bracket for the first card
                  }
                  return Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Card(
                      elevation: 8,
                      color: Colors.lightGreen[100],
                      child: Center(
                        child: Text(cardText,style: TextStyle(fontSize: 20),),
                      ),
                    ),
                  );
                }),
              ),
            if(nKey==4)
              Column(
                children: List.generate(10, (index) {
                  String cardText = widget.valueRoute3[GorB].split(',')[index+nKey*10];
                  if (index == 0) {
                    cardText = cardText.substring(2); // Skip the opening square bracket for the first card
                  }
                  return Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Card(
                      elevation: 8,
                      color: Colors.lightGreen[100],
                      child: Center(
                        child: Text(cardText,style: TextStyle(fontSize: 20),),
                      ),
                    ),
                  );
                }),
              )
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }




  // 上拉線
  Widget buildDragHandle() => Center(
    child: Column(
      children: [
        Container(
          width: 30,
          height: 2.5,
          decoration: BoxDecoration(
            color: Colors.grey[300],
          ),
        ),
        SizedBox(height: 2),
        Container(
          width: 30,
          height: 2.5,
          decoration: BoxDecoration(
            color: Colors.grey[300],
          ),
        ),
        SizedBox(height: 2),
        Container(
          width: 30,
          height: 2.5,
          decoration: BoxDecoration(
            color: Colors.grey[300],
          ),
        ),
      ],
    ),
  );

  // 內容
  Widget buildAboutContent() => Center(
    // padding:(EdgeInsets.symmetric(horizontal: 24)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("data"),
        SizedBox(height: 12),
        Text(''''''),
      ],
    ),
  );
}
