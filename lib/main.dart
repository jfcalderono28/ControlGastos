import 'package:flutter/material.dart';
import 'package:control_gastos1/bar%20graph/bar_graph.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//Importaciones Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:control_gastos1/services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<double> weeklySummary = [
    4500.0,
    15000.0,
    0.0,
    25000.0,
    7500.0,
    3250.0,
    11500.0
  ];
  late PageController _controller;
  int currentPage = 9;

  @override
  void initState() {
    super.initState();

    _controller =
        PageController(initialPage: currentPage, viewportFraction: 0.33);
  }

  Widget _bottomAction(IconData icon) {
    return InkWell(
      child: Icon(icon),
      onTap: () {},
    );
  }

  Widget _body() {
    return SafeArea(
      child: Column(
        children: [
          _search(),
          _selector(),
          _expenses(),
          Container(
            color: Colors.grey[300],
            height: 8.0,
          ),
          _graph(),
          Container(
            color: Colors.grey[300],
            height: 8.0,
          ),
          _list(),
        ],
      ),
    );
  }

  Widget _pageItem(String name, int index) {
    Alignment alignment;
    const selected = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    const unselected = TextStyle(fontWeight: FontWeight.normal);
    if (index == currentPage) {
      alignment = Alignment.center;
    } else if (index < currentPage) {
      alignment = Alignment.centerLeft;
    } else if (index > currentPage) {
      alignment = Alignment.centerRight;
    } else {
      alignment = Alignment.topCenter;
    }
    return Align(
      alignment: alignment,
      child: Text(
        name,
        style: index == currentPage ? selected : unselected,
      ),
    );
  }

  Widget _search() {
    return SizedBox(
      height: 50.0,
      child: FutureBuilder(
        future: getDatos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Text((snapshot.data?[index]["category"]).toString());
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _selector() {
    return SizedBox.fromSize(
      size: const Size.fromHeight(40.0),
      child: PageView(
        onPageChanged: (newPage) {
          setState(() {
            currentPage = newPage;
          });
        },
        controller: _controller,
        children: [
          _pageItem("Enero", 0),
          _pageItem("Febrero", 1),
          _pageItem("Marzo", 2),
          _pageItem("Abril", 3),
          _pageItem("Mayo", 4),
          _pageItem("Junio", 5),
          _pageItem("Julio", 6),
          _pageItem("Agosto", 7),
          _pageItem("Septiembre", 8),
          _pageItem("Octubre", 9),
          _pageItem("Noviembre", 10),
          _pageItem("Diciembre", 11),
        ],
      ),
    );
  }

  Widget _expenses() {
    return const Column(
      children: [
        Text(
          "4123",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
        Text("Total expenses")
      ],
    );
  }

  Widget _graph() {
    return SizedBox(
        height: 300, child: MyBarGraph(weeklySummary: weeklySummary));
  }

  Widget _item(IconData icono, String name, int percente, double value) {
    return ListTile(
      leading: Icon(
        icono,
        size: 40,
      ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text("$percente% of expenses"),
      trailing: Container(
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 112, 159, 240),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              "\$ $value",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          )),
    );
  }

  Widget _list() {
    return Expanded(
        child: ListView.separated(
      itemCount: 15,
      itemBuilder: (BuildContext context, index) =>
          _item(FontAwesomeIcons.shop, "Shooping", 14, 4550.0),
      separatorBuilder: (context, index) {
        return Container(
          color: Colors.grey[300],
          height: 8.0,
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5.0,
        shape: const CircularNotchedRectangle(),
        height: 50,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _bottomAction(Icons.stacked_bar_chart_sharp),
            _bottomAction(FontAwesomeIcons.chartPie),
            const SizedBox(height: 0.5),
            _bottomAction(FontAwesomeIcons.wallet),
            _bottomAction(FontAwesomeIcons.toolbox)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      body: _body(),
    );
  }
}
