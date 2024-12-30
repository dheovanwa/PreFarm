import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:prefarm/providers/home_providers.dart';
import 'package:prefarm/pages/history_page.dart';
import 'package:prefarm/pages/guide_page.dart';
import 'package:prefarm/crop_yield.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 1;

  final List<Widget> tabs = const [
    HistoryPage(),
    HomeScreen(),
    GuidePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (int index) {
          setState(() {
            _currentPage = index;
          });
        },
        backgroundColor: const Color.fromARGB(255, 55, 54, 54),
        unselectedItemColor: Colors.white,
        selectedItemColor: const Color(0xFFFFF900),
        selectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history,
            ),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu_book,
            ),
            label: 'Guide'
          ),
        ],
      ),
      body: tabs[_currentPage],
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var dataState = Provider.of<HomeProvider>(context);

    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        )
      ),
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            dataState.refresh();
          });
          return Future<void>.delayed(const Duration(seconds: 1));
        },
        child: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(), 
              WeatherWidget(),
              YieldPredictionButton(),
              SuccessPredictionButton(),
              ResultsWidget(),
              NewsCarousel(),
            ],
          ),
        ),
      ),
    );
  }
}

class NewsCarousel extends StatefulWidget {

  const NewsCarousel({
    super.key,
  });

  @override
  State<NewsCarousel> createState() => _NewsCarouselState();
}

class _NewsCarouselState extends State<NewsCarousel> {
  final CarouselSliderController buttonCarouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'News',
                style: TextStyle(
                  color: Color(0xFF505050),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  shadows: [
                    Shadow(
                      blurRadius: 1,
                      color: Color.fromARGB(72, 0, 0, 0),
                      offset: Offset(1, 1)
                    )
                  ]
                ),
              ),
            ),
            SizedBox(
              width: 300,
              height: 250,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 25,
                      height: 1000,
                      decoration: const BoxDecoration(
                        color: Color(0xFFCD9D00),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)
                        )
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10
                    ),
                    child: Container(
                      width: 300,
                      height: 200,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDFAC04),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFF493800),
                            blurRadius: 10,
                            offset: Offset(2, 2)
                          )
                        ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 10
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 285,
                              height: 165,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFD64E),
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: CarouselSlider(
                                items: [
                                  InkWell(
                                    child: Image.asset(
                                      'assets/images/carousel1.png',
                                    ),
                                    onTap: () async =>
                                      await launchUrl(
                                        Uri.parse('https://www.tempo.co/video/arsip/melihat-produk-baru-drone-dji-bisa-penuhi-kebutuhan-pertanian-indonesia-20169'),
                                        mode: LaunchMode.inAppBrowserView
                                      )
                                  ),
                                  InkWell(
                                    child: Image.asset(
                                      'assets/images/carousel2.png',
                                    ),
                                    onTap: () async =>
                                      await launchUrl(
                                        Uri.parse('https://pustaka.setjen.pertanian.go.id/info-literasi/info-teknologi-teknologi-pertanian-modern-untuk-petani-milenial'),
                                        mode: LaunchMode.inAppBrowserView
                                      )
                                  ),
                                  InkWell(
                                    child: Image.asset(
                                      'assets/images/carousel3.png',
                                    ),
                                    onTap: () async =>
                                      await launchUrl(
                                        Uri.parse('https://money.kompas.com/read/2024/10/25/174600726/pupuk-indonesia-dukung-percepatan-swasembada-pangan-dengan-teknologi'),
                                        mode: LaunchMode.inAppBrowserView
                                      )
                                  ),
                                ],
                                options: CarouselOptions(
                                  height: 150,
                                  autoPlay: true,
                                  enableInfiniteScroll: true,
                                  viewportFraction: 1,
                                  autoPlayInterval: const Duration(seconds: 3),
                                  onPageChanged: (index, _) {
                                    setState(() {
                                      context.read<HomeProvider>().setCurrentNewsPage(index);
                                    });
                                  }
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (int i = 0; i < 3; i++)
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 10
                                    ),
                                    height: 5,
                                    width: 5,
                                    decoration: BoxDecoration(
                                      color: i == context.read<HomeProvider>().currentNewsPage ? const Color(0xFFFFF0BD) : const Color(0xFF5F4903),
                                      shape: BoxShape.circle,
                                    ),
                                  )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ResultsWidget extends StatefulWidget {
  const ResultsWidget({
    super.key,
  });

  @override
  State<ResultsWidget> createState() => _ResultsWidgetState();
}

