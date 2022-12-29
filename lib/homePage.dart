import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //estas variables ayudan a llevar la puntuacion de cada jugador
  int puntuacionX = 0;
  int puntuacionY = 0;
  List<String> mostrarXO = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    ''
  ]; //esta lista guarda el triki
  bool turno = false; //esta variable permite saber el turno actual
  //falso <-- x verdadero <-- o
  int espacios_libres = 9; //contador de espacios, para el caso de empate
  //el metodo del gestureDetector
  void _tocado(int index) {
    print('tocando alguna casilla');
    //Aqui pondremos que se cambie la variable que muestra X o O
    //para que el cambio se vea debemos usar setState()
    setState(() {
      //le decimos que en el indice index ponga una x en esa posicion

      //con la variable de turno, solo verificamos su valor y marcamos
      if (turno && mostrarXO[index] == '') {
        //si turno == true, es el turno de los o
        mostrarXO[index] = 'o';
        //actualizamos el turno
        turno = false;
        espacios_libres--; //esto es lo mismo que decir espacios_libres = espacios_libres-1;
      } else if (!turno && mostrarXO[index] == '') {
        //sino, es el turno de los x
        mostrarXO[index] = 'x';
        //actualizamos el turno
        turno = true;
        espacios_libres--;
      }
      //o que no deje poner nada mas
      //verificamos el juego cada vez que tocamos un numero
      print('Espacios libres ' + espacios_libres.toString());
      _verificarJuego();
    });
  }

  //este metodo muestra el ganador y reinicia el juego
  void _mostrarDialogo(String ganador) {
    //antes de poner una respuesta miramos si es empate o no
    String respuesta = '';
    if (ganador != 'x' && ganador != 'o') {
      respuesta = 'Es un empate';
    } else {
      respuesta = 'El jugador con  ' + ganador + ' \nHa ganado';
    }
    showDialog(
        //esto evita que se cierre el dialogo si se toca en otra parte fuera de este
        barrierDismissible: false,
        context: context,
        //aqui ponemos lo que se va a mostrar
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(respuesta,
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            //El titulo va encima del contenido
            content: const Text('Presiona reiniciar para jugar de nuevo',
                style: TextStyle(fontSize: 20)),
            //las actions son la parte con la que el usuario interactua
            actions: [
              TextButton(
                  onPressed: () {
                    //en este metodo borramos la lista y desaparecemos el dialogo
                    setState(() {
                      //actualizamos las puntuaciones
                      if (ganador == 'x') {
                        puntuacionX += 1; //puntuacion = puntuacion+1
                      } else if (ganador == 'o') {
                        puntuacionY += 1;
                      }

                      mostrarXO = ['', '', '', '', '', '', '', '', ''];
                      espacios_libres = 9;
                    });
                    //Cerramos el dialogo
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Reiniciar',
                    style: TextStyle(color: Colors.orange, fontSize: 20),
                  ))
            ],
          );
        });
  }

  void _verificarJuego() {
    print('verificando');
    bool alguien_gano = false;
    //esta variable la marcaremos como verdadera si alguien gano
    //tenemos 8 casos donde puede ganar alguien

    //casos horizontales
    if (mostrarXO[0] == mostrarXO[1] &&
        mostrarXO[0] == mostrarXO[2] &&
        mostrarXO[0] != '') {
      //si la primera fila es igual
      print('ha ganado ' + mostrarXO[0]);
      alguien_gano = true;
      _mostrarDialogo(mostrarXO[0]);
    }
    if (mostrarXO[3] == mostrarXO[4] &&
        mostrarXO[3] == mostrarXO[5] &&
        mostrarXO[3] != '') {
      //si la segunda fila es igual
      print('ha ganado ' + mostrarXO[3]);
      alguien_gano = true;
      _mostrarDialogo(mostrarXO[3]);
    }
    if (mostrarXO[6] == mostrarXO[7] &&
        mostrarXO[6] == mostrarXO[8] &&
        mostrarXO[6] != '') {
      //si la tercera fila es igual
      print('ha ganado ' + mostrarXO[6]);
      alguien_gano = true;
      _mostrarDialogo(mostrarXO[6]);
    }
    //casos verticales
    if (mostrarXO[0] == mostrarXO[3] &&
        mostrarXO[0] == mostrarXO[6] &&
        mostrarXO[0] != '') {
      //si la primera columna es igual
      print('ha ganado ' + mostrarXO[0]);
      alguien_gano = true;
      _mostrarDialogo(mostrarXO[0]);
    }

    if (mostrarXO[1] == mostrarXO[4] &&
        mostrarXO[1] == mostrarXO[7] &&
        mostrarXO[1] != '') {
      //si la segunda columna es igual
      print('ha ganado ' + mostrarXO[1]);
      alguien_gano = true;
      _mostrarDialogo(mostrarXO[1]);
    }

    if (mostrarXO[2] == mostrarXO[5] &&
        mostrarXO[2] == mostrarXO[8] &&
        mostrarXO[2] != '') {
      //si la tercera columna es igual
      print('ha ganado ' + mostrarXO[2]);
      alguien_gano = true;
      _mostrarDialogo(mostrarXO[2]);
    }

    //casos diagonales
    if (mostrarXO[0] == mostrarXO[4] &&
        mostrarXO[0] == mostrarXO[8] &&
        mostrarXO[0] != '') {
      print('ha ganado ' + mostrarXO[0]);
      alguien_gano = true;
      _mostrarDialogo(mostrarXO[0]);
    }
    if (mostrarXO[6] == mostrarXO[4] &&
        mostrarXO[6] == mostrarXO[2] &&
        mostrarXO[6] != '') {
      print('ha ganado ' + mostrarXO[6]);
      alguien_gano = true;
      _mostrarDialogo(mostrarXO[6]);
    }

    if (espacios_libres == 0 && alguien_gano == false) {
      //mientras haya espacios libres
      print('tenemos un empate');
      _mostrarDialogo('Its a tie');
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.

    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      //appBar: AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      //title: Text(widget.title),
      //),
      backgroundColor: Colors.grey, //cambialo por el que le guste a ella

      body: Column(
        children: [
          Container(
            height: 150,
            //alinea al texto hacia el centro
            alignment: Alignment.center,
            //le da un top margin de 50
            margin: EdgeInsets.only(top: 50),
            child: const Text(
              'Puntuaciones',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Arcade'),
            ),
          ),
          Container(
              height: 120,
              child: Column(
                //centra horizonalmente los hijos
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //row nos permite tener una fila de elementos
                  Text(
                    //aqui ponemos la puntuacion, como es un numero tenemos que convertirlo a texto
                    'Jugador X: ' + puntuacionX.toString(),
                    style: TextStyle(fontSize: 20, fontFamily: 'Arcade'),
                  ),
                  Text(
                    'Jugador O: ' + puntuacionY.toString(),
                    style: TextStyle(fontSize: 20, fontFamily: 'Arcade'),
                  )
                ],
              )),
          Expanded(
            flex: 2,
            //los widgets expanded nos ayudan a aprovechar el espacio disponible
            child: GridView.builder(
                padding: const EdgeInsets.all(15),

                //el padding hace que se vea menos lleno
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //cross <-- eje x main <-- eje y Spacing nos permite fijar el espacio entre ellos
                    crossAxisCount: 3,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2),
                //aqui aclaramos que nuestra rejilla es de 3x3
                itemCount: 9,
                //el codigo de arriba nos indica que son 3 cuadritos que se harán por fila
                itemBuilder: (BuildContext context, int index) {
                  //item builder es la parte donde especificamos que tiene que haber en cada
                  //cuadrito
                  //le decimos que sea un container que tiene un texto (con un numero dado)
                  return GestureDetector(
                    //ontap es la propiedad en la que se define el metodo que se ejecutara
                    //cuando hagas algun gesto
                    onTap: () {
                      //esto se hace de esta forma por que ontap no debe recibir parametros
                      _tocado(index);
                    },
                    child: Container(
                      child: Center(
                        child: Text(
                          //en el widget de texto aclaramos como debe ser esto, color y fuente
                          mostrarXO[index],
                          //index.toString(),
                          //index.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontFamily: 'Arcade'),
                        ),
                      ), //decoracion del contenedor
                      decoration: BoxDecoration(
                        //le damos mayor grosor al juego
                        border: Border.all(color: Colors.black, width: 3),
                        //color: Colors.red
                      ),
                    ),
                  );
                }),
          ),
          Container(
            //en este contenedor está el botón para reiniciar el juego
            decoration: BoxDecoration(
                //aqui le damos un color gris y border radius
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)),
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(bottom: 50),
            child: TextButton(
              child: Text('Limpiar Tablero',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontFamily: 'Arcade',
                      fontWeight: FontWeight.w400)),
              onPressed: () {
                //esta funcion inicia el juego de nuevo
                setState(() {
                  mostrarXO = ['', '', '', '', '', '', '', '', ''];
                  espacios_libres = 9;
                });
              },
            ),
          )
        ],
      ),

      /* floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      */ // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
