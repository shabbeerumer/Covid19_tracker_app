import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../modals/WorldStatesModal.dart';
import '../services/States_services.dart';
import 'Countries_list.dart';

class worldStatesScreen extends StatefulWidget {
  const worldStatesScreen({Key? key}) : super(key: key);

  @override
  State<worldStatesScreen> createState() => _worldStatesScreenState();
}

class _worldStatesScreenState extends State<worldStatesScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    States_Services states_services = States_Services();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              Expanded(
                child: FutureBuilder(
                    future: states_services.FeatchWorldStateRecords(),
                    builder:
                        (context, AsyncSnapshot<WorldStatesModal> snapshot) {
                      if (!snapshot.hasData) {
                        return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50.0,
                            controller: _controller,
                          ),
                        );
                      } else {
                        print(
                            double.parse(snapshot.data!.recovered.toString()));
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              PieChart(
                                dataMap: {
                                  'Total': double.parse(
                                      snapshot.data!.cases.toString()),
                                  'Recovery': double.parse(
                                      snapshot.data!.recovered.toString()),
                                  'Deaths': double.parse(
                                      snapshot.data!.deaths.toString()),
                                },
                                chartValuesOptions: const ChartValuesOptions(
                                    showChartValuesInPercentage: true),
                                chartType: ChartType.ring,
                                animationDuration:
                                    const Duration(milliseconds: 1200),
                                colorList: colorList,
                                chartRadius:
                                    MediaQuery.of(context).size.width / 3.2,
                                legendOptions: const LegendOptions(
                                    legendPosition: LegendPosition.left),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                            .06),
                                child: Card(
                                  child: Column(
                                    children: [
                                      ResuableRow(
                                        value: snapshot.data!.cases.toString(),
                                        title: 'TOTAL',
                                      ),
                                      ResuableRow(
                                        value: snapshot.data!.deaths.toString(),
                                        title: 'Deaths',
                                      ),
                                      ResuableRow(
                                        value:
                                            snapshot.data!.recovered.toString(),
                                        title: 'Recovered',
                                      ),
                                      ResuableRow(
                                        value: snapshot.data!.active.toString(),
                                        title: 'Active',
                                      ),
                                      ResuableRow(
                                        value:
                                            snapshot.data!.critical.toString(),
                                        title: 'Critical',
                                      ),
                                      ResuableRow(
                                        value: snapshot.data!.todayDeaths
                                            .toString(),
                                        title: 'Today Deaths',
                                      ),
                                      ResuableRow(
                                        value: snapshot.data!.todayRecovered
                                            .toString(),
                                        title: 'Today Recovered',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Countries_list()));
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: const Color(
                                        0xff1aa260,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Center(
                                      child: Text('Track countries')),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResuableRow extends StatelessWidget {
  String title, value;
  ResuableRow({Key? key, required this.value, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider()
        ],
      ),
    );
  }
}
