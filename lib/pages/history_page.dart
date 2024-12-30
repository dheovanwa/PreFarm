import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prefarm/providers/history_providers.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HistoryScreen();
  }
}

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  @override
  void initState() {
    super.initState();
    var dataState = Provider.of<HistoryProvider>(context, listen: false);
    dataState.readYieldJson();
  }

  @override
  Widget build(BuildContext context) {
    var dataState = Provider.of<HistoryProvider>(context);

    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/history_page_background.png'),
          fit: BoxFit.fill,
        )
      ),
      child: Stack(
        children: [
          Positioned(
            left: 5,
            child: Container(
              width: 20,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Color(0xFFC88E2C),
              ),
            ),
          ),
          Positioned(
            right: 5,
            child: Container(
              width: 20,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Color(0xFFC88E2C),
              ),
            ),
          ),
          Positioned(
            right: 20,
            left: 20,
            top: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 155,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 20,
                          left: 5,
                          right: 5,
                          child: Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width-50,
                            decoration: const BoxDecoration(
                              color: Color(0xFFC88E2C),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 40,
                          right: 45,
                          top: 80,
                          child: Container(
                            width: double.infinity,
                            height: 70,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFCA54),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xFFFFA917),
                                  spreadRadius: 3,
                                  offset: Offset(5, 3),
                                )
                              ]
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'History',
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 34,
                                    shadows: [
                                      Shadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.25),
                                        offset: Offset(2, 2),
                                        blurRadius: 2,
                                      )
                                    ]
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 85,
                          left: 65,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 85,
                          right: 65,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          left: 70,
                          child: Container(
                            width: 20,
                            height: 85,
                            decoration: const BoxDecoration(
                              color: Color(0xFF543A00),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(100),
                                bottomRight: Radius.circular(100),
                              )
                            ),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          right: 70,
                          child: Container(
                            width: 20,
                            height: 85,
                            decoration: const BoxDecoration(
                              color: Color(0xFF543A00),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(100),
                                bottomRight: Radius.circular(100),
                              )
                            ),
                          ),
                        ),
                      ]
                    ),
                  ),
                  for (int i = dataState.numberOfPrediction-1; i >= 0; i--)
                    Stack(
                      children: [
                        const SizedBox(
                          width: 270,
                          height: 190,
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: 270,
                            height: 150,
                            decoration: BoxDecoration(
                              color: dataState.selectColorCardFromWeather(dataState.listOfYield[i]),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: dataState.selectBorderColorCardFromWeather(dataState.listOfYield[i]),
                                width: 1,
                              )
                           ),
                           child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 90,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: dataState.selectTopLeftColorCardFromWeather(dataState.listOfYield[i]),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                      border: const Border(
                                        bottom: BorderSide(
                                          color: Color(0xFFFFFFFF),
                                          width: 2,
                                        ),
                                        right: BorderSide(
                                          color: Color(0xFFFFFFFF),
                                          width: 2,
                                        )
                                      )
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        dataState.listOfYield[i].item,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 5
                                    ),
                                    child: SizedBox(
                                      width: 90,
                                      height: 35,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 4
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              dataState.listOfYield[i].date,
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 8,
                                                color: dataState.selectTextColorCardFromWeather(dataState.listOfYield[i]),
                                              ),
                                            ),
                                            Text(
                                              dataState.listOfYield[i].time,
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 8,
                                                color: dataState.selectTextColorCardFromWeather(dataState.listOfYield[i]),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  left: 10
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 175,
                                      height: 95,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(
                                            color: Color(0xFF000000),
                                            width: 1
                                          )
                                        )
                                      ),
                                      padding: const EdgeInsets.only(
                                        right: 10
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Temperature',
                                                style: dataState.selectTextStyleCardFromWeather(dataState.listOfYield[i])
                                              ),
                                              Text(
                                                '${dataState.listOfYield[i].avgTemp.toString()}°C',
                                                textAlign: TextAlign.end,
                                                style: dataState.selectTextStyleCardFromWeather(dataState.listOfYield[i])
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Country',
                                                style: dataState.selectTextStyleCardFromWeather(dataState.listOfYield[i])
                                              ),
                                              Text(
                                                dataState.listOfYield[i].area,
                                                textAlign: TextAlign.end,
                                                style: dataState.selectTextStyleCardFromWeather(dataState.listOfYield[i])
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Rainfall',
                                                style: dataState.selectTextStyleCardFromWeather(dataState.listOfYield[i])
                                              ),
                                              Text(
                                                '${dataState.listOfYield[i].rainFall} mm',
                                                textAlign: TextAlign.end,
                                                style: dataState.selectTextStyleCardFromWeather(dataState.listOfYield[i])
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Pesticides',
                                                style: dataState.selectTextStyleCardFromWeather(dataState.listOfYield[i])
                                              ),
                                              Text(
                                                '${dataState.listOfYield[i].pesticidesTonnes} Tonnes',
                                                textAlign: TextAlign.end,
                                                style: dataState.selectTextStyleCardFromWeather(dataState.listOfYield[i])
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          dataState.selectImageFromWeather(dataState.listOfYield[i]),
                                          const Text(
                                            'Yield',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 10
                                            )
                                          ),
                                          Text(
                                            textAlign: TextAlign.center,
                                            '${dataState.listOfYield[i].yield}\nHg/Ha',
                                            style: dataState.selectTextStyleCardFromWeather(dataState.listOfYield[i]),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                           ),
                          ),
                        ),
                        // Positioned(
                        //   top: 50,
                        //   left: 120,
                        //   right: 120,
                        //   child: Container(
                        //     width: 30,
                        //     height: 30,
                        //     decoration: BoxDecoration(
                        //       color: const Color(0xFF9BEDFF),
                        //       borderRadius: BorderRadius.circular(100),
                        //       border: Border.all(
                        //         color: const Color(0xFF82825F),
                        //         width: 1,
                        //       )
                        //     ),
                        //   ),
                        // ),
                        Positioned(
                          top: 0,
                          right: 128,
                          left: 128,
                          child: Container(
                            height: 79,
                            decoration: const BoxDecoration(
                              color: Color(0xFF543A00),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(3),
                                bottomRight: Radius.circular(3),
                              )
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}