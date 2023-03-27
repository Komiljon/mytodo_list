import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title:Text('Список дел'),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: Column(
          children: [
            Text('Main Screen', style: TextStyle(color:Colors.white),),
            ElevatedButton(
                onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(context, '/todo', (route)=>true);
                },
                child: Text('Перейти к списку'),
            )
          ],
        )
    );
  }
}
