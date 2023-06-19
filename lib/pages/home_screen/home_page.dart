import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:wave_progress_widget/wave_progress.dart';
import 'package:flutter/material.dart';

import '../login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, User? user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String profileImage = "assets/images/user_avatar.png";

  List<charts.Series<ChartData, String>> _seriesList = [];
  double _averagePercentage = 0;
  double _totalProduction = 0;

  @override
  void initState() {
    super.initState();
    _loadDataFromJson();
    (user) => print(user);
  }

  void _loadDataFromJson() {
    String jsonData = '''
    [
      {"year": "2008", "month": "jan", "value": 200},
      {"year": "2008","month": "fev", "value": 350},
      {"year": "2008","month": "mar", "value": 420},
      {"year": "2008","month": "abr", "value": 380},
      {"year": "2008","month": "maio", "value": 410},
      {"year": "2008","month": "jun", "value": 500},
      {"year": "2008","month": "jul", "value": 550},
      {"year": "2008","month": "ago", "value": 620},
      {"year": "2008","month": "set", "value": 570},
      {"year": "2008","month": "out", "value": 450},
      {"year": "2008","month": "nov", "value": 400},
      {"year": "2008","month": "dez", "value": 300}
    ]
    ''';

    List<dynamic> data = jsonDecode(jsonData);
    List<ChartData> chartData =
        List<ChartData>.from(data.map((item) => ChartData.fromJson(item)));

    double totalProduction = 0;
    chartData.forEach((data) {
      totalProduction += data.value;
    });
    double averagePercentage = (totalProduction / chartData.length) / 100;
    setState(() {
      _seriesList.add(
        charts.Series<ChartData, String>(
          id: 'Chart',
          domainFn: (ChartData data, _) => data.month,
          measureFn: (ChartData data, _) => data.value,
          data: chartData,
          labelAccessorFn: (ChartData data, _) =>
              '${data.month}: ${data.value}',
        ),
      );
      _totalProduction = totalProduction;
      _averagePercentage = averagePercentage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: AppBar(
              centerTitle: true,
              title: const Text('Solar Ecco'),
              automaticallyImplyLeading: false,
              leadingWidth: 100,
              leading: Padding(
                padding: EdgeInsets.fromLTRB(1, 1, 10, 1),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage(profileImage),
                      ),
                    ]),
              ),
              actions: <Widget>[
                IconButton(
                    icon: const Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      auth.signOut().then((res) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            (Route<dynamic> route) => false);
                      });
                    })
              ],
              elevation: 10,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/baner.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )),
        body: SafeArea(
            top: true,
            child: Align(
                alignment: const AlignmentDirectional(0, -0.8),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Card(
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    const Text(
                                      "Media mensal de Energia produzida kWh",
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color:
                                            Color.fromARGB(255, 80, 170, 255),
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(16, 12, 16, 0),
                                        child: Container(
                                          width: double.infinity,
                                          height: 350,
                                          child: charts.BarChart(
                                            _seriesList,
                                            animate: true,
                                            animationDuration: const Duration(
                                                milliseconds: 500),
                                          ),
                                        )),
                                    Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(16, 12, 16, 0),
                                        child: Container(
                                            width: double.infinity,
                                            height: 150,
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 80, 170, 255),
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 5,
                                                    color: Color(0x23000000),
                                                    offset: Offset(0, 2))
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            alignment:
                                                const AlignmentDirectional(
                                                    0, 1),
                                            child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                        16, 16, 16, 16),
                                                child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: <Widget>[
                                                      Expanded(
                                                          child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                            Text('Média mensal',
                                                                style:
                                                                    const TextStyle(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 24,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                )),
                                                            const Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                        0,
                                                                        4,
                                                                        0,
                                                                        0),
                                                                child:
                                                                    const Text(
                                                                  'Produção energetica',
                                                                  style:
                                                                      const TextStyle(
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    color: Color(
                                                                        0x9AFFFFFF),
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                )),
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                            .fromSTEB(0,
                                                                        8, 0, 0),
                                                                child: Text(
                                                                    '${_averagePercentage.toStringAsFixed(2)}%',
                                                                    style: const TextStyle(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            36,
                                                                        fontWeight:
                                                                            FontWeight.w600))),
                                                          ])),
                                                      WaveProgress(
                                                          140.0,
                                                          Colors.green,
                                                          Colors.greenAccent,
                                                          _averagePercentage)
                                                    ])))),
                                    // Container(
                                    //   margin: EdgeInsets.only(
                                    //       top: 20.0, bottom: 20.0),
                                    //   child: Slider(
                                    //       max: 100.0,
                                    //       min: 0.0,
                                    //       value: _averagePercentage ,
                                    //       onChanged: (value) {
                                    //         setState(() => _averagePercentage  = value);
                                    //       }),
                                    // ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ]))));
  }
}

class ChartData {
  final String year;
  final String month;
  final int value;

  ChartData({required this.year, required this.month, required this.value});

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      year: json['year'],
      month: json['month'],
      value: json['value'],
    );
  }
}
