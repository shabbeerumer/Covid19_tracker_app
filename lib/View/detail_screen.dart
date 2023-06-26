import 'package:covid_19_tracker_app/View/world_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Detail_Screen extends StatefulWidget {
  String name, image;
  int totalCases,
      totaldeaths,
      totalrecovered,
      active,
      critical,
      todayrecovered,
      test;
  Detail_Screen(
      {Key? key,
      required this.name,
      required this.critical,
      required this.active,
      required this.image,
      required this.test,
      required this.todayrecovered,
      required this.totalCases,
      required this.totaldeaths,
      required this.totalrecovered})
      : super(key: key);

  @override
  State<Detail_Screen> createState() => _Detail_ScreenState();
}

class _Detail_ScreenState extends State<Detail_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(alignment: Alignment.topCenter, children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .067),
              child: Card(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .06,
                    ),
                    ResuableRow(
                      value: widget.totalCases.toString(),
                      title: 'Cases',
                    ),
                    ResuableRow(
                      value: widget.totalrecovered.toString(),
                      title: 'Recovered',
                    ),
                    ResuableRow(
                      value: widget.totaldeaths.toString(),
                      title: 'Death',
                    ),
                    ResuableRow(
                      value: widget.critical.toString(),
                      title: 'Critical',
                    ),
                    ResuableRow(
                      value: widget.totalrecovered.toString(),
                      title: 'Total Recovered',
                    ),
                  ],
                ),
              ),
            ),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                widget.image,
              ),
            )
          ]),
        ],
      ),
    );
  }
}