class _ResultsWidgetState extends State<ResultsWidget> {
  @override
  Widget build(BuildContext context) {
    var dataState = Provider.of<HomeProvider>(context);

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Latest Result',
                style: TextStyle(
                  color: Color(0xFF505050),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  shadows: [
                    Shadow(
                      blurRadius: 1,
                      color: Color.fromARGB(72, 0, 0, 0),
                      offset: Offset(1, 1)
                    )
                  ]
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 0
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      color: const Color(0xFF000000),
                      borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFBDECF4),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5)
                                  ),
                                  border: Border(
                                    top: BorderSide(
                                      color: Color(0xFF006374),
                                      width: 2,
                                    ),
                                    left: BorderSide(
                                      color: Color(0xFF006374),
                                      width: 2,
                                    )
                                  )
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          top: 10
                                        ),
                                        child: Text(
                                          'Temperature',
                                          style: TextStyle(
                                            color: Color(0xFF006374),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 15
                                        ),
                                        child: Text(
                                          '${dataState.latestYield.avgTemp}°C',
                                          style: const TextStyle(
                                            color: Color(0xFF006374),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Image.asset(
                                          'assets/icons/temperature.png',
                                          width: 50,
                                          height: 50,
                                          color: const Color(0xFF006374),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 150,
                                height: 150,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFCDFF9A),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5)
                                  ),
                                  border: Border(
                                    top: BorderSide(
                                      color: Color(0xFF3B7600),
                                      width: 2,
                                    ),
                                    right: BorderSide(
                                      color: Color(0xFF3B7600),
                                      width: 2
                                    )
                                  )
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                          
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          top: 10
                                        ),
                                        child: Text(
                                          'Country',
                                          style: TextStyle(
                                            color: Color(0xFF3B7600),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 15
                                        ),
                                        child: Text(
                                          dataState.latestYield.area,
                                          style: const TextStyle(
                                            color: Color(0xFF3B7600),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Image.asset(
                                          'assets/icons/globe.png',
                                          width: 50,
                                          height: 50,
                                          color: const Color(0xFF3B7600),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF98FFD2),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5)
                                  ),
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xFF3B7600),
                                      width: 2,
                                    ),
                                    left: BorderSide(
                                      color: Color(0xFF3B7600),
                                      width: 2,
                                    )
                                  )
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                          
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 3
                                          ),
                                          child: Image.asset(
                                            'assets/icons/rain-cloud.png',
                                            width: 50,
                                            height: 50,
                                            color: const Color(0xFF3B7600),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 15,
                                        ),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '${dataState.latestYield.rainFall}',
                                                style: const TextStyle(
                                                  color: Color(0xFF3B7600),
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20
                                                ),
                                              ),
                                              const TextSpan(
                                                text: ' mm',
                                                style: TextStyle(
                                                  color: Color(0xFF3B7600),
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16
                                                ),
                                              ),
                                            ]
                                          ),
                                        ) 
                                        
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          bottom: 10
                                        ),
                                        child: Text(
                                          'Rainfall',
                                          style: TextStyle(
                                            color: Color(0xFF3B7600),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 150,
                                height: 150,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF97BDF5),
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(5)
                                  ),
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xFF003076),
                                      width: 2,
                                    ),
                                    right: BorderSide(
                                      color: Color(0xFF003076),
                                      width: 2
                                    )
                                  )
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                          
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Image.asset(
                                          'assets/icons/pesticide.png',
                                          width: 50,
                                          height: 50,
                                          color: const Color(0xFF003076),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 15
                                        ),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '${dataState.latestYield.pesticidesTonnes}',
                                                style: const TextStyle(
                                                  color: Color(0xFF003076),
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20
                                                ),
                                              ),
                                              const TextSpan(
                                                text: ' Tonnes/ha',
                                                style: TextStyle(
                                                  color: Color(0xFF003076),
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16
                                                ),
                                              ),
                                            ]
                                          ),
                                        )
                                        
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          bottom: 10
                                        ),
                                        child: Text(
                                          'Pesticides',
                                          style: TextStyle(
                                            color: Color(0xFF003076),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          color: const Color(0xFFDCFF3F),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: const Color(0xFF485800),
                            width: 2,
                          )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              dataState.latestYield.item,
                              style: const TextStyle(
                                color: Color(0xFF485800),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                            const Text(
                              'Yield',
                              style: TextStyle(
                                color: Color(0xFF485800),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '${dataState.latestYield.yield}\nHg/Ha',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF485800),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SuccessPredictionButton extends StatefulWidget {
  const SuccessPredictionButton({
    super.key,
  });

  @override
  State<SuccessPredictionButton> createState() => _SuccessPredictionButtonState();
}

class _SuccessPredictionButtonState extends State<SuccessPredictionButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 20,
              decoration: const BoxDecoration(
                color: Color(0xFF543A00),
              ),
            ),
            Positioned(
              left: 57,
              bottom: -25,
              child: Transform.rotate(
                angle: -1,
                child: Container(
                  width: 15,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Color(0xFF805F16),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 57,
              bottom: -25,
              child: Transform.rotate(
                angle: 1,
                child: Container(
                  width: 15,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Color(0xFF805F16),
                  ),
                ),
              ),
            ),
          ],
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 20,
              decoration: const BoxDecoration(
                color: Color(0x00543A00),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                right: 15,
                left: 15
              ),
              child: Container(
                width: double.infinity,
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0xFF543A00),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color.fromARGB(64, 0, 0, 0),
                      spreadRadius: 0,
                      offset: Offset(0, 5),  
                    ),
                  ]
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 70
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF8A6000),
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFFFFFFFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)
                        )
                      ),
                      onPressed: () {
                        openSuccessPredictionSoilDialog(context);
                      },
                      child: const Text(
                        'Prediction of Planting Success',
                        style: TextStyle(
                          color: Color(0xFFFFD578),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 30,
              left: 25,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF8A6000),
                  borderRadius: BorderRadius.circular(100)
                ),
              ),
            ),
            Positioned(
              top: 30,
              right: 25,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF8A6000),
                  borderRadius: BorderRadius.circular(100)
                ),
              ),
            ),
            Positioned(
              top: -20,
              left: 35,
              child: Container(
                width: 20,
                height: 80,
                decoration: const BoxDecoration(
                  color: Color(0xFFC7A14D),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(100)
                  )
                ),
              ),
            ),
            Positioned(
              top: -20,
              right: 35,
              child: Container(
                width: 20,
                height: 80,
                decoration: const BoxDecoration(
                  color: Color(0xFFC7A14D),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(100)
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Future openSuccessPredictionSoilDialog(BuildContext cropSuccessPredictionSoilContext) {
    var dataState = Provider.of<HomeProvider>(cropSuccessPredictionSoilContext, listen: false);

    List<String> listOfSoil = dataState.listOfSoil;
    String dropDownValue = dataState.selectedSoilType;

    return showDialog(
      context: cropSuccessPredictionSoilContext,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF604200),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        title: const Text(
          'Soil Type',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            color: Color(0xFFD09103),
          ),
        ),
        content: SizedBox(
          height: 50,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Align(
              alignment: Alignment.center,
              child: DropdownButtonFormField<String>(
                value: dropDownValue,
                isExpanded: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20
                ),
                icon: Image.asset(
                  'assets/icons/dropdown-arrow.png',
                  scale: 2,
                ),
                style: const TextStyle(
                  color: Color(0xFFD09103),
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 12
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                onChanged: (String? value) {
                  setState(() {
                    dropDownValue = value!;
                    dataState.selectedSoilType = dropDownValue;
                  });
                },
                borderRadius: BorderRadius.circular(10),
                items: listOfSoil.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text('${value[0].toUpperCase()}${value.substring(1)}'),
                  );
                }).toList(),
              ),
            ),
          )
        ),
        actions: [
          Container(
            height: 35,
            width: 70,
            decoration: BoxDecoration(
              color: const Color(0xFFB07A01),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white,
                width: 2,
              )
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFB07A01),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                alignment: AlignmentDirectional.center
              ),
              onPressed: () {
                setState(() {
                  dataState.selectedCountry = dropDownValue;
                  Navigator.of(context).pop();
                  openSuccessPredictionWaterFrequencyDialog(cropSuccessPredictionSoilContext);
                });
              },
              child: const Text(
                'Next',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future openSuccessPredictionWaterFrequencyDialog(BuildContext cropSuccessPredictionWaterFrequencyContext) {
    var dataState = Provider.of<HomeProvider>(cropSuccessPredictionWaterFrequencyContext, listen: false);

    List<String> listOfWaterFrequency = dataState.listOfWaterFrequency;
    String dropDownValue = dataState.selectedWaterFrequency;

    return showDialog(
      context: cropSuccessPredictionWaterFrequencyContext,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF604200),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        title: const Text(
          'Water Frequency',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            color: Color(0xFFD09103),
          ),
        ),
        content: SizedBox(
          height: 50,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Align(
              alignment: Alignment.center,
              child: DropdownButtonFormField<String>(
                value: dropDownValue,
                isExpanded: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20
                ),
                icon: Image.asset(
                  'assets/icons/dropdown-arrow.png',
                  scale: 2,
                ),
                style: const TextStyle(
                  color: Color(0xFFD09103),
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 12
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                onChanged: (String? value) {
                  setState(() {
                    dropDownValue = value!;
                    dataState.selectedWaterFrequency = dropDownValue;
                  });
                },
                borderRadius: BorderRadius.circular(10),
                items: listOfWaterFrequency.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text('${value[0].toUpperCase()}${value.substring(1)}'),
                  );
                }).toList(),
              ),
            ),
          )
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          Container(
            height: 35,
            width: 90,
            decoration: BoxDecoration(
              color: const Color(0xFF5A3E00),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white,
                width: 2,
              )
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                alignment: AlignmentDirectional.center
              ),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                  openSuccessPredictionSoilDialog(cropSuccessPredictionWaterFrequencyContext);
                });
              },
              child: const Text(
                'Previous',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Container(
            height: 35,
            width: 70,
            decoration: BoxDecoration(
              color: const Color(0xFFB07A01),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white,
                width: 2,
              )
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFB07A01),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                alignment: AlignmentDirectional.center
              ),
              onPressed: () {
                setState(() {
                  dataState.selectedCountry = dropDownValue;
                  Navigator.of(context).pop();
                  openSuccessPredictionFertilizerDialog(cropSuccessPredictionWaterFrequencyContext);
                });
              },
              child: const Text(
                'Next',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future openSuccessPredictionFertilizerDialog(BuildContext cropSuccessPredictionFertilizerContext) {
    var dataState = Provider.of<HomeProvider>(cropSuccessPredictionFertilizerContext, listen: false);

    List<String> listOfFertilizer = dataState.listOfFertilizer;
    String dropDownValue = dataState.selectedFertilizer;

    return showDialog(
      context: cropSuccessPredictionFertilizerContext,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF604200),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        title: const Text(
          'Fertilizer Type',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            color: Color(0xFFD09103),
          ),
        ),
        content: SizedBox(
          height: 50,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Align(
              alignment: Alignment.center,
              child: DropdownButtonFormField<String>(
                value: dropDownValue,
                isExpanded: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20
                ),
                icon: Image.asset(
                  'assets/icons/dropdown-arrow.png',
                  scale: 2,
                ),
                style: const TextStyle(
                  color: Color(0xFFD09103),
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 12
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                onChanged: (String? value) {
                  setState(() {
                    dropDownValue = value!;
                    dataState.selectedFertilizer = dropDownValue;
                  });
                },
                borderRadius: BorderRadius.circular(10),
                items: listOfFertilizer.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text('${value[0].toUpperCase()}${value.substring(1)}'),
                  );
                }).toList(),
              ),
            ),
          )
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          Container(
            height: 35,
            width: 90,
            decoration: BoxDecoration(
              color: const Color(0xFF5A3E00),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white,
                width: 2,
              )
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                alignment: AlignmentDirectional.center
              ),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                  openSuccessPredictionWaterFrequencyDialog(cropSuccessPredictionFertilizerContext);
                });
              },
              child: const Text(
                'Previous',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Container(
            height: 35,
            width: 70,
            decoration: BoxDecoration(
              color: const Color(0xFFB07A01),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white,
                width: 2,
              )
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFB07A01),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                alignment: AlignmentDirectional.center
              ),
              onPressed: () {
                setState(() {
                  dataState.selectedCountry = dropDownValue;
                  Navigator.of(context).pop();
                  openSuccessPredictionHumidityDialog(cropSuccessPredictionFertilizerContext);
                });
              },
              child: const Text(
                'Next',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future openSuccessPredictionHumidityDialog(BuildContext cropYieldPredictionHumidityContext) {
    var dataState = Provider.of<HomeProvider>(cropYieldPredictionHumidityContext, listen: false);

    return showDialog(
      context: cropYieldPredictionHumidityContext,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF604200),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        title: RichText(
          text: const TextSpan(
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 24
            ),
            children: [
              TextSpan(
                text: 'Humidity',
                style: TextStyle(
                  color: Color(0xFFD09103),
                ),
              ),
              TextSpan(
                text: ' (%)',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ]
          ),
        ), 
        content: SizedBox(
          height: 50,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: TextField(
              controller: dataState.humidityController,
              keyboardType: TextInputType.number,
              cursorColor: const Color(0xFFD09103),
              autofocus: true,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter Humidity value here...',
                hintStyle: TextStyle(
                  color: Color(0xFFD09103),
                  fontSize: 12
                ),
              ),
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                color: Color(0xFFD09103),
                fontSize: 12
              ),
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          Container(
            height: 35,
            width: 90,
            decoration: BoxDecoration(
              color: const Color(0xFF5A3E00),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white,
                width: 2,
              )
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                alignment: AlignmentDirectional.center
              ),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                  openSuccessPredictionFertilizerDialog(cropYieldPredictionHumidityContext);
                });
              },
              child: const Text(
                'Previous',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Container(
            height: 35,
            width: 70,
            decoration: BoxDecoration(
              color: const Color(0xFFB07A01),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white,
                width: 2,
              )
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                alignment: AlignmentDirectional.center
              ),
              onPressed: () {
                if (dataState.checkFloat(dataState.humidityController.text) && dataState.humidityController.text.isNotEmpty) {
                  setState(() {
                    Navigator.pop(context);
                    openSuccessPredictionSunlighthoursDialog(cropYieldPredictionHumidityContext);
                  });
                } else if (dataState.humidityController.text.isEmpty) {
                  ScaffoldMessenger.of(cropYieldPredictionHumidityContext).showSnackBar(
                    const SnackBar(
                      content: Text('The value cannot be empty.'),
                    ),
                  );
                } else if (RegExp('[,\t]+').hasMatch(dataState.humidityController.text)) {
                  ScaffoldMessenger.of(cropYieldPredictionHumidityContext).showSnackBar(
                    const SnackBar(
                      content: Text('Cannot contain comma, try using period (.)'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(cropYieldPredictionHumidityContext).showSnackBar(
                    const SnackBar(
                      content: Text('The value can only contain numbers.'),
                    ),
                  );
                }
              },
              child: const Text(
                'Next',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 12
                ),
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  Future openSuccessPredictionSunlighthoursDialog(BuildContext cropYieldPredictionSunlighthoursContext) {
    var dataState = Provider.of<HomeProvider>(cropYieldPredictionSunlighthoursContext, listen: false);

    return showDialog(
      context: cropYieldPredictionSunlighthoursContext,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF604200),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        title: const Text(
          'Sunlight Hours',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            color: Color(0xFFD09103),
          ),
        ),
        content: SizedBox(
          height: 50,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: TextField(
              controller: dataState.sunlightHoursController,
              keyboardType: TextInputType.number,
              cursorColor: const Color(0xFFD09103),
              autofocus: true,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter Sunlight hours value here...',
                hintStyle: TextStyle(
                  color: Color(0xFFD09103),
                  fontSize: 12
                ),
              ),
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                color: Color(0xFFD09103),
                fontSize: 12
              ),
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          Container(
            height: 35,
            width: 90,
            decoration: BoxDecoration(
              color: const Color(0xFF5A3E00),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white,
                width: 2,
              )
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                alignment: AlignmentDirectional.center
              ),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                  openSuccessPredictionHumidityDialog(cropYieldPredictionSunlighthoursContext);
                });
              },
              child: const Text(
                'Previous',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Container(
            height: 35,
            width: 70,
            decoration: BoxDecoration(
              color: const Color(0xFFB07A01),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white,
                width: 2,
              )
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                alignment: AlignmentDirectional.center
              ),
              onPressed: () {
                if (dataState.checkFloat(dataState.sunlightHoursController.text) && dataState.sunlightHoursController.text.isNotEmpty) {
                  setState(() {
                    Navigator.pop(context);
                    openSuccessPredictionTemperatureDialog(cropYieldPredictionSunlighthoursContext);
                  });
                } else if (dataState.sunlightHoursController.text.isEmpty) {
                  ScaffoldMessenger.of(cropYieldPredictionSunlighthoursContext).showSnackBar(
                    const SnackBar(
                      content: Text('The value cannot be empty.'),
                    ),
                  );
                } else if (RegExp('[,\t]+').hasMatch(dataState.sunlightHoursController.text)) {
                  ScaffoldMessenger.of(cropYieldPredictionSunlighthoursContext).showSnackBar(
                    const SnackBar(
                      content: Text('Cannot contain comma, try using period (.)'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(cropYieldPredictionSunlighthoursContext).showSnackBar(
                    const SnackBar(
                      content: Text('The value can only contain numbers.'),
                    ),
                  );
                }
              },
              child: const Text(
                'Next',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 12
                ),
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  Future openSuccessPredictionTemperatureDialog(BuildContext cropYieldPredictionTemperatureContext) {
    var dataState = Provider.of<HomeProvider>(cropYieldPredictionTemperatureContext, listen: false);

    Future processResult() async {
      dataState.loading(cropYieldPredictionTemperatureContext, 'Predicting');

      await dataState.fetchSuccessPrediction(
        dataState.selectedSoilType,
        dataState.selectedWaterFrequency,
        dataState.selectedFertilizer,
        dataState.humidityController.text,
        dataState.sunlightHoursController.text,
        dataState.successTemperatureController.text
      );

      if (!cropYieldPredictionTemperatureContext.mounted) {
        return Future.error('error');
      }

      Navigator.of(cropYieldPredictionTemperatureContext).pop();
      openSuccessPredictionResultDialog(cropYieldPredictionTemperatureContext);
    }

    return showDialog(
      context: cropYieldPredictionTemperatureContext,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF604200),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        title: RichText(
          text: const TextSpan(
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 24
            ),
            children: [
              TextSpan(
                text: 'Temperature',
                style: TextStyle(
                  color: Color(0xFFD09103),
                ),
              ),
              TextSpan(
                text: ' (℃)',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ]
          ),
        ),
        content: SizedBox(
          height: 50,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: TextField(
              controller: dataState.successTemperatureController,
              keyboardType: TextInputType.number,
              cursorColor: const Color(0xFFD09103),
              autofocus: true,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter Temperature value here...',
                hintStyle: TextStyle(
                  color: Color(0xFFD09103),
                  fontSize: 12
                ),
              ),
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                color: Color(0xFFD09103),
                fontSize: 12
              ),
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          Container(
            height: 35,
            width: 90,
            decoration: BoxDecoration(
              color: const Color(0xFF5A3E00),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white,
                width: 2,
              )
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                alignment: AlignmentDirectional.center
              ),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                  openSuccessPredictionSunlighthoursDialog(cropYieldPredictionTemperatureContext);
                });
              },
              child: const Text(
                'Previous',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Container(
            height: 35,
            width: 90,
            decoration: BoxDecoration(
              color: const Color(0xFF108800),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white,
                width: 2,
              )
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                alignment: AlignmentDirectional.center
              ),
              onPressed: () {
                if (dataState.checkFloat(dataState.successTemperatureController.text) && dataState.successTemperatureController.text.isNotEmpty) {
                  setState(() {
                    Navigator.pop(context);
                    processResult();
                    dataState.humidityController.text = '';
                    dataState.sunlightHoursController.text = '';
                    dataState.successTemperatureController.text = '';
                  });
                } else if (dataState.successTemperatureController.text.isEmpty) {
                  ScaffoldMessenger.of(cropYieldPredictionTemperatureContext).showSnackBar(
                    const SnackBar(
                      content: Text('The value cannot be empty.'),
                    ),
                  );
                } else if (RegExp('[,\t]+').hasMatch(dataState.successTemperatureController.text)) {
                  ScaffoldMessenger.of(cropYieldPredictionTemperatureContext).showSnackBar(
                    const SnackBar(
                      content: Text('Cannot contain comma, try using period (.)'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(cropYieldPredictionTemperatureContext).showSnackBar(
                    const SnackBar(
                      content: Text('The value can only contain numbers.'),
                    ),
                  );
                }
              },
              child: const Text(
                'Calculate',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 12
                ),
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  Future openSuccessPredictionResultDialog(BuildContext cropYieldPredictionResultContext) {
    var dataState = Provider.of<HomeProvider>(cropYieldPredictionResultContext, listen: false);

    return showDialog(
      context: cropYieldPredictionResultContext,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF604200),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        contentPadding: const EdgeInsets.all(0),
        content: SizedBox(
          height: 240,
          child: Column(
            children: [
              if (dataState.result == 'Success')
                Stack(
                  // alignment: Alignment.centerLeft,
                  children: [
                    const SizedBox(
                      width: 280,
                      height: 200,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Image.asset(
                        'assets/images/success_top_plant.png',
                        scale: 1.4,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Image.asset(
                        'assets/images/success_top_plant_reverse.png',
                        scale: 1.4,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 80
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 190,
                          height: 140,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8BB09),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 40,
                                ),
                                child: Container(
                                  width: 170,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF84B653),
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: const Color(0xFFFFFFFF),
                                      width: 2
                                    )
                                  ),
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Success',
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 20,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        shadows: [
                                          Shadow(
                                            color: Color(0xFF028912),
                                            blurRadius: 1,
                                            offset: Offset(1, 1),
                                          )
                                        ]
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  top: 10
                                ),
                                child: Text(
                                  'Your plant will be\nsuccessfully planted',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFFF8FFF8),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 35,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/images/success_plant.png',
                          scale: 2,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 55,
                      top: 90,
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: const Color(0xFF604200),
                          borderRadius: BorderRadius.circular(100)
                        ),
                      ),
                    ),
                    Positioned(
                      left: 80,
                      top: 90,
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: const Color(0xFF604200),
                          borderRadius: BorderRadius.circular(100)
                        ),
                      ),
                    ),
                    Positioned(
                      right: 55,
                      top: 90,
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: const Color(0xFF604200),
                          borderRadius: BorderRadius.circular(100)
                        ),
                      ),
                    ),
                    Positioned(
                      right: 80,
                      top: 90,
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: const Color(0xFF604200),
                          borderRadius: BorderRadius.circular(100)
                        ),
                      ),
                    ),
                  ],
                )
              else 
                Stack(
                  children: [
                    const SizedBox(
                      width: 280,
                      height: 200,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Image.asset(
                        'assets/images/fail_top_plant.png',
                        scale: 2,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Image.asset(
                        'assets/images/fail_top_plant_reverse.png',
                        scale: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 80
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 190,
                          height: 140,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8BB09),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 40,
                                ),
                                child: Container(
                                  width: 170,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFB91010),
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: const Color(0xFFFFFFFF),
                                      width: 2
                                    )
                                  ),
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Fail',
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 20,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        shadows: [
                                          Shadow(
                                            color: Color(0xFFD41111),
                                            blurRadius: 1,
                                            offset: Offset(1, 1),
                                          )
                                        ]
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  top: 10
                                ),
                                child: Text(
                                  'Your plant cannot be\nplanted',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFFF8FFF8),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 35,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/images/fail_plant.png',
                          scale: 2,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 55,
                      top: 90,
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: const Color(0xFF604200),
                          borderRadius: BorderRadius.circular(100)
                        ),
                      ),
                    ),
                    Positioned(
                      left: 80,
                      top: 90,
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: const Color(0xFF604200),
                          borderRadius: BorderRadius.circular(100)
                        ),
                      ),
                    ),
                    Positioned(
                      right: 55,
                      top: 90,
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: const Color(0xFF604200),
                          borderRadius: BorderRadius.circular(100)
                        ),
                      ),
                    ),
                    Positioned(
                      right: 80,
                      top: 90,
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: const Color(0xFF604200),
                          borderRadius: BorderRadius.circular(100)
                        ),
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
        actions: [
          SizedBox(
            height: 35,
            width: 90,
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                alignment: AlignmentDirectional.center
              ),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
              child: const Text(
                'Close',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 12
                ),
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

}

