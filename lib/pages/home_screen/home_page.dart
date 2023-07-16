import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../../widgets/custom_card.dart';
import '../login_page.dart';
import '../../model/chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, User? user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String profileImage = "assets/images/user_avatar.png";

  List<charts.Series<ChartData, String>> _seriesList = [];
  double _averageProduction = 0;
  double _averageGhi = 0;
  double _averageTemp = 0;

  @override
  void initState() {
    super.initState();
    _loadDataFromJson();
    (user) => print(user);
  }

  void _loadDataFromJson() {
    String jsonData = '''
      [
        {"year":2008,"month":"Jan","ghi":460.3776273734,"temp":33.0949356579,"producao":298324.7025379357},
        {"year":2008,"month":"Fev","ghi":463.0958054894,"temp":13.203870242,"producao":300086.0819571361},
        {"year":2008,"month":"Mar","ghi":143.9752146621,"temp":10.0490439951,"producao":93295.9391010727},
        {"year":2008,"month":"Abr","ghi":318.4623247525,"temp":31.0889873677,"producao":206363.5864396447},
        {"year":2008,"month":"Mai","ghi":85.1168195917,"temp":31.2376265548,"producao":55155.6990954153},
        {"year":2008,"month":"Jun","ghi":378.0917762673,"temp":22.3601092935,"producao":245003.4710212272},
        {"year":2008,"month":"Jul","ghi":591.4969484578,"temp":23.7866624639,"producao":383290.0226006406},
        {"year":2008,"month":"Ago","ghi":410.6787615904,"temp":17.4830463549,"producao":266119.8375105694},
        {"year":2008,"month":"Set","ghi":46.2826615719,"temp":10.9352265001,"producao":29991.1646986046},
        {"year":2008,"month":"Out","ghi":818.4281600597,"temp":27.7985985129,"producao":530341.4477187069},
        {"year":2008,"month":"Nov","ghi":363.0960554707,"temp":20.1493771791,"producao":235286.243945006},
        {"year":2008,"month":"Dez","ghi":143.1778117001,"temp":29.7332908772,"producao":92779.2219816678}
      ]
    ''';

    List<dynamic> data = jsonDecode(jsonData);
    List<ChartData> chartData =
        List<ChartData>.from(data.map((item) => ChartData.fromJson(item)));

    double totalProduction = 0;
    double totalTemp = 0;
    double totalGhi = 0;

    chartData.forEach((data) {
      totalProduction += data.producao;
      totalTemp += data.temp;
      totalGhi += data.ghi;
    });

    double averageProduction = (totalProduction / chartData.length) / 1000;
    double averageGhi = (totalGhi / chartData.length);
    double averageTemp = (totalTemp / chartData.length);

    setState(() {
      _seriesList.add(
        charts.Series<ChartData, String>(
          id: 'Chart',
          domainFn: (ChartData data, _) => data.month,
          measureFn: (ChartData data, _) => data.producao,
          data: chartData,
          labelAccessorFn: (ChartData data, _) =>
              '${data.month}: ${data.producao}',
        ),
      );
      _averageProduction = averageProduction;
      _averageGhi = averageGhi;
      _averageTemp = averageTemp;
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
              toolbarHeight: 100,
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
                                        child: SizedBox(
                                          width: double.infinity,
                                          height: 320,
                                          child: charts.BarChart(
                                            _seriesList,
                                            animate: true,
                                            animationDuration: const Duration(
                                                milliseconds: 500),
                                          ),
                                        )),
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomCard(
                                              backColor: Colors.green,
                                              text: 'Média mensal',
                                              sub_text: 'Produção energetica',
                                              body_text:
                                                  '${_averageProduction.toStringAsFixed(2)} MWh'),
                                          const SizedBox(height: 10.0),
                                          CustomCard(
                                              backColor: Colors.red,
                                              text: 'Média mensal',
                                              sub_text: 'Radiação Global',
                                              body_text:
                                                  '${_averageGhi.toStringAsFixed(2)} w/m²'),
                                          const SizedBox(height: 10.0),
                                          CustomCard(
                                              backColor: const Color.fromARGB(
                                                  255, 231, 103, 29),
                                              text: 'Média mensal',
                                              sub_text: 'Temperatura',
                                              body_text:
                                                  '${_averageTemp.toStringAsFixed(2)} C°'),
                                        ])
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ]))));
  }
}
