import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("앱 프레임 예제"),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          AlarmPage(), // 이제 첫 번째 탭에 알람 페이지를 표시
          SecondPage(),
          ThirdPage(),
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.blue,
        child: TabBar(
          controller: _tabController,
          indicatorColor: Colors.blue,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.alarm), text: '알람'),
            Tab(icon: Icon(Icons.settings), text: '설정'),
            Tab(icon: Icon(Icons.info), text: '정보'),
          ],
        ),
      ),
    );
  }
}

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  List<Alarm> alarms = [];

  void _addAlarm() {
    setState(() {
      alarms.add(Alarm(time: DateTime.now().add(Duration(hours: 1))));
    });
  }

  void _deleteAlarm(int index) {
    setState(() {
      alarms.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("알람 설정"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addAlarm,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: alarms.length,
        itemBuilder: (context, index) {
          final alarm = alarms[index];
          return ListTile(
            title: Text("${alarm.time.hour}:${alarm.time.minute}"),
            subtitle: Text(alarm.description),
            trailing: Switch(
              value: alarm.isEnabled,
              onChanged: (value) {
                setState(() {
                  alarm.isEnabled = value;
                });
              },
            ),
            onLongPress: () => _deleteAlarm(index),
          );
        },
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Second Page Content"),
    );
  }
}

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Third Page Content"),
    );
  }
}

class Alarm {
  DateTime time;
  String description;
  bool isEnabled;

  Alarm({required this.time, this.description = '', this.isEnabled = true});
}
