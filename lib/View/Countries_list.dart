import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../services/States_services.dart';
import 'detail_screen.dart';

class Countries_list extends StatefulWidget {
  const Countries_list({Key? key}) : super(key: key);

  @override
  State<Countries_list> createState() => _Countries_listState();
}

class _Countries_listState extends State<Countries_list> {
  TextEditingController searchcontroller = TextEditingController();
  States_Services states_services = States_Services();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchcontroller,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                    hintText: 'Search with country name',
                    contentPadding:
                        const EdgeInsetsDirectional.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0))),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: states_services.Countrieslistapi(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String name =
                                snapshot.data![index]['country'].toString();
                            if (searchcontroller.text.isEmpty) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Detail_Screen(
                                              name: snapshot.data![index]['country'],
                                              critical: snapshot.data![index]
                                                  ['critical'],
                                              active: snapshot.data![index]
                                                  ['active'],
                                              image: snapshot.data![index]
                                                  ['countryInfo']['flag'],
                                              test: snapshot.data![index]
                                                  ['tests'],
                                              todayrecovered: snapshot
                                                  .data![index]['todayRecovered'],
                                              totalCases: snapshot.data![index]
                                                  ['cases'],
                                              totaldeaths: snapshot.data![index]
                                                  ['deaths'],
                                              totalrecovered:
                                                  snapshot.data![index]
                                                      ['recovered'])));
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']
                                      .toString()),
                                  subtitle: Text(snapshot.data![index]['cases']
                                      .toString()),
                                  leading: Image(
                                      height: 60,
                                      width: 60,
                                      image: NetworkImage(snapshot.data![index]
                                              ['countryInfo']['flag']
                                          .toString())),
                                ),
                              );
                            } else if (name.toLowerCase().contains(
                                searchcontroller.text.toLowerCase())) {
                              return InkWell(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Detail_Screen(
                                              name: snapshot.data![index]['country'],
                                              critical: snapshot.data![index]
                                              ['critical'],
                                              active: snapshot.data![index]
                                              ['active'],
                                              image: snapshot.data![index]
                                              ['countryInfo']['flag'],
                                              test: snapshot.data![index]
                                              ['tests'],
                                              todayrecovered: snapshot
                                                  .data![index]['todayRecovered'],
                                              totalCases: snapshot.data![index]
                                              ['cases'],
                                              totaldeaths: snapshot.data![index]
                                              ['deaths'],
                                              totalrecovered:
                                              snapshot.data![index]
                                              ['recovered'])));
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']
                                      .toString()),
                                  subtitle: Text(
                                      snapshot.data![index]['cases'].toString()),
                                  leading: Image(
                                      height: 60,
                                      width: 60,
                                      image: NetworkImage(snapshot.data![index]
                                              ['countryInfo']['flag']
                                          .toString())),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          });
                    } else {
                      return ListView.builder(
                          itemCount: 7,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                                baseColor: Colors.grey.shade100,
                                highlightColor: Colors.grey.shade700,
                                child: ListTile(
                                    title: Container(
                                        height: 10,
                                        width: 89,
                                        color: Colors.white),
                                    subtitle: Container(
                                      height: 10,
                                      width: 89,
                                      color: Colors.white,
                                    ),
                                    leading: Container(
                                      height: 50,
                                      width: 58,
                                      color: Colors.white,
                                    )));
                          });
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
