import 'dart:convert';
import 'dart:math';
import 'package:demoapi/loading.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> item = [];
  bool datafetched = false;
  late int randomeid;
  late Image currimg;
  @override
  void initState() {
  
    super.initState();
    randomeid = Random().nextInt(51);
    fetchdata();
  }

  void fetchdata() async {
 
    const Url = 'https://naruto-api-rsl3.onrender.com/api/v1/characters';
    final uri = Uri.parse(Url);
    final data = await http.get(uri);
    final body = data.body;
    final json = jsonDecode(body);
    setState(() {
      item = json;
    });
    loadimage();
  }

  void loadimage() {
    Image image =
        Image.network(item[randomeid]["images"][0], fit: BoxFit.cover);
    image.image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool syncCall) {
      if (mounted) {
        setState(() {
          currimg = image;
          datafetched = true;
        });
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        darkTheme: ThemeData.dark().copyWith(
            elevatedButtonTheme: const ElevatedButtonThemeData(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 0, 46, 252)),
                    textStyle: MaterialStatePropertyAll(TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w600))))),
        home: Scaffold(
          appBar: AppBar(
            toolbarHeight: 90,
            centerTitle: true,
            title: SizedBox(
                width: 250,
                height: 200,
                child: Image.asset("Assets/naruto.png")),
          ),
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: 500,
                    width: double.infinity,
                    child: !datafetched
                        ? const Loading()
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(200)),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(255, 30, 45, 255),
                                          blurRadius: 10),
                                      BoxShadow(
                                          color: Color.fromARGB(255, 177, 0, 0),
                                          blurRadius: 6),
                                    ]),
                                width: 300,
                                height: 300,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(200),
                                  child: currimg,
                                ),
                              ),
                              Text(
                                '${item[randomeid]["name"]}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 55,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 253, 110)),
                              )
                            ],
                          )),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      
                      shadowColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 255, 17, 0))),
                      onPressed: () async {
                        setState(() {
                          datafetched = false;
                          randomeid = Random().nextInt(51);
                        });
                        loadimage();
                      },
                      child: const Text(
                        "Next Character",
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        ));
  }
}
