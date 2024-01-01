import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:p2/home1.dart';


class body extends StatefulWidget {
  const body({super.key});

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome To Our Store',
          style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: double.infinity,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text.rich(
                      TextSpan(
                        text: 'Get 5% Off Your Purchase\n',
                        style: TextStyle(color: Colors.white),
                        children: [
                          TextSpan(
                            text: 'with Our Mobile App!',
                            style: TextStyle(color: Colors.white,
                            fontSize: 20)
                          )
                        ]
                      ),
                    ),
                  ),
                ),
              ),
              Categories(),
            ],
          ),
        ),
      ),
    );
  }
}

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
   List<Map<String,dynamic>> categories=[
     {"icon": "assets/chicken.svg", "text": "chicken"},
     {"icon": "assets/drinks.svg", "text": "drinks"},
     {"icon": "assets/food.svg", "text": "food"},
     {"icon": "assets/meat.svg", "text": "meat"},
     {"icon": "assets/milk.svg", "text": "milk"},
   ];
   return Padding(
     padding: const EdgeInsets.all(20),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
       ...List.generate(categories.length, (index) => CategoryCard(
         icon: categories[index]["icon"],
         text: categories[index]["text"],
         press: (){
           Navigator.push(context,
               MaterialPageRoute(builder: (context)=>const Home()));
         }
       ))
       ],
     ),
   );
  }
}

class CategoryCard extends StatelessWidget {
  final String icon;
  final String text;
  final VoidCallback press;

  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: GestureDetector(
              onTap: press, // Call the press callback when tapped
              child: Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(icon),
              ),
            ),
          ),
          const SizedBox(height: 5,),
          Text(text, textAlign: TextAlign.center),
          const SizedBox(height:10),
        ],
      ),
    );
  }
}

