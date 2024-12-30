import 'package:flutter/material.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const GuideScreen();
  }
}

class GuideScreen extends StatefulWidget {
  const GuideScreen({
    super.key,
  });

  @override
  State<GuideScreen> createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          color: Color(0xFF604200),
        ),
        child: const SingleChildScrollView(
          child: Column(
            children: [
              TopBar(),
              GuideWidgets(),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GuideWidgets extends StatelessWidget {
  const GuideWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
          ),
          child: Container(
            height: 250,
            decoration: const BoxDecoration(
              color: Color(0xFF392802)
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10
                  ),
                  child: Container(
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4D3602)
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  child: IconButton(
                    icon: Image.asset(
                      'assets/images/rect1.png',
                      scale: 2,
                    ),
                    onPressed: () {
                      openDialog(
                        context, 
                        'How does rainfall affect the growth of plants?', 
                        'Rainfall provides essential water for photosynthesis, nutrient absorption, and soil moisture regulation, promoting healthy plant growth. However, too little rainfall can cause drought stress, while excessive rainfall may lead to waterlogging and root damage.',
                        TextAlign.left
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 5,
                  child: TextButton(
                    onPressed: () {
                      openDialog(
                        context, 
                        'How does rainfall affect the growth of plants?', 
                        'Rainfall provides essential water for photosynthesis, nutrient absorption, and soil moisture regulation, promoting healthy plant growth. However, too little rainfall can cause drought stress, while excessive rainfall may lead to waterlogging and root damage.',
                        TextAlign.left
                      );
                    },
                    child: const Text(
                      'How does rainfall\n affect the growth of\nplants?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 12
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: -5,
                  top: 50,
                  child: IconButton(
                    icon: Image.asset(
                      'assets/images/rect2.png',
                      scale: 2,
                    ),
                    onPressed: () {
                      openDialog(
                        context, 
                        'How to calculate humidity?', 
                        'The level of moisture or humidity in the environment surrounding the plants\n\n1. Insert the sensor into the growing medium at the desired depth.\n2. Read the moisture level from device, typically displayed as a percentage (%).\n3. Advanced sensors may connect to smart devices for continuous monitoring.\n\nTips:\nChoose a sensor compatible with your growing medium (e.g., soil, coconut coir, hydroponic setups).\nCalibrate the sensor before use to ensure accurate readings.',
                        TextAlign.left
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 95,
                  right: 15,
                  child: TextButton(
                    onPressed: () {
                      openDialog(
                        context, 
                        'How to calculate humidity?', 
                        'The level of moisture or humidity in the environment surrounding the plants\n\n1. Insert the sensor into the growing medium at the desired depth.\n2. Read the moisture level from device, typically displayed as a percentage (%).\n3. Advanced sensors may connect to smart devices for continuous monitoring.\n\nTips:\nChoose a sensor compatible with your growing medium (e.g., soil, coconut coir, hydroponic setups).\nCalibrate the sensor before use to ensure accurate readings.',
                        TextAlign.left,
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFFD09103),
                    ),
                    child: const Text(
                      'How to calculate\nhumidity?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 12
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 12,
                  top: 60,
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: const Color(0xFF000000),
                      borderRadius: BorderRadius.circular(100)
                    ),
                  ),
                ),
                Positioned(
                  left: 115,
                  top: 60,
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: const Color(0xFF000000),
                      borderRadius: BorderRadius.circular(100)
                    ),
                  ),
                ),
                Positioned(
                  right: 115,
                  top: 60,
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: const Color(0xFF000000),
                      borderRadius: BorderRadius.circular(100)
                    ),
                  ),
                ),
                Positioned(
                  right: 12,
                  top: 60,
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: const Color(0xFF000000),
                      borderRadius: BorderRadius.circular(100)
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 17,
                  child: Container(
                    width: 15,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Color(0xFFC7A14D),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100)
                      )
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 120,
                  child: Container(
                    width: 15,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Color(0xFFC7A14D),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100)
                      )
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 17,
                  child: Container(
                    width: 15,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Color(0xFFC7A14D),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100)
                      )
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 120,
                  child: Container(
                    width: 15,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Color(0xFFC7A14D),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100)
                      )
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
          ),
          child: Container(
            height: 250,
            decoration: const BoxDecoration(
              color: Color(0xFF392802)
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10
                  ),
                  child: Container(
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4D3602)
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  child: IconButton(
                    icon: Image.asset(
                      'assets/images/rect3.png',
                      scale: 2,
                    ),
                    onPressed: () {
                      openDialog(
                        context, 
                        'Why you should know which soil type you use?', 
                        'Understanding your soil type is crucial for ensuring proper water retention, nutrient availability, and plant growth. It also helps in making informed decisions for construction, preventing erosion, and optimizing land management.',
                        TextAlign.left
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 82,
                  left: 18,
                  child: TextButton(
                    onPressed: () {
                      openDialog(
                        context, 
                        'Why you should know which soil type you use?', 
                        'Understanding your soil type is crucial for ensuring proper water retention, nutrient availability, and plant growth. It also helps in making informed decisions for construction, preventing erosion, and optimizing land management.',
                        TextAlign.left
                      );
                    },
                    child: const Text(
                      'Why you should\nknow which soil\ntype you use?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 12
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: -5,
                  top: 50,
                  child: IconButton(
                    icon: Image.asset(
                      'assets/images/rect4.png',
                      scale: 2,
                    ),
                    onPressed: () {
                      openDialog(
                        context, 
                        'Why you should know which Fertilizer type you use?', 
                        'Knowing the fertilizer type is crucial because different fertilizers provide specific nutrients (e.g., nitrogen, phosphorus, potassium) that plants need at various growth stages, such as leafy growth or fruiting. Using the wrong type or amount of fertilizer can harm the plant, soil health, and the environment through nutrient imbalances or runoff.',
                        TextAlign.left
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 85,
                  right: 10,
                  child: TextButton(
                    onPressed: () {
                      openDialog(
                        context, 
                        'Why you should know which Fertilizer type you use?', 
                        'Knowing the fertilizer type is crucial because different fertilizers provide specific nutrients (e.g., nitrogen, phosphorus, potassium) that plants need at various growth stages, such as leafy growth or fruiting. Using the wrong type or amount of fertilizer can harm the plant, soil health, and the environment through nutrient imbalances or runoff.',
                        TextAlign.left,
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFFD09103),
                    ),
                    child: const Text(
                      'Why you should\nknow which\nFertilizer type you\nuse?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 12
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 12,
                  top: 60,
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: const Color(0xFF000000),
                      borderRadius: BorderRadius.circular(100)
                    ),
                  ),
                ),
                Positioned(
                  left: 115,
                  top: 60,
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: const Color(0xFF000000),
                      borderRadius: BorderRadius.circular(100)
                    ),
                  ),
                ),
                Positioned(
                  right: 115,
                  top: 60,
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: const Color(0xFF000000),
                      borderRadius: BorderRadius.circular(100)
                    ),
                  ),
                ),
                Positioned(
                  right: 12,
                  top: 60,
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: const Color(0xFF000000),
                      borderRadius: BorderRadius.circular(100)
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 17,
                  child: Container(
                    width: 15,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Color(0xFFC7A14D),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100)
                      )
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 120,
                  child: Container(
                    width: 15,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Color(0xFFC7A14D),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100)
                      )
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 17,
                  child: Container(
                    width: 15,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Color(0xFFC7A14D),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100)
                      )
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 120,
                  child: Container(
                    width: 15,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Color(0xFFC7A14D),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100)
                      )
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
          ),
          child: Container(
            height: 250,
            decoration: const BoxDecoration(
              color: Color(0xFF392802)
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10
                  ),
                  child: Container(
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4D3602)
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  child: IconButton(
                    icon: Image.asset(
                      'assets/images/rect5.png',
                      scale: 2,
                    ),
                    onPressed: () {
                      openDialog(
                        context, 
                        'Why temperature is important in plant growth?', 
                        'Temperature is crucial for plant growth because it affects physiological processes like photosynthesis, respiration, and enzyme activity, which are essential for energy production and nutrient absorption. The right temperature range ensures optimal growth, while extremes can cause stress, stunt growth, or damage the plant.',
                        TextAlign.left
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 85,
                  left: 7,
                  child: TextButton(
                    onPressed: () {
                      openDialog(
                        context, 
                        'Why temperature is important in plant growth?', 
                        'Temperature is crucial for plant growth because it affects physiological processes like photosynthesis, respiration, and enzyme activity, which are essential for energy production and nutrient absorption. The right temperature range ensures optimal growth, while extremes can cause stress, stunt growth, or damage the plant.',
                        TextAlign.left
                      );
                    },
                    child: const Text(
                      'Why temperature is\nimportant in plant\ngrowth?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 12
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: -5,
                  top: 50,
                  child: IconButton(
                    icon: Image.asset(
                      'assets/images/rect6.png',
                      scale: 2,
                    ),
                    onPressed: () {
                      openDialog(
                        context, 
                        'Why sunlight hours is important in plant growth?', 
                        'Sunlight hours are vital for plant growth because sunlight provides the energy needed for photosynthesis, the process by which plants produce food and energy to grow, develop, and reproduce. Insufficient or excessive sunlight can hinder growth, affect flowering and fruiting, and even lead to plant stress or death.',
                        TextAlign.left
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 85,
                  right: 5,
                  child: TextButton(
                    onPressed: () {
                      openDialog(
                        context, 
                        'Why sunlight hours is important in plant growth?', 
                        'Sunlight hours are vital for plant growth because sunlight provides the energy needed for photosynthesis, the process by which plants produce food and energy to grow, develop, and reproduce. Insufficient or excessive sunlight can hinder growth, affect flowering and fruiting, and even lead to plant stress or death.',
                        TextAlign.left,
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFFD09103),
                    ),
                    child: const Text(
                      'Why sunlight hours\nis important in plant\ngrowth?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 12
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 12,
                  top: 60,
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: const Color(0xFF000000),
                      borderRadius: BorderRadius.circular(100)
                    ),
                  ),
                ),
                Positioned(
                  left: 115,
                  top: 60,
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: const Color(0xFF000000),
                      borderRadius: BorderRadius.circular(100)
                    ),
                  ),
                ),
                Positioned(
                  right: 115,
                  top: 60,
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: const Color(0xFF000000),
                      borderRadius: BorderRadius.circular(100)
                    ),
                  ),
                ),
                Positioned(
                  right: 12,
                  top: 60,
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: const Color(0xFF000000),
                      borderRadius: BorderRadius.circular(100)
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 17,
                  child: Container(
                    width: 15,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Color(0xFFC7A14D),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100)
                      )
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 120,
                  child: Container(
                    width: 15,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Color(0xFFC7A14D),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100)
                      )
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 17,
                  child: Container(
                    width: 15,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Color(0xFFC7A14D),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100)
                      )
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 120,
                  child: Container(
                    width: 15,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Color(0xFFC7A14D),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100)
                      )
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future openDialog(BuildContext dialogContext, String title, String desc, TextAlign alignment) {
    return showDialog(
      context: dialogContext,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF604200),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ),
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: Color(0xFFD09103),
          ),
        ),
        content: Text(
          desc,
          textAlign: alignment,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: Color(0xFFFFFDFD),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Close',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                color: Color(0xFFFFFDFD),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF895F00),
          ),
        ),
        SizedBox(
          height: 150,
          width: double.infinity,
          child: Image.asset(
            'assets/images/background-transparent.png',
            fit: BoxFit.cover,
            scale: 0.5,
            color: const Color.fromRGBO(183, 162, 112, 1),
          ),
        ),
        Positioned(
          left: 80,
          bottom: 0,
          child: Container(
            width: 15,
            height: 50,
            decoration: const BoxDecoration(
              color: Color(0xFF2E2105)
            ),
          ),
        ),
        Positioned(
          right: 80,
          bottom: 0,
          child: Container(
            width: 15,
            height: 50,
            decoration: const BoxDecoration(
              color: Color(0xFF2E2105)
            ),
          ),
        ),
        SizedBox(
          height: 150,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 50
            ),
            child: Container(
                width: 10,
                height: 20,
                decoration: BoxDecoration(
                  color: const Color(0xFF4F3601),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 0,
                      color: Color(0xFF392802),
                      spreadRadius: 2,
                      offset: Offset(5, 5)
                    ),
                  ]
                ),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Guide',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 40,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
          ),
        ),
      ]
    );
  }
}