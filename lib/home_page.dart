import 'package:dev_test/service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic>? _data;
  bool _loading = true;
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    getDataServer();
  }

  void getDataServer ()async {
     Service service = Service();
      dynamic data = await service.getData();
      if(data != null){
        setState(() {
          _loading = false;
          _data = data['accounts'][0]['transactions'];
        });

      }
  }

  @override
  Widget build(BuildContext context) {
    // print("2022-07-07 16:11:06".toIso8601String());
    print(DateFormat.yMMMd().format(DateTime.parse("2022-07-07 16:11:06")));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, 
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.menu, color: Colors.black,), onPressed: (){},),
        title: const Text("Home", style: TextStyle(color: Colors.black),),        
        ),

        body: Container(
            decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/2.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Container(
              padding: const EdgeInsets.only(left: 65, top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Row(children: [
                  const Text('N', style: TextStyle(color: Colors.grey)),
                  const SizedBox(width: 5,),
                  Text('4,521', style: TextStyle(fontSize: 28, color: Colors.green[900]),),
                  const SizedBox(width: 5,),
                  const Text('00', style: TextStyle(color: Colors.grey))
                ],),

                Text("Hyefur Jonathan Balami",style: TextStyle(color: Colors.grey[700])),
                const SizedBox(height: 10,),
                const Text("1100036254", style: TextStyle(color: Colors.grey),),

              ],),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: LineChart(
                  LineChartData(
                    titlesData: FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        dotData: FlDotData(show: false),
                        isCurved: true,
                        curveSmoothness: 0.5,
                        
                        spots: [
                          FlSpot(0, 3),
                          FlSpot(2.6, 2),
                          FlSpot(4.9, 3),
                          FlSpot(6.8, 2.5),
                          FlSpot(7, 3),
                          ],
                          color: Colors.red[100]?.withOpacity(0.3),
                          belowBarData: BarAreaData(
                            show: true,
                            color: Colors.red[100]?.withOpacity(0.3)
                            ),
                      ),
                    ],
                  )
                )
              ),

              _loading == false ? Expanded(
                child: ListView.builder(
                  itemCount: _data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    dynamic eachData = _data?[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                  const CircleAvatar(radius: 25,backgroundImage: AssetImage('images/musty_avatar.jpg'),),
                                  const SizedBox(width: 10,),
                                  Container(
                                    padding: const EdgeInsets.only(top: 0),
                                    width: 150,
                                    child: Text(eachData['narration'], style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                                  ),
                                  const SizedBox(width: 10,),

                                 
                                ],),
                                 Container(
                                    // width: 100,
                                    padding: const EdgeInsets.only(top:0, left: 60),

                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text( DateFormat.yMMMd().format(DateTime.parse(eachData['date'])), style: TextStyle(color: Colors.grey)),

                                        Column(
                                          children: [
                                            Text("-N ${eachData['amount']}", style: TextStyle(color: Colors.red[300])),
                                             const SizedBox(height: 10,),
                                            Text(eachData['category']['name'], style: TextStyle(color: Colors.blue[300], fontSize: 11),)

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(color: Colors.grey,)
                              ],
                            ),
                    );

                  }),
              ) : Container()
          ],),
        ),
    );
  }
}