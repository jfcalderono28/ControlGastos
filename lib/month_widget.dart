import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'bar graph/bar_graph.dart';

class MonthWidget extends StatefulWidget {
  final List<DocumentSnapshot> documents;
  final double total;
  final List<double> perDay;
  MonthWidget({Key? key, required this.documents})
      : total = documents.map((doc) => doc['value']).fold(0.0, (a, b) => a + b),
        perDay = List.generate(15, (int index) {
          return documents
              .where((doc) => doc['day'] == (index + 1))
              .map((doc) => doc['value'])
              .fold(0.0, (a, b) => a + b);
        }),
        super(key: key);

  @override
  State<MonthWidget> createState() => _MonthWidgetState();
}

class _MonthWidgetState extends State<MonthWidget> {
  List<double> weeklySummary = [
    4500.0,
    15000.0,
    0.0,
    25000.0,
    7500.0,
    3250.0,
    11500.0
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          _expenses(),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [Expanded(child: _graph())],
          ),
          Container(
            color: Colors.blueAccent,
            height: 4.0,
          ),
          _list()
        ],
      ),
    );
  }

  Widget _expenses() {
    return Column(
      children: [
        Text(
          "\$${widget.total.toString()}",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
        const Text("Total expenses")
      ],
    );
  }

  Widget _graph() {
    return SizedBox(height: 300, child: MyBarGraph(data: widget.perDay));
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
}
