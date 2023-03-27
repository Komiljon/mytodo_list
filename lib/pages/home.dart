import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _userToDo = '';
  List todoList = [];

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();
    //initFirebase();
    //todoList.addAll(['Купить молоко', 'Купить творог', 'Купить картошку']);
  }

  void _menuOpen(){
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context){
          return Scaffold(
              appBar: AppBar(
                title: Text('Меню'),
                backgroundColor: Colors.red,
              ),
              body:Row(
                children: [
                  ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                      },
                      child: Text('На главную'),
                  ),
                  Padding(padding: EdgeInsets.only(left:15)),
                  Text('Простое меню')
                ],
              )
          );
        })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title:Text('Список дел'),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            onPressed: _menuOpen,
            icon: Icon(Icons.menu_outlined),
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          if(!snapshot.hasData) return Text('Нет данных');
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (BuildContext context, int index){
              return Dismissible(
                key: Key(snapshot.data?.docs[index].id),
                child: Card(
                  child: ListTile(
                    title: Text(snapshot.data?.docs[index].get('item')),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete_sweep,
                        color: Colors.deepOrangeAccent,
                      ),
                      onPressed: (){
                        FirebaseFirestore.instance.collection('items').doc(snapshot.data?.docs[index].id).delete();
                      },
                    ),
                  ),
                ),
                onDismissed: (direction){
                  FirebaseFirestore.instance.collection('items').doc(snapshot.data?.docs[index].id).delete();
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: (){
          showDialog(context: context, builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Добавить элемент'),
              content: TextField(
                onChanged: (String value){
                  _userToDo = value;
                },
              ),
              actions: [
                ElevatedButton(
                    onPressed: (){
                      FirebaseFirestore.instance.collection('items').add({'item': _userToDo});
                      Navigator.of(context).pop();
                    },
                    child: Text('Добавить')
                )
              ],
            );
          });
        },
        child: Icon(
          Icons.add_box,
          color: Colors.white,
        ),
      ),
    );
  }
}
