import 'package:cloud_firestore/cloud_firestore.dart';

//db es el acceso a la base de datos
FirebaseFirestore db = FirebaseFirestore.instance;

//Future porque es algo que sucedera
Future<List> getDatos() async {
  List datos = [];

  //Acá se accede a la colección existente en firestore
  CollectionReference expenses = db.collection("expenses");

  //esta linea trae toda la información de la colección
  //QuerySnapshot representa el resultado de una consulta a la base de datos.
  QuerySnapshot queryExpenses = await expenses.get();

  for (var element in queryExpenses.docs) {
    datos.add(element);
  }
  Future.delayed(const Duration(seconds: 2));

  return datos;
}