class YieldPredictionButton extends StatefulWidget {
  const YieldPredictionButton({
    super.key,
  });

  @override
  State<YieldPredictionButton> createState() => _YieldPredictionButtonState();
}

class _YieldPredictionButtonState extends State<YieldPredictionButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 40
      ),
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width-110,
              height: 70,
              decoration: BoxDecoration(
                color: const Color(0xFF372702),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(64, 0, 0, 0),
                    blurRadius: 1,
                    spreadRadius: 0,
                    offset: Offset(0, 3)
                  )
                ]
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 25
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFFFFFFFF),
                      foregroundColor: const Color(0xFF000000),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                    onPressed: () {
                      openCropYieldPredictionPlantDialog(context);
                    },
                    child: const Text(
                      'Crop Yield Prediction',
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 55,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: const Color(0xFF8A6000),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            Positioned(
              left: 0,
              child: Container(
                width: 70,
                height: 13,
                decoration: const BoxDecoration(
                  color: Color(0xFFC7A14D),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(100),
                    bottomRight: Radius.circular(100),
                  )
                ),
              ),
            ),
            Positioned(
              right: 55,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: const Color(0xFF8A6000),
                  borderRadius: BorderRadius.circular(100)
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: Container(
                width: 70,
                height: 13,
                decoration: const BoxDecoration(
                  color: Color(0xFFC7A14D),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    bottomLeft: Radius.circular(100),
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future openCropYieldPredictionPlantDialog(BuildContext cropYieldPredictionPlantContext) {
    var dataState = Provider.of<HomeProvider>(cropYieldPredictionPlantContext, listen: false);

    List<String> listOfPlants = dataState.listOfPlant;
    String dropDownValue = dataState.selectedPlant;

    return showDialog(
      context: cropYieldPredictionPlantContext,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF604200),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        title: const Text(
          'Plant',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            color: Color(0xFFD09103),
          ),
        ),
        content: SizedBox(
          height: 50,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Align(
              alignment: Alignment.center,
              child: DropdownButtonFormField<String>(
                value: dropDownValue,
                isExpanded: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20
                ),
                icon: Image.asset(
                  'assets/icons/dropdown-arrow.png',
                  scale: 2,
                ),
                style: const TextStyle(
                  color: Color(0xFFD09103),
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 12
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                onChanged: (String? value) {
                  setState(() {
                    dropDownValue = value!;
                    dataState.selectedPlant = dropDownValue;
                  });
                },
                borderRadius: BorderRadius.circular(10),
                items: listOfPlants.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          )
        ),
        actions: [
          Container(
            height: 35,
            width: 70,
            decoration: BoxDecoration(
              color: const Color(0xFFB07A01),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white,
                width: 2,
              )
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                alignment: AlignmentDirectional.center
              ),
              onPressed: () {
                setState(() {
                  dataState.selectedPlant = dropDownValue;
                  Navigator.of(context).pop();
                  openCropYieldPredictionPesticideDialog(cropYieldPredictionPlantContext);
                });
              },
              child: const Text(
                'Next',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future openCropYieldPredictionPesticideDialog(BuildContext cropYieldPredictionPesticideContext) {
    var dataState = Provider.of<HomeProvider>(cropYieldPredictionPesticideContext, listen: false);

    return showDialog(
      context: cropYieldPredictionPesticideContext,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF604200),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        title: RichText(
          text: const TextSpan(
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 24
            ),
            children: [
              TextSpan(
                text: 'Pesticides',
                style: TextStyle(
                  color: Color(0xFFD09103),
                ),
              ),
              TextSpan(
                text: ' (tonnes)',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ]
          ),
        ),
        content: SizedBox(
          height: 50,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: TextField(
              controller: dataState.pesticideController,
              maxLength: 5,
              keyboardType: TextInputType.number,
              cursorColor: const Color(0xFFD09103),
              autofocus: true,
              decoration: const InputDecoration(
                border: InputBorder.none,
                counterText: '',
                hintText: 'Enter Pesticide value here...',
                hintStyle: TextStyle(
                  color: Color(0xFFD09103),
                  fontSize: 12
                ),
              ),
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                color: Color(0xFFD09103),
                fontSize: 12
              ),
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          Container(
            height: 35,
            width: 90,
            decoration: BoxDecoration(
              color: const Color(0xFF5A3E00),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white,
                width: 2,
              )
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                alignment: AlignmentDirectional.center
              ),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                  openCropYieldPredictionPlantDialog(cropYieldPredictionPesticideContext);
                });
              },
              child: const Text(
                'Previous',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Container(
            height: 35,
            width: 70,
            decoration: BoxDecoration(
              color: const Color(0xFFB07A01),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white,
                width: 2,
              )
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                alignment: AlignmentDirectional.center
              ),
              onPressed: () {
                if (dataState.checkFloat(dataState.pesticideController.text) && dataState.pesticideController.text.isNotEmpty) {
                  setState(() {
                    Navigator.pop(context);
                    openCropYieldPredictionTemperatureDialog(cropYieldPredictionPesticideContext);
                  });
                } else if (dataState.pesticideController.text.isEmpty) {
                  ScaffoldMessenger.of(cropYieldPredictionPesticideContext).showSnackBar(
                    const SnackBar(
                      content: Text('The value cannot be empty.'),
                    ),
                  );
                }
                else if (RegExp('[,\t]+').hasMatch(dataState.pesticideController.text)) {
                  ScaffoldMessenger.of(cropYieldPredictionPesticideContext).showSnackBar(
                    const SnackBar(
                      content: Text('Cannot contain comma, try using period (.)'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(cropYieldPredictionPesticideContext).showSnackBar(
                    const SnackBar(
                      content: Text('The value can only contain numbers.'),
                    ),
                  );
                }
              },
              child: const Text(
                'Next',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 12
                ),
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  Future openCropYieldPredictionTemperatureDialog(BuildContext cropYieldPredictionTemperatureContext) {
    var dataState = Provider.of<HomeProvider>(cropYieldPredictionTemperatureContext, listen: false);

    return showDialog(
      context: cropYieldPredictionTemperatureContext,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF604200),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        title: RichText(
          text: const TextSpan(
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 24
            ),
            children: [
              TextSpan(
                text: 'Temperature',
                style: TextStyle(
                  color: Color(0xFFD09103),
                ),
              ),
              TextSpan(
                text: ' (℃)',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ]
          ),
        ), 
        content: SizedBox(
          height: 50,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: TextField(
              controller: dataState.temperatureController,
              maxLength: 2,
              keyboardType: TextInputType.number,
              cursorColor: const Color(0xFFD09103),
              autofocus: true,
              decoration: const InputDecoration(
                border: InputBorder.none,
                counterText: '',
                hintText: 'Enter Temperature value here...',
                hintStyle: TextStyle(
                  color: Color(0xFFD09103),
                  fontSize: 12
                ),
              ),
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                color: Color(0xFFD09103),
                fontSize: 12
              ),
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          Container(
            height: 35,
            width: 90,
            decoration: BoxDecoration(
              color: const Color(0xFF5A3E00),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white,
                width: 2,
              )
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                alignment: AlignmentDirectional.center
              ),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                  openCropYieldPredictionPesticideDialog(cropYieldPredictionTemperatureContext);
                });
              },
              child: const Text(
                'Previous',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Container(
            height: 35,
            width: 70,
            decoration: BoxDecoration(
              color: const Color(0xFFB07A01),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white,
                width: 2,
              )
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                alignment: AlignmentDirectional.center
              ),
              onPressed: () {
                if (dataState.checkFloat(dataState.temperatureController.text) && dataState.temperatureController.text.isNotEmpty) {
                  setState(() {
                    Navigator.pop(context);
                    openCropYieldPredictionRainfallDialog(cropYieldPredictionTemperatureContext);
                  });
                } else if (dataState.temperatureController.text.isEmpty) {
                  ScaffoldMessenger.of(cropYieldPredictionTemperatureContext).showSnackBar(
                    const SnackBar(
                      content: Text('The value cannot be empty.'),
                    ),
                  );
                } else if (RegExp('[,\t]+').hasMatch(dataState.temperatureController.text)) {
                  ScaffoldMessenger.of(cropYieldPredictionTemperatureContext).showSnackBar(
                    const SnackBar(
                      content: Text('Cannot contain comma, try using period (.)'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(cropYieldPredictionTemperatureContext).showSnackBar(
                    const SnackBar(
                      content: Text('The value can only contain numbers.'),
                    ),
                  );
                }
              },
              child: const Text(
                'Next',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 12
                ),
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  Future openCropYieldPredictionRainfallDialog(BuildContext cropYieldPredictionRainfallContext) {
    var dataState = Provider.of<HomeProvider>(cropYieldPredictionRainfallContext, listen: false);

    return showDialog(
      context: cropYieldPredictionRainfallContext,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF604200),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        title: RichText(
          text: const TextSpan(
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 24
            ),
            children: [
              TextSpan(
                text: 'Rainfall',
                style: TextStyle(
                  color: Color(0xFFD09103),
                ),
              ),
              TextSpan(
                text: ' (mm)',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ]
          ),
        ), 
        content: SizedBox(
          height: 50,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: TextField(
              controller: dataState.rainfallController,
              maxLength: 6,
              keyboardType: TextInputType.number,
              cursorColor: const Color(0xFFD09103),
              autofocus: true,
              decoration: const InputDecoration(
                border: InputBorder.none,
                counterText: '',
                hintText: 'Enter Rainfall value here...',
                hintStyle: TextStyle(
                  color: Color(0xFFD09103),
                  fontSize: 12
                ),
              ),
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                color: Color(0xFFD09103),
                fontSize: 12
              ),
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          Container(
            height: 35,
            width: 90,
            decoration: BoxDecoration(
              color: const Color(0xFF5A3E00),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white,
                width: 2,
              )
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                alignment: AlignmentDirectional.center
              ),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                  openCropYieldPredictionTemperatureDialog(cropYieldPredictionRainfallContext);
                });
              },
              child: const Text(
                'Previous',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Container(
            height: 35,
            width: 70,
            decoration: BoxDecoration(
              color: const Color(0xFFB07A01),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white,
                width: 2,
              )
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                alignment: AlignmentDirectional.center
              ),
              onPressed: () {
                if (dataState.checkFloat(dataState.rainfallController.text) && dataState.rainfallController.text.isNotEmpty) {
                  setState(() {
                    Navigator.pop(context);
                    openCropYieldPredictionCountryDialog(cropYieldPredictionRainfallContext);
                  });
                } else if (dataState.rainfallController.text.isEmpty) {
                  ScaffoldMessenger.of(cropYieldPredictionRainfallContext).showSnackBar(
                    const SnackBar(
                      content: Text('The value cannot be empty.'),
                    ),
                  );
                } else if (RegExp('[,\t]+').hasMatch(dataState.rainfallController.text)) {
                  ScaffoldMessenger.of(cropYieldPredictionRainfallContext).showSnackBar(
                    const SnackBar(
                      content: Text('Cannot contain comma, try using period (.)'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(cropYieldPredictionRainfallContext).showSnackBar(
                    const SnackBar(
                      content: Text('The value can only contain numbers.'),
                    ),
                  );
                }
              },
              child: const Text(
                'Next',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 12
                ),
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  Future openCropYieldPredictionCountryDialog(BuildContext cropYieldPredictionCountryContext) {
    var dataState = Provider.of<HomeProvider>(cropYieldPredictionCountryContext, listen: false);

    List<String> listOfCountry = dataState.listofCountry;
    String dropDownValue = dataState.selectedCountry;

    Future processYieldPrediction(BuildContext currentContext) async {
      Navigator.of(currentContext).pop();
      dataState.loading(currentContext, 'Predicting');

      Future<Yield> prediction = dataState.fetchYield(
        dataState.selectedCountry,
        dataState.selectedPlant,
        dataState.rainfallController.text,
        dataState.pesticideController.text,
        dataState.temperatureController.text
      );

      await prediction.then((val) {
        dataState.writeToYieldJson();
        dataState.readYieldJson();
      });

      if (!currentContext.mounted) {
        return Future.error('error');
      }


      Navigator.of(currentContext).pop();
    }

    return showDialog(
      context: cropYieldPredictionCountryContext,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF604200),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        title: const Text(
          'Country',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            color: Color(0xFFD09103),
          ),
        ),
        content: SizedBox(
          height: 50,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Align(
              alignment: Alignment.center,
              child: DropdownButtonFormField<String>(
                value: dropDownValue,
                isExpanded: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20
                ),
                icon: Image.asset(
                  'assets/icons/dropdown-arrow.png',
                  scale: 2,
                ),
                style: const TextStyle(
                  color: Color(0xFFD09103),
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 12
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                onChanged: (String? value) {
                  setState(() {
                    dropDownValue = value!;
                    dataState.selectedCountry = dropDownValue;
                  });
                },
                borderRadius: BorderRadius.circular(10),
                items: listOfCountry.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          )
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          Container(
            height: 35,
            width: 90,
            decoration: BoxDecoration(
              color: const Color(0xFF5A3E00),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white,
                width: 2,
              )
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                alignment: AlignmentDirectional.center
              ),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                  openCropYieldPredictionRainfallDialog(cropYieldPredictionCountryContext);
                });
              },
              child: const Text(
                'Previous',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Container(
            height: 35,
            width: 90,
            decoration: BoxDecoration(
              color: const Color(0xFFB07A01),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white,
                width: 2,
              )
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF108800),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                alignment: AlignmentDirectional.center
              ),
              onPressed: () {
                setState(() {
                  dataState.selectedCountry = dropDownValue;
                  processYieldPrediction(cropYieldPredictionCountryContext);
                  dataState.temperatureController.text = '';
                  dataState.pesticideController.text = '';
                  dataState.rainfallController.text = '';
                });
              },
              child: const Text(
                'Calculate',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({
    super.key,
  });

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  @override
  Widget build(BuildContext context) {
    var dataState = Provider.of<HomeProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 25,
            top: 15,
            right: 10,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            width: 145,
            height: 220,
            decoration: BoxDecoration(
              gradient: dataState.colorWeather,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Text(
                  dataState.currentDate,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xFFEFEFEF)
                  ),
                ),
                dataState.weatherImage,
                Text(
                  '${dataState.currentTemp}°C',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 35,
                    color: Color(0xFFEFEFEF),
                  ),
                ),
                Text(
                  dataState.currentWeather,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Color(0xFFEFEFEF),
                    height: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 25,
            top: 15,
            left: 10,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            width: 145,
            height: 220,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF50D3C8),
                  Color(0xFF0BEAD7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                const Text(
                  'Wind Speeed',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xFFEFEFEF),
                  ),
                ),
                Text(
                  '${dataState.currentWindSpeed} m/s',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 35,
                    color: Color(0xFFEFEFEF),
                  ),
                ),
                Image.asset(
                  'assets/images/wind.png',
                  scale: 2.1,
                ),
                const Text(
                  'Humidity',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xFFEFEFEF),
                    height: 2,
                  ),
                ),
                Text(
                  '${dataState.currentHumidity}%',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: Color(0xFFEFEFEF),
                    height: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TopBar extends StatefulWidget {
  const TopBar({
    super.key,
  });

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    var dataState = context.watch<HomeProvider>();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome to',
                style: TextStyle(
                    fontFamily: 'LycheeFarmland',
                    fontSize: 30,
                    height: 1,
                ),
              ),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontFamily: 'LycheeFarmland',
                    fontSize: 35,
                    color: Color(0xFF494949),
                  ),
                  children: <TextSpan> [
                    const TextSpan(
                      text: 'Pre',
                      style: TextStyle(
                        color: Color(0xFF009027),
                      )
                    ),
                    const TextSpan(
                      text: 'Farm',
                      style: TextStyle(
                        color: Color(0xFF00D439)
                      )
                    ),
                    TextSpan(
                      text: ', ${dataState.username}',
                    )
                  ]
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 15,
              right: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.15),
                        blurRadius: 8,
                        offset: Offset(0, 5)
                      )
                    ]
                  ),
                  child: IconButton(
                    padding: const EdgeInsets.all(0),
                    icon: Image.asset(
                      'assets/icons/profile.png',
                      scale: 1.5,
                    ),
                    onPressed: () {
                      openProfileDialog(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Future openProfileDialog(BuildContext dialogContext) {
    var dataState = Provider.of<HomeProvider>(dialogContext, listen: false);

    return showDialog(
      context: dialogContext,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        backgroundColor: const Color(0xFFF5F5F5),
        content: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 25,
            horizontal: 15
          ),
          child: SizedBox(
            height: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      color: Color(0xFF3F3F3F),
                    ),
                    children: [
                      TextSpan(
                        text: 'Change Username',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        )
                      ),
                      TextSpan(
                        text: '   (8 Characters Maximum)',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 8,
                        )
                      )
                    ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10
                  ),
                  child: SizedBox(
                    height: 45,
                    child: TextField(
                      controller: dataState.usernameController,
                      autofocus: true,
                      maxLength: 8,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        fillColor: const Color(0xFFD9D9D9),
                        filled: true,
                        hintText: 'ex: Kevin',
                        counterText: '',
                        suffixIcon: Image.asset(
                          'assets/icons/edit.png',
                          scale: 2,
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          )
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          )
                        )
                      ),
                      style: const TextStyle(
                        color: Color(0xFF3F3F3F),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 12
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10
                  ),
                  child: Text(
                    'History',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    )
                  ),
                ),
                SizedBox(
                  height: 45,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9D9D9),
                      border: Border.all(
                        color: Colors.white,
                        width: 1
                      ),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 1,
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          offset: Offset(2, 2)
                        )
                      ],
                    ),
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        openConfirmDialog(dialogContext);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        side: BorderSide.none,
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 9
                        )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Delete History',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 12
                            ),
                          ),
                          Image.asset(
                            'assets/icons/trash.png',
                            scale: 2,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        actions: [
          Container(
            width: 130,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white,
                width: 1
              ),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 1,
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  offset: Offset(2, 2)
                )
              ]
            ),
            child: TextButton.icon(
              onPressed: () {
                if (dataState.usernameController.text.isEmpty) {
                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    const SnackBar(
                      content: Text('Username cannot be empty.'),
                    )
                  );
                } else if (RegExp('[ \t]+').hasMatch(dataState.usernameController.text)) {
                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    const SnackBar(
                      content: Text('Username can only be one word and cannot contain whitespace.'),
                    )
                  );
                } else if (!RegExp('^[a-zA-Z]+').hasMatch(dataState.usernameController.text)) {
                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    const SnackBar(
                      content: Text('Username can only contain alphabetical letters.'),
                    )
                  );
                } else {
                  context.read<HomeProvider>().writeToProfileJson();
                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    const SnackBar(
                      content: Text('Saved successfully!'),
                    )
                  );
                }
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                foregroundColor: Colors.black
              ),
              icon: Image.asset(
                'assets/icons/save.png',
                // scale: 2,
              ),
              label: const Text(
                'Save Changes',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 9,
                  color: Color(0xFF3F3F3F)
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future openConfirmDialog(BuildContext dialogContext) {
    var dataState = Provider.of<HomeProvider>(dialogContext, listen: false);

    Future processDeleteHistory() async {
      dataState.loading(dialogContext, 'Deleting');
      await dataState.deleteHistory();

      if (!dialogContext.mounted) {
        return Future.error('error');
      }


      Navigator.pop(dialogContext);
    }
    
    return showDialog(
      context: dialogContext,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text(
          'Confirm',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
        content: const Text(
          'Are you sure you want to proceed?',
          style: TextStyle(
            fontFamily: 'Inter'
          ),
        ),
        backgroundColor: const Color(0xFFF5F5F5),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Cancel');
              openProfileDialog(dialogContext);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                color: Color(0xFF3F3F3F),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Confirm');
              processDeleteHistory();
            },
            child: const Text(
              'Confirm',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}