import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
//traemos el archivo para poder llamarlo luego
import 'homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Bienvenida(),
      //const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

//cada clase es una pantalla en nuestra aplicación
class Bienvenida extends StatefulWidget {
  @override
  _BienvenidaState createState() => _BienvenidaState();
}

class _BienvenidaState extends State<Bienvenida> {
  @override
  Widget build(BuildContext context) {
    //final color = Colors.white;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.grey,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  //color: Colors.white,
                  child: Text('TRIKI',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Arcade',
                          fontSize: 70)),
                ),
                //Aqui podemos poner el Avatar.glow para que nuestra foto se vea fancy
                AvatarGlow(
                  child: CircleAvatar(
                    //circle avatar nos permite centrar el contenido hacia un circulo.
                    child: Container(
                      margin: EdgeInsets.only(top: 40, bottom: 20),
                      child: Image.asset(
                        'assets/squirtle.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    radius: 100,
                    backgroundColor: Colors.transparent,
                  ),
                  //aqui modificamos el radio de las ondas
                  endRadius: 180,
                  repeat: true,
                  duration: Duration(seconds: 1),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)),
                  child: TextButton(
                      onPressed: () {
                        //Navigator es widget que nos permite navegar entre pantallas
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage(
                                    title: '',
                                  )),
                        );
                      },
                      child: Text(
                        'Jugar!!',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Arcade',
                            fontSize: 25),
                      )),
                )
              ],
            ),
          )),
    );
  }
}
